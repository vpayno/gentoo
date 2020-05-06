# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Python based U2F host library"
HOMEPAGE="https://github.com/google/pyu2f"
# pypi tarball lacks unit tests
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz -> ${P}.tar.gz"
SRC_URI="https://github.com/google/pyu2f/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND="
	>=dev-python/six-1.14.0[${PYTHON_USEDEP}]
"
BDEPEND="
	${RDEPEND}
	test? (
		>=dev-python/pyfakefs-3.7.2[${PYTHON_USEDEP}]
		>=dev-python/mock-3.0.5-r1[${PYTHON_USEDEP}]
		>=dev-python/unittest2-1.1.0[${PYTHON_USEDEP}]
	)
"

DOCS=( CONTRIBUTING.md README.md )

distutils_enable_tests pytest

python_prepare_all() {
	sed -e 's:json.loads(communicate_json):json.loads(communicate_json.decode()):' \
		-i pyu2f/tests/customauthenticator_test.py || die

	find ./pyu2f -name '*.py' -type f -exec sed -i -e 's/logger.warn/logger.warning/g' {} \; || die

	find ./pyu2f/tests -name '*.py' -type f -exec sed -i \
		-e 's/assertEquals/assertEqual/g' \
		-e 's/CreateDirectory/create_dir/g' \
		-e 's/CreateFile/create_file/g' \
		-e 's/SetContents/set_contents/g' \
		-e 's/RemoveObject/remove_object/g' \
		-e 's/assertRaisesRegexp/assertRaisesRegex/g' {} \; || die

	distutils-r1_python_prepare_all
}
