# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Python based U2F host library"
HOMEPAGE="https://github.com/google/google-reauth-python"
SRC_URI="https://github.com/google/google-reauth-python/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND="
	>=dev-python/oauth2client-4.1.3[${PYTHON_USEDEP}]
	>=dev-python/pyu2f-0.1.4[${PYTHON_USEDEP}]
	>=dev-python/six-1.14.0[${PYTHON_USEDEP}]
"
BDEPEND="
	${RDEPEND}
	test? (
		>=dev-python/mock-3.0.5-r1[${PYTHON_USEDEP}]
	)
"

DOCS=( CHANGELOG.rst CONTRIBUTING.rst README.rst )

distutils_enable_tests pytest

python_prepare_all() {
	sed -e "s:'some_origin'.encode('ascii'):'some_origin':" \
		-e "s:SignResponse('key_handle', 'resp',:SignResponse('key_handle'.encode(), 'resp'.encode(),:" \
		-i tests/test_reauth.py || die

	distutils-r1_python_prepare_all
}
