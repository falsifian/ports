# $OpenBSD: Makefile,v 1.24 2021/01/09 10:36:33 sthen Exp $

COMMENT =	self-contained cryptographic library for Python

MODPY_EGG_VERSION =	3.9.9
DISTNAME =	pycryptodome-${MODPY_EGG_VERSION}
PKGNAME =	py-${DISTNAME:S/py//}
REVISION =	1

CATEGORIES =	security

HOMEPAGE =	https://www.pycryptodome.org

MAINTAINER =	Jasper Lievisse Adriaanse <jasper@openbsd.org>

# BSD + Public Domain
PERMIT_PACKAGE =	Yes

WANTLIB +=		pthread
MODULES =		lang/python

FLAVORS =		python3
FLAVOR ?=

MODPY_PI =		Yes
MODPY_SETUPTOOLS =	Yes

RUN_DEPENDS =		devel/gmp

.include <bsd.port.arch.mk>
.if ${MACHINE_ARCH:Mamd64} || ${MACHINE_ARCH:Mi386}
PKG_ARGS+= -Daesni=1
.else
PKG_ARGS+= -Daesni=0
.endif

.include <bsd.port.mk>
