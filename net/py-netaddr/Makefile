# $OpenBSD: Makefile,v 1.10 2021/01/16 17:26:16 abieber Exp $

COMMENT =		network address representation and manipulation library

MODPY_EGG_VERSION =	0.7.19
DISTNAME =		netaddr-${MODPY_EGG_VERSION}
PKGNAME =		py-${DISTNAME}
REVISION =		2

CATEGORIES =		net

HOMEPAGE =		http://github.com/drkjam/netaddr/

# MIT
PERMIT_PACKAGE =	Yes

MODULES =		lang/python
MODPY_PI =		Yes
MODPY_SETUPTOOLS =	Yes
MODPY_PYTEST =		Yes

FLAVOR ?=
FLAVORS =		python3

post-install:
	mv ${PREFIX}/bin/netaddr ${PREFIX}/bin/netaddr${MODPY_BIN_SUFFIX}

.include <bsd.port.mk>
