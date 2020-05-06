# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Google Authentication Library"
HOMEPAGE="https://github.com/GoogleCloudPlatform/google-auth-library-python https://pypi.org/project/google-auth/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

RDEPEND="
	>=dev-python/cachetools-4.1.0[${PYTHON_USEDEP}]
	>=dev-python/namespace-google-1[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-0.4.8[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-modules-0.2.8[${PYTHON_USEDEP}]
	>=dev-python/rsa-4.0[${PYTHON_USEDEP}]
	>=dev-python/six-1.14.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	test? (
		>=dev-python/flask-1.1.2[${PYTHON_USEDEP}]
		>=dev-python/freezegun-0.3.15[${PYTHON_USEDEP}]
		>=dev-python/mock-3.0.5-r1[${PYTHON_USEDEP}]
		>=dev-python/oauth2client-4.1.3[${PYTHON_USEDEP}]
		>=dev-python/pytest-localserver-0.5.0[${PYTHON_USEDEP}]
		>=dev-python/responses-0.10.7[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_prepare() {
	# delete stray files included in the tarball
	find "${S}"/tests -name '*.pyc' -delete || die
	distutils-r1_src_prepare
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -name '*.pth' -delete || die
}
