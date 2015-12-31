# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE Screenshot Utility"
HOMEPAGE="https://www.kde.org/applications/graphics/ksnapshot/"
KEYWORDS=" ~amd64 ~x86"
IUSE="debug kipi"

DEPEND="
	x11-libs/libXfixes
	!aqua? (
		x11-libs/libX11
		x11-libs/libXext
	)
	kipi? ( $(add_kdeapps_dep libkipi) )
"
RDEPEND="${DEPEND}
	!<kde-plasma/khotkeys-5.4.3-r1
"

PATCHES=( "${FILESDIR}/${P}-install-hotkey-file.patch" )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with kipi)
	)

	kde4-base_src_configure
}
