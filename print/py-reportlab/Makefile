# $OpenBSD: Makefile,v 1.15 2021/01/04 14:06:37 sthen Exp $

COMMENT=		PDF-generating toolkit for Python

MODPY_EGG_VERSION=	3.2.0
DISTNAME=		reportlab-${MODPY_EGG_VERSION}
PKGNAME=		py-${DISTNAME}
EPOCH=			0
REVISION=		7

# see patches/patch-setup_py
# grep 'archive =' reportlab-3.2.0/setup.py
PFBFER=			pfbfer-20070710.zip
SUBST_VARS=		FULLDISTDIR PFBFER WRKINST MODPY_SITEPKG
EXTRACT_ONLY=		${DISTNAME}${EXTRACT_SUFX}
DISTFILES=		${DISTNAME}${EXTRACT_SUFX} \
			${PFBFER}:0

CATEGORIES=		print graphics

HOMEPAGE=		http://www.reportlab.com

# BSD, LGPLv2, MPL1.0, MIT
PERMIT_PACKAGE=	Yes

WANTLIB += ${MODPY_WANTLIB} art_lgpl_2 freetype pthread

MASTER_SITES0=		http://www.reportlab.com/ftp/

FLAVORS=		python3
FLAVOR?=

MODULES=		lang/python

MODPY_PI=		Yes
MODPY_PI_DIR=		r/reportlab
MODPY_SETUPTOOLS=	Yes

LIB_DEPENDS=		graphics/libart

.if ${FLAVOR:Mpython3}
RUN_DEPENDS=		graphics/py-Pillow${MODPY_FLAVOR}
.else
RUN_DEPENDS=		graphics/py2-Pillow
.endif
BUILD_DEPENDS=		${RUN_DEPENDS}

# requires network access
TEST_IS_INTERACTIVE=	Yes

pre-configure:
	${SUBST_CMD} ${WRKSRC}/setup.py \
		${WRKSRC}/docs/genAll.py \
		${WRKSRC}/docs/userguide/genuserguide.py

# XXX FLAVOR conflict
#post-install:
#	cd ${WRKSRC}/docs && ${MODPY_BIN} genAll.py
#	${INSTALL_DATA_DIR} ${PREFIX}/share/doc/py-reportlab
#	${INSTALL_DATA} ${WRKBUILD}/docs/reportlab-userguide.pdf \
#		${PREFIX}/share/doc/py-reportlab

do-test:
	cd ${WRKSRC}/tests && \
		${MAKE_ENV} PYTHONPATH=${WRKDIST}:${WRKINST}${MODPY_SITEPKG} \
		${MODPY_BIN} ./runAll.py

.include <bsd.port.mk>
