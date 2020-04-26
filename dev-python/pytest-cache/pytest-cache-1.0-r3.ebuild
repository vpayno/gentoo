# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} pypy3 )

DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1

DESCRIPTION="mechanisms for caching across test runs"
HOMEPAGE="https://pypi.org/project/pytest-cache/
	https://bitbucket.org/hpk42/pytest-cache/
	https://pythonhosted.org/pytest-cache/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="dev-python/execnet[${PYTHON_USEDEP}]"
BDEPEND="${RDEPEND}"

# https://bitbucket.org/hpk42/pytest-cache/issues/12
RESTRICT=test

distutils_enable_tests pytest
