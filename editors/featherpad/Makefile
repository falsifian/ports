# $OpenBSD: Makefile,v 1.19 2020/12/21 22:26:10 bcallah Exp $

COMMENT =	lightweight Qt5 plain-text editor
PKGNAME =	featherpad-${GH_TAGNAME:S/^V//}
CATEGORIES =	editors x11

GH_ACCOUNT =	tsujan
GH_PROJECT =	FeatherPad
GH_TAGNAME =	V0.16.0

MAINTAINER =	Brian Callahan <bcallah@openbsd.org>

# GPLv3+
PERMIT_PACKAGE =	Yes

WANTLIB += ${COMPILER_LIBCXX} ICE Qt5Core Qt5Gui Qt5Network Qt5PrintSupport
WANTLIB += Qt5Svg Qt5Widgets Qt5X11Extras SM X11 Xext c hunspell-1.7
WANTLIB += m

MODULES =	devel/cmake \
		x11/qt5

LIB_DEPENDS =	textproc/hunspell \
		x11/qt5/qtsvg \
		x11/qt5/qtx11extras

RUN_DEPENDS =	devel/desktop-file-utils \
		x11/gtk+3,-guic

CONFIGURE_ARGS =	-DCMAKE_CXX_FLAGS="${CXXFLAGS} -I${LOCALBASE}/include" \
			-DCMAKE_INSTALL_PREFIX="${PREFIX}"

NO_TEST =	Yes

.include <bsd.port.mk>
