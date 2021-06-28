# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/stlehmann/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/stlehmann/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 ~arm ~arm64 x86"
fi

DESCRIPTION="A Flask extension for Message Queue Telemetry Transport (MQTT)"
HOMEPAGE="https://github.com/stlehmann/Flask-MQTT https://pypi.org/project/Flask-MQTT/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"

BDEPEND="test? ( app-misc/mosquitto )"
RDEPEND="
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/paho-mqtt[${PYTHON_USEDEP}]
"

distutils_enable_tests setup.py
distutils_enable_sphinx docs \
	dev-python/sphinx_rtd_theme
