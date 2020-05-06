# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="OAuth 2.0 plugin for Google Cloud Storage credentials in the Boto library"
HOMEPAGE="https://pypi.org/project/gcs-oauth2-boto-plugin/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

PATCHES=(
	"${FILESDIR}/${PN}-1.13-use-friendy-version-checks.patch"
)

# Keep versions in sync with setup.py.
RDEPEND="
	${PYTHON_DEPS}
	>=dev-python/PySocks-1.7.1[${PYTHON_USEDEP}]
	>=dev-python/boto-2.49.0[${PYTHON_USEDEP}]
	>=dev-python/google-reauth-python-0.1.0[${PYTHON_USEDEP}]
	>=dev-python/httplib2-0.17.0[${PYTHON_USEDEP}]
	>=dev-python/oauth2client-4.1.3[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-19.1.0[${PYTHON_USEDEP}]
	>=dev-python/retry-decorator-1.1.1[${PYTHON_USEDEP}]
	>=dev-python/six-1.14.0[${PYTHON_USEDEP}]
"
BDEPEND="
	${PYTHON_DEPS}
	${RDEPEND}
	test? (
		>=dev-python/freezegun-0.3.15[${PYTHON_USEDEP}]
	)
"

python_prepare_all() {
	distutils-r1_python_prepare_all
	sed -i \
		-e '/SocksiPy-branch/d' \
		setup.py || die
	# Make sure the unittests aren't installed.
	mv gcs_oauth2_boto_plugin/test_oauth2_client.py ./ || die
}

python_test() {
	${EPYTHON} "${S}"/test_oauth2_client.py -v || die "tests failed for ${EPYTHOH}"
}
