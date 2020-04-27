# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_6 python3_7 python3_8 )
DISTUTILS_USE_SETUPTOOLS="rdepend"

inherit distutils-r1

DESCRIPTION="command line tool for interacting with cloud storage services"
HOMEPAGE="https://github.com/GoogleCloudPlatform/gsutil"
SRC_URI="http://commondatastorage.googleapis.com/pub/${PN}_${PV}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="test"

# needs to talk to Google to run tests
RESTRICT="test"

RDEPEND="
	${PYTHON_DEPS}
	>=dev-python/PySocks-1.7.1[${PYTHON_USEDEP}]
	>=dev-python/argcomplete-1.11.1[${PYTHON_USEDEP}]
	>=dev-python/boto-2.49.0[${PYTHON_USEDEP}]
	>=dev-python/crcmod-1.7-r3[${PYTHON_USEDEP}]
	>=dev-python/fasteners-0.15[${PYTHON_USEDEP}]
	>=dev-python/gcs-oauth2-boto-plugin-2.5[${PYTHON_USEDEP}]
	>=dev-python/google-apitools-0.5.30[${PYTHON_USEDEP}]
	>=dev-python/google-reauth-python-0.1.0[${PYTHON_USEDEP}]
	>=dev-python/httplib2-0.17.0[${PYTHON_USEDEP}]
	>=dev-python/mock-3.0.5-r1[${PYTHON_USEDEP}]
	>=dev-python/monotonic-1.5-r1[${PYTHON_USEDEP}]
	>=dev-python/oauth2client-4.1.3[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-19.1.0[${PYTHON_USEDEP}]
	>=dev-python/retry-decorator-1.0.0-r1[${PYTHON_USEDEP}]
	>=dev-python/six-1.14.0[${PYTHON_USEDEP}]
"
BDEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-4.41-tests.patch"
)

DOCS=( README.md CHANGES.md )

python_prepare_all() {
	distutils-r1_python_prepare_all

	# NB: We don't delete all of boto/ because the tests are imported by the
	# production code.  The same reason we can't delete gslib/tests/.  We can
	# delete the main boto library and use the system version though.
	rm -r gslib/vendored/boto/boto || die

	sed -i \
		-e 's/mock==/mock>=/' \
		-e 's/oauth2client==/oauth2client>=/' \
		-e 's/SocksiPy-branch==/PySocks>=/' \
		setup.py || die
	# Sanity check we didn't miss any updates.
	grep '==' setup.py && die "Need to update version requirements"

	# For debugging purposes, temporarily uncomment this in order to
	# show hidden tracebacks.
	#sed -e 's/^  except OSError as e:$/&\n    raise/' \
	#	-e 's/def _HandleUnknownFailure(e):/&\n  raise/' \
	#	-i gslib/__main__.py || die

	# create_bucket raised ResponseNotReady
	sed -i \
		-e 's/test_cp_unwritable_tracker_file/_&/' \
		-e 's/test_cp_unwritable_tracker_file_download/_&/' \
		gslib/tests/test_cp.py || die

	sed -i -E -e 's/(executable_prefix =).*/\1 [sys.executable]/' \
		gslib/commands/test.py || die

	# IOError: close() called during concurrent operation on the same file object.
	sed -i -e 's/sys.stderr.close()/#&/' \
		gslib/tests/testcase/unit_testcase.py || die
}

python_test() {
	BOTO_CONFIG=${FILESDIR}/dummy.boto \
		${EPYTHON} gslib/__main__.py test -u || die "tests failed for ${EPYTHON}"
}
