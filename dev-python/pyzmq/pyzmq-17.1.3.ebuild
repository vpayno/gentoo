# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )
PYTHON_REQ_USE="threads(+)"

inherit flag-o-matic distutils-r1 toolchain-funcs

DESCRIPTION="Lightweight and super-fast messaging library built on top of the ZeroMQ library"
<<<<<<< HEAD
HOMEPAGE="https://www.zeromq.org/bindings:python https://pypi.org/project/pyzmq/"
=======
HOMEPAGE="http://www.zeromq.org/bindings:python https://pypi.org/project/pyzmq/"
>>>>>>> 670c2d511b5... dev-python/pyzmq: bump version to 19.0.0
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~mips ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
<<<<<<< HEAD
IUSE="doc +draft test"
=======
IUSE="doc test"
>>>>>>> 670c2d511b5... dev-python/pyzmq: bump version to 19.0.0
RESTRICT="!test? ( test )"

RDEPEND="
	>=net-libs/zeromq-4.2.2-r2:=[drafts]
	dev-python/py[${PYTHON_USEDEP}]
	dev-python/cffi:=[${PYTHON_USEDEP}]
<<<<<<< HEAD
=======
	dev-python/gevent[${PYTHON_USEDEP}]
>>>>>>> 670c2d511b5... dev-python/pyzmq: bump version to 19.0.0
"
DEPEND="${RDEPEND}
	dev-python/cython[${PYTHON_USEDEP}]
	test? (
<<<<<<< HEAD
=======
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/unittest2[${PYTHON_USEDEP}]
>>>>>>> 670c2d511b5... dev-python/pyzmq: bump version to 19.0.0
		>=www-servers/tornado-5.0.2[${PYTHON_USEDEP}]
	)
	doc? (
		>=dev-python/sphinx-1.3[${PYTHON_USEDEP}]
		dev-python/numpydoc[${PYTHON_USEDEP}]
	)"

<<<<<<< HEAD
PATCHES=(
	"${FILESDIR}/pyzmq-19.0.0-tests.patch"
)

distutils_enable_tests pytest
distutils_enable_sphinx docs \
	"dev-python/numpydoc"
=======
PATCHES=( "${FILESDIR}"/${P}-test_message.patch )
>>>>>>> 670c2d511b5... dev-python/pyzmq: bump version to 19.0.0

python_prepare_all() {
	# Prevent un-needed download during build
	sed -e "/'sphinx.ext.intersphinx',/d" -i docs/source/conf.py || die
<<<<<<< HEAD
	# some tests fail with cffi backend
	rm zmq/tests/asyncio/test_asyncio.py || die

=======
>>>>>>> 670c2d511b5... dev-python/pyzmq: bump version to 19.0.0
	distutils-r1_python_prepare_all
}

python_configure_all() {
	tc-export CC
<<<<<<< HEAD
	append-cppflags -DZMQ_BUILD_DRAFT_API=$(usex draft '1' '0')
=======
	append-cppflags -DZMQ_BUILD_DRAFT_API=1
}

python_compile_all() {
	use doc && emake -C docs html
>>>>>>> 670c2d511b5... dev-python/pyzmq: bump version to 19.0.0
}

python_compile() {
	esetup.py cython --force
<<<<<<< HEAD
	distutils-r1_python_compile
}
=======
	python_is_python3 || local -x CFLAGS="${CFLAGS} -fno-strict-aliasing"
	distutils-r1_python_compile
}

python_test() {
	${EPYTHON} -m pytest -v "${BUILD_DIR}/lib" || die
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/build/html/. )
	distutils-r1_python_install_all
}
>>>>>>> 670c2d511b5... dev-python/pyzmq: bump version to 19.0.0
