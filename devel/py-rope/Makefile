# $OpenBSD: Makefile,v 1.14 2020/10/21 21:15:15 mariani Exp $

COMMENT =		refactoring library

MODPY_EGG_VERSION =	0.18.0
DISTNAME =		rope-${MODPY_EGG_VERSION}
PKGNAME =		py-${DISTNAME}

CATEGORIES =		devel

HOMEPAGE =		https://github.com/python-rope/rope

MAINTAINER =		Elias M. Mariani <marianielias@gmail.com>

# LGPLv3+
PERMIT_PACKAGE =	Yes

MODULES =		lang/python
MODPY_PI =		Yes
MODPY_SETUPTOOLS =	Yes
MODPY_PYTEST =          Yes

FLAVORS =		python3
FLAVOR =		python3

.include <bsd.port.mk>
