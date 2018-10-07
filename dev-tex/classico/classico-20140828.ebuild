# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit latex-package

DESCRIPTION="TeX support for four URW Classico fonts"
HOMEPAGE="https://www.ctan.org/tex-archive/fonts/urw/classico"
SRC_URI="http://mirrors.ctan.org/install/fonts/urw/classico.tds.zip"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-texlive/texlive-latexextra"
DEPEND="app-arch/unzip"

SUPPLIER="urw"

S=${WORKDIR}

src_install() {
	insinto ${TEXMF}
	doins -r tex || die
	doins -r fonts || die

	cd "${S}/doc/fonts/classico"
	dodoc README
	if use doc; then
		insinto /usr/share/doc/${PF}/texdoc
		doins classico-samples.pdf || die
		dosym /usr/share/doc/${PF}/texdoc ${TEXMF}/doc/latex/${PN} || die
	fi
}

pkg_postinst() {
	updmap-sys --enable Map ${PN}.map
}

pkg_postrm() {
	updmap-sys --disable ${PN}.map
}
