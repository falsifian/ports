# $OpenBSD: Makefile,v 1.7 2021/01/29 19:33:43 tracey Exp $

COMMENT =	things proxy daemon for OpenBSD
CATEGORIES =	net

GH_ACCOUNT =	basepr1me
GH_PROJECT =	thingsd
GH_TAGNAME =	3.0.4

MAINTAINER =	Tracey Emery <tracey@traceyemery.net>

# ISC
PERMIT_PACKAGE =	Yes

# uses pledge()
# uses unveil()
WANTLIB += c crypto event pthread ssl tls util

MAKE_FLAGS =	CC="${CC}"

NO_TEST =	Yes

do-configure:
	sed -i 's,/etc/thingsd.conf,${SYSCONFDIR}/thingsd.conf,' \
		${WRKSRC}/thingsd/thingsd.{h,8,conf.5}

post-install:
	${INSTALL_DATA_DIR} ${PREFIX}/share/examples/thingsd
	${INSTALL_DATA} ${WRKSRC}/thingsd/examples/etc/thingsd.conf \
		${PREFIX}/share/examples/thingsd

.include <bsd.port.mk>
