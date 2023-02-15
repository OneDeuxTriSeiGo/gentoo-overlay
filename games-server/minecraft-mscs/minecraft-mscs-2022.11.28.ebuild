# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1

DESCRIPTION="Server Management Daemon for Minecraft"
HOMEPAGE="https://minecraftservercontrol.github.io/docs/mscs https://github.com/MinecraftServerControl/mscs"
SRC_URI="https://github.com/MinecraftServerControl/mscs/archive/336fb8386f1ddac9df58352323d477c83cba3ba9.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="bash-completion"

MY_PN="mscs"
MY_PV="${PV}"
MY_P="${MY_PN}-336fb8386f1ddac9df58352323d477c83cba3ba9"
S="${WORKDIR}/${MY_P}"

RDEPEND="
	( ~virtual/jre-17 )
	app-admin/sudo
	app-backup/rdiff-backup
	dev-perl/JSON
	dev-perl/libwww-perl
	dev-perl/LWP-Protocol-https
	dev-lang/perl
	net-misc/rsync
	net-misc/socat
	net-misc/wget
	sys-apps/util-linux
"
DEPEND="${RDEPEND}
	acct-group/minecraft
	acct-user/minecraft
"

PATCHES=(
	"${FILESDIR}/${P}.patch"
)

src_prepare() {
	eapply "${PATCHES[@]}"
	eapply_user
}

src_install() {
	newbin msctl msctl
	newbin mscs mscs
	newinitd mscs.initd mscs

	insinto /etc/minecraft-mscs
	doins mscs.defaults

	use bash-completion && newbashcomp mscs.bash-completion ${PN}
}
