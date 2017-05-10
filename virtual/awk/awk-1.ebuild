# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Virtual for awk implementation"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux ~x86-macos"

RDEPEND="
	|| (
		>=sys-apps/gawk-4.0.1-r1
		sys-apps/mawk
		sys-apps/nawk
		app-busybox/awk
	)
	!<sys-apps/gawk-4.0.1-r1" #before 4.0.1-r1 awk symlinks did belong to gawk #455696
