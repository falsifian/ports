# $OpenBSD: Makefile,v 1.34 2021/01/23 17:47:43 thfr Exp $

COMMENT=	cross-platform multimedia library

V=		2.0.14
DISTNAME=	SDL2-${V}
PKGNAME=	sdl2-${V}
REVISION=	1
CATEGORIES=	devel
MASTER_SITES=	https://www.libsdl.org/release/

SHARED_LIBS=	SDL2		0.9	# 0.12

HOMEPAGE=	https://www.libsdl.org/

MAINTAINER=	Thomas Frohwein <thfr@openbsd.org>

DEBUG_PACKAGES=	${BUILD_PACKAGES}

# zlib
PERMIT_PACKAGE=	Yes

WANTLIB+=	X11 Xcursor Xext Xfixes Xi Xinerama Xrandr Xrender Xss
WANTLIB+=	Xxf86vm m pthread samplerate sndio usbhid xcb
# GL and X11 libraries are dlopen'd by SDL
WANTLIB+=	GL

LIB_DEPENDS=	audio/libsamplerate

USE_GMAKE=		Yes
SEPARATE_BUILD=		Yes
CONFIGURE_STYLE=	gnu
MODGNU_CONFIG_GUESS_DIRS=	${WRKSRC} ${WRKSRC}/build-scripts
CONFIGURE_ARGS+= --disable-alsa \
		 --disable-arts \
		 --disable-dbus \
		 --disable-esd \
		 --disable-ibus \
		 --disable-hidapi \
		 --disable-jack \
		 --disable-libsamplerate-shared \
		 --disable-libudev \
		 --disable-nas \
		 --disable-oss \
		 --disable-pulseaudio \
		 --disable-sndio-shared \
		 --disable-x11-shared
CONFIGURE_ENV+=	CPPFLAGS="-I${LOCALBASE}/include" \
		LDFLAGS="-L${LOCALBASE}/lib"

.if ${MACHINE_ARCH} == "hppa"
CONFIGURE_ARGS+= --disable-atomic
.endif

# tests in test subdir, but interactive and not hooked up to build
NO_TEST=	Yes

.include <bsd.port.mk>
