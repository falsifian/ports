# $OpenBSD: Makefile,v 1.10 2021/01/10 20:02:07 sthen Exp $

COMMENT=	multi-format tools and Python module for ReplayGain

MODPY_EGG_VERSION= 1.1.0
DISTNAME=	rgain3-${MODPY_EGG_VERSION}
EPOCH=		0

CATEGORIES=	audio

# GPLv2+
PERMIT_PACKAGE=	Yes

MODULES=	lang/python

MODPY_PI=	Yes
MODPY_VERSION=	${MODPY_DEFAULT_VERSION_3}
MODPY_PYTEST=	Yes

BUILD_DEPENDS=	textproc/py-docutils${MODPY_FLAVOR}

RUN_DEPENDS=	audio/py-mutagen${MODPY_FLAVOR} \
		devel/py-gobject3${MODPY_FLAVOR} \
		multimedia/gstreamer1/core \
		multimedia/gstreamer1/plugins-libav \
		multimedia/gstreamer1/plugins-base \
		multimedia/gstreamer1/plugins-good

TEST_DEPENDS=	${BASE_PKGPATH}

.include <bsd.port.mk>
