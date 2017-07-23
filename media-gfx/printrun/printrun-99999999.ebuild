# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="GUI interface for 3D printing on RepRap and other printers"
HOMEPAGE="https://github.com/kliment/Printrun"
EGIT_REPO_URI="https://github.com/kliment/Printrun.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	app-text/psutils
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pyglet[${PYTHON_USEDEP}]
	dev-python/pyserial[${PYTHON_USEDEP}]
	dev-python/wxpython:*[${PYTHON_USEDEP}]
	media-gfx/cairosvg[${PYTHON_USEDEP}]"

RDEPEND="${DEPEND}"

PATCHES=(
	# https://bugzilla.redhat.com/show_bug.cgi?id=1231518
	"${FILESDIR}"/${PN}-gtk3.patch
)
