# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Python library to manipulate Google APIs"
HOMEPAGE="https://github.com/google/apitools"
SRC_URI="https://github.com/google/apitools/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND="
	>=dev-python/fasteners-0.14.1-r1[${PYTHON_USEDEP}]
	>=dev-python/httplib2-0.17.0[${PYTHON_USEDEP}]
	>=dev-python/oauth2client-4.1.3[${PYTHON_USEDEP}]
	>=dev-python/python-gflags-3.1.2-r2[${PYTHON_USEDEP}]
	>=dev-python/six-1.14.0[${PYTHON_USEDEP}]
"
BDEPEND="
	${RDEPEND}
	test? (
		>=dev-python/mock-3.0.5-r1[${PYTHON_USEDEP}]
		>=dev-python/unittest2-1.1.0[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}/apitools-${PV}"

PATCHES=(
	"${FILESDIR}/${PN}-0.5.30-skip-enum-test-on-new-python.patch"
)

distutils_enable_tests nose
