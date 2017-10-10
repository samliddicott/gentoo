# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# Python is required for tests and some build tasks.
PYTHON_COMPAT=( python2_7 python3_{4,5,6} pypy )

inherit git-r3 python-any-r1 cmake-multilib

DESCRIPTION="Google C++ Testing Framework"
HOMEPAGE="https://github.com/google/googletest"
EGIT_REPO_URI="https://github.com/google/googletest.git"

LICENSE="BSD"
SLOT="0"
IUSE="doc examples test"

DEPEND="test? ( ${PYTHON_DEPS} )"
RDEPEND="!dev-cpp/gmock"

PATCHES=(
	"${FILESDIR}"/${PN}-9999-fix-gcc6-undefined-behavior.patch
	"${FILESDIR}"/${PN}-1.8.0-increase-clone-stack-size.patch
	"${FILESDIR}"/${PN}-1.8.0-fix-odr-violation.patch
)

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

multilib_src_configure() {
	local mycmakeargs=(
		-DBUILD_GMOCK=ON
		-DBUILD_GTEST=ON
		-Dgtest_build_samples=OFF
		-Dgtest_disable_pthreads=OFF
		-DBUILD_SHARED_LIBS=ON

		# tests
		-Dgmock_build_tests=$(usex test)
		-Dgtest_build_tests=$(usex test)
		-DPYTHON_EXECUTABLE="${PYTHON}"
	)
	cmake-utils_src_configure
}

multilib_src_install_all() {
	einstalldocs

	if use doc; then
		docinto googletest
		dodoc -r googletest/docs/*
		docinto googlemock
		dodoc -r googlemock/docs/*
	fi

	if use examples; then
		docinto examples
		dodoc googletest/samples/*.{cc,h}
	fi
}
