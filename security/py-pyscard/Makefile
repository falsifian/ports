# $OpenBSD: Makefile,v 1.5 2021/01/04 14:06:37 sthen Exp $

COMMENT =	smartcard package for Python

MODPY_EGG_VERSION =	2.0.0
DISTNAME =		pyscard-${MODPY_EGG_VERSION}
PKGNAME =		py-${DISTNAME}
REVISION =		0

CATEGORIES =	security

HOMEPAGE =	https://pyscard.sourceforge.io/

# LGPLv2.1+
PERMIT_PACKAGE =	Yes

MODULES =		lang/python
FLAVOR =		python3
FLAVORS =		python3

MODPY_PI =		Yes
MODPY_SETUPTOOLS =	Yes

BUILD_DEPENDS =	devel/swig \
		security/pcsc-lite
RUN_DEPENDS =	security/pcsc-lite

.include <bsd.port.mk>
