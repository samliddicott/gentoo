# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/scottdraves/flam3.git"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="https://github.com/scottdraves/flam3/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Tools and a library for creating flame fractal images"
HOMEPAGE="http://flam3.com/"

LICENSE="GPL-3"
SLOT="0"
IUSE="static-libs"

RDEPEND="dev-libs/libxml2
	media-libs/libpng:0
	virtual/jpeg:0
	!<=x11-misc/electricsheep-2.6.8-r2"
DEPEND="${RDEPEND}"

DOCS=( README.txt )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		--enable-shared \
		$(use_enable static-libs static)
}

src_install() {
	default

	rm -v "${D}"usr/lib*/libflam3.la || die

	docinto examples
	dodoc *.flam3
}
