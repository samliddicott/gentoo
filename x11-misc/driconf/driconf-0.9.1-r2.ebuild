# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="xml"

inherit distutils-r1 eutils

DESCRIPTION="driconf is a GTK+2 GUI configurator for DRI"
HOMEPAGE="https://dri.freedesktop.org/wiki/DriConf"
SRC_URI="https://freedesktop.org/~fxkuehl/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	dev-python/pygtk:2[${PYTHON_USEDEP}]
	x11-apps/xdriinfo"
DEPEND="${RDEPEND}"

DOCS="CHANGELOG COPYING PKG-INFO README TODO"

src_prepare() {
	epatch "${FILESDIR}"/${P}-glxinfo-unicode.patch \
		"${FILESDIR}"/${P}-update-toolbar-methods.patch \
		"${FILESDIR}"/${P}-desktop-menu.patch \
		"${FILESDIR}"/${P}-drop-old-tooltips.patch \
		"${FILESDIR}"/${P}-driconf_simpleui.py.patch
	eapply_user

	# Fix install locations which breaks location policy - Josh_B
	sed -i \
		-e 's-/usr/local-/usr-g' \
		driconf \
		driconf.desktop \
		driconf.py \
		setup.cfg \
		setup.py \
		|| die "Sed failed!"

}

src_install() {
	distutils-r1_src_install
	domenu driconf.desktop
}
