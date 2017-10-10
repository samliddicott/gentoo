# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils golang-build

DESCRIPTION="Postfix Sender Rewriting Scheme forwarding agent"
#EGO_PN="github.com/zoni/${PN}"
EGO_PN="${PN}"
SRC_URI="https://github.com/zoni/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
HOMEPAGE="https://github.com/zoni/postforward"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-lang/go:0"
RDEPEND="
	mail-filter/postsrsd"

src_prepare() {
	epatch "${FILESDIR}/${PN}_apply-sendmail-path.patch"
	sed -i -e "s/@GENTOO_PORTAGE_EPREFIX@/${EPREFIX}/" *.go

	# go build assumes files will be in src dir, but
	# source files are in root in this package, so move
	# them.
	NEW_SRC_DIR="${S}/src/${EGO_PN}"
	# Freak out if there's already something there because
	# it means the package has changed and we'll need to
	# adjust to it.
	test ! -e "${NEW_SRC_DIR}" || die "${NEW_SRC_DIR} already exists"
	mkdir -p "${NEW_SRC_DIR}" || die
	mv *.go "${NEW_SRC_DIR}" || die
}

# Standard golang-build src_install complains about pkg not
# existing, so we go custom.
src_install() {
	dodoc README.md
	dosbin "${PN}"
}
