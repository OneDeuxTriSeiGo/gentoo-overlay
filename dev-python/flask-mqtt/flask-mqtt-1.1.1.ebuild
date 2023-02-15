# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..11} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

MY_PN="Flask-MQTT"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/stlehmann/${MY_PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/stlehmann/${MY_PN}/archive/${MY_PV}.tar.gz -> ${MY_P}.gh.tar.gz"
	KEYWORDS="-* ~amd64"
fi

DESCRIPTION="A Flask extension for Message Queue Telemetry Transport (MQTT)"
HOMEPAGE="https://github.com/stlehmann/Flask-MQTT https://pypi.org/project/Flask-MQTT/"

LICENSE="MIT"
SLOT="0"

BDEPEND="test? ( app-misc/mosquitto )"
RDEPEND="
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/paho-mqtt[${PYTHON_USEDEP}]
"

distutils_enable_tests setup.py
distutils_enable_sphinx docs \
	dev-python/sphinx_rtd_theme
