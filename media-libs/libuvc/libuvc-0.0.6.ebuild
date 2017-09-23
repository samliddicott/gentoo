# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="A cross-platform library for USB video devices, built atop libusb"
HOMEPAGE="https://int80k.com/libuvc/"
SRC_URI="https://github.com/ktossell/libuvc/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="BSD"
SLOT="0"
IUSE="static-libs"

RDEPEND="
	virtual/jpeg:62
	virtual/libusb:1
	virtual/udev
"
DEPEND="${RDEPEND}"

CMAKE_MIN_VERSION="2.8.0"

DOCS=( changelog.txt README.md )

src_prepare() {
	local libdir="$(get_libdir)"

	sed -r -i \
		-e 's/(CONF_LIBRARY "\$\{CMAKE_INSTALL_PREFIX\}\/)lib/\1'${libdir}'/' \
		-e 's/(INSTALL_CMAKE_DIR "\$\{CMAKE_INSTALL_PREFIX\}\/)lib/\1'${libdir}'/' \
		-e 's/(ARCHIVE DESTINATION "\$\{CMAKE_INSTALL_PREFIX\}\/)lib/\1'${libdir}'/' \
		-e 's/(LIBRARY DESTINATION "\$\{CMAKE_INSTALL_PREFIX\}\/)lib/\1'${libdir}'/' \
		CMakeLists.txt || die

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TARGET=$(usex static-libs Static Shared)
	)

	cmake-utils_src_configure
}
