# $OpenBSD: Makefile,v 1.2 2020/06/30 15:38:18 bcallah Exp $

COMMENT =	ultra fast universal grep
CATEGORIES =	sysutils

GH_ACCOUNT =	Genivia
GH_PROJECT =	ugrep
GH_TAGNAME =	v2.3.2

MAINTAINER =	Brian Callahan <bcallah@openbsd.org>

# BSD
PERMIT_PACKAGE =	Yes

WANTLIB += ${COMPILER_LIBCXX} bz2 c lzma m pcre2-8 z

# C++11
COMPILER =	base-clang ports-gcc

LIB_DEPENDS =	archivers/xz \
		devel/pcre2

CONFIGURE_STYLE =	gnu
CONFIGURE_ARGS =	--disable-avx \
			--disable-neon \
			--without-boost-regex

# All amd64 machines support SSE2, but the same is not true of i386
.if ${MACHINE_ARCH:Mi386}
CONFIGURE_ARGS +=	--disable-sse2
.endif

USE_GMAKE =	Yes

.include <bsd.port.mk>