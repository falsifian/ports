# $OpenBSD: Makefile,v 1.4 2021/01/04 14:06:33 sthen Exp $

COMMENT =		convex optimization package

MODPY_EGG_VERSION =	1.2.3
DISTNAME =		cvxopt-${MODPY_EGG_VERSION}
PKGNAME =		py-${DISTNAME}
CATEGORIES =		math
REVISION =		2

MAINTAINER =		Paul Irofti <paul@irofti.net>

# GPLv3
PERMIT_PACKAGE =	Yes

MODULES =		lang/python

FLAVORS =		python3
FLAVOR =		python3

LIB_DEPENDS =		math/lapack \
			math/blas \
			math/suitesparse


MODPY_PI =		Yes
MODPY_SETUPTOOLS =	Yes
MODPY_PYTEST =		Yes

.include <bsd.port.mk>
