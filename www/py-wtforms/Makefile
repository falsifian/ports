# $OpenBSD: Makefile,v 1.14 2020/12/10 02:20:31 daniel Exp $

COMMENT=	flexible forms validation and rendering library

MODPY_EGG_VERSION=2.1
DISTNAME=	WTForms-${MODPY_EGG_VERSION}
PKGNAME=	py-${DISTNAME:L}
CATEGORIES=	www
REVISION=	2

HOMEPAGE=	http://wtforms.simplecodes.com/

# BSD
PERMIT_PACKAGE=	Yes

MODULES=		lang/python

MODPY_PI =		Yes
EXTRACT_SUFX=		.zip

FLAVORS =		python3
FLAVOR ?=

BUILD_DEPENDS=		${RUN_DEPENDS} \
			textproc/py-sphinx${MODPY_FLAVOR}>=1.5
RUN_DEPENDS=		devel/py-dateutil${MODPY_FLAVOR}

MODPY_SETUPTOOLS=	Yes

USE_GMAKE=		Yes

post-build:
	@cd ${WRKSRC}/docs && \
		${SETENV} ${MAKE_ENV} ${MAKE_PROGRAM} SPHINXBUILD=sphinx-build${MODPY_BIN_SUFFIX} html

post-install:
	${INSTALL_DATA_DIR} ${PREFIX}/share/doc/${MODPY_PY_PREFIX}wtforms
	cd ${WRKSRC}/docs/_build/html && \
		pax -rw * ${PREFIX}/share/doc/${MODPY_PY_PREFIX}wtforms

.include <bsd.port.mk>
