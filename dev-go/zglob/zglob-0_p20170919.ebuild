# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGO_PN=github.com/mattn/go-zglob

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64"
	EGIT_COMMIT=4ecb59231939b2e499b1f2fd8f075565977d2452
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Unix-optimized file globbing and directory walking for Go"
HOMEPAGE="https://${EGO_PN}"
LICENSE="MIT"
SLOT="0/${PVR}"
RDEPEND=""

src_compile() {
	EGO_PN="${EGO_PN}/cmd/zglob" golang-build_src_compile
}

src_install() {
	dobin zglob

	golang-build_src_install

	pushd "src/${EGO_PN}" || die
	einstalldocs
	popd || die
}
