# $OpenBSD: Makefile,v 1.10 2021/01/23 17:56:27 thfr Exp $

COMMENT =	library to move calls to Direct3D shaders to OpenGL

# HG_CHANGESET and HG_COMMIT must be kept in sync.
HG_CHANGESET =	1320
HG_COMMIT = 	f9036699b53a

DISTNAME =	mojoshader-${HG_COMMIT}{${HG_COMMIT}}
PKGNAME =	mojoshader-${HG_CHANGESET}
CATEGORIES =	graphics
MASTER_SITES =	https://hg.icculus.org/icculus/mojoshader/archive/

SHARED_LIBS +=	mojoshader		1.0	# Changeset 1303

HOMEPAGE =	https://icculus.org/mojoshader/

MAINTAINER =	Thomas Frohwein <thfr@openbsd.org>

# zlib
PERMIT_PACKAGE =	Yes

WANTLIB += m

MODULES =	devel/cmake

BUILD_DEPENDS =	devel/re2c \
		devel/sdl2 \
		graphics/vulkan-headers

TEST_DEPENDS =	security/p5-Digest-SHA1

# FLIP_VIEWPORT is needed by some FNA games (FEZ if I recall correctly)
CONFIGURE_ARGS =	-DBUILD_SHARED_LIBS=ON \
			-DFLIP_VIEWPORT=1 \
			-DPROFILE_METAL=OFF

CFLAGS +=	-I${LOCALBASE}/include
WRKDIST =	${WRKDIR}/mojoshader-${HG_COMMIT}

SUBST_VARS +=	HG_CHANGESET HG_COMMIT

.include <bsd.port.arch.mk>
.if !${PROPERTIES:Mclang}
CFLAGS +=	-std=gnu99
.endif

do-gen:
	${SUBST_CMD} ${WRKSRC}/CMakeLists.txt

# No upstream install target
do-install:
	${INSTALL_DATA} ${WRKSRC}/mojoshader*.h ${PREFIX}/include
	${INSTALL_DATA} ${WRKBUILD}/libmojoshader.so.${LIBmojoshader_VERSION} \
		${PREFIX}/lib

.include <bsd.port.mk>
