# $OpenBSD: Makefile,v 1.41 2020/11/09 15:17:21 jasper Exp $

COMMENT =		pure python IPMI protocol library

MODPY_EGG_VERSION =	1.5.19
DISTNAME =		pyghmi-${MODPY_EGG_VERSION}
PKGNAME =		${DISTNAME:S/py/${MODPY_PY_PREFIX}/}

MAINTAINER =		Jasper Lievisse Adriaanse <jasper@openbsd.org>

CATEGORIES =		sysutils

HOMEPAGE =		https://github.com/openstack/pyghmi

# Apache2
PERMIT_PACKAGE =	Yes

MODULES =		lang/python
MODPY_PI =		Yes
MODPY_SETUPTOOLS =	Yes

FLAVORS =		python3
FLAVOR =		python3

BUILD_DEPENDS =		devel/py-pbr${MODPY_FLAVOR} \
			security/py-cryptography${MODPY_FLAVOR}
RUN_DEPENDS =		devel/py-dateutil${MODPY_FLAVOR} \
			security/py-cryptography${MODPY_FLAVOR}

# Requires unported oslotest
NO_TEST =		Yes

post-install:
.for s in fakebmc pyghmicons pyghmiutil virshbmc
	mv ${PREFIX}/bin/$s{,${MODPY_BIN_SUFFIX}}
.endfor

.include <bsd.port.mk>
