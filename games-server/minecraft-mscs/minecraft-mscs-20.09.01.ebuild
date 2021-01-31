# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Server Management Daemon for Minecraft"
HOMEPAGE="https://minecraftservercontrol.github.io/docs/mscs https://github.com/MinecraftServerControl/mscs"
SRC_URI="https://github.com/MinecraftServerControl/mscs/archive/v.${PV}.tar.gz -> {P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="bash-completion"

MY_PN="mscs"
MY_PV="${PV}"
MY_P="${MY_PN}-v.${MY_PV}"
S="${WORKDIR}/${MY_P}"

RDEPEND="
	( =virtual/jre-1.8* )
	dev-lang/perl
	dev-perl/JSON
	dev-perl/libwww-perl
	dev-perl/LWP-Protocol-https
	net-misc/wget
	net-misc/socat
	net-misc/rsync
	app-backup/rdiff-backup
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

	dodir /etc/minecraft-mscs
	insinto /etc/minecraft-mscs
	doins mscs.defaults

	use bash-completion && newbashcomp mscs.bash-completion ${PN}
}
