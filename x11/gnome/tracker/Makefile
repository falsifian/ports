# $OpenBSD: Makefile,v 1.260 2020/11/08 08:34:58 ajacoutot Exp $

PORTROACH=		limit:^2

COMMENT=		metadata database and search tool

GNOME_PROJECT=		tracker
GNOME_VERSION=		2.3.6

# there is already audio/tracker, so this port has to live
# as meta-tracker
PKGNAME=		meta-tracker-${VERSION}
REVISION=		0

SHARED_LIBS += tracker-data              4.0 # None
SHARED_LIBS += tracker-sparql-2.0        0.1 # 0.304.0
SHARED_LIBS += tracker-miner-2.0         0.0 # 0.304.0
SHARED_LIBS += tracker-control-2.0       0.0 # 0.304.0

# GPLv2+ - LGPLv2.1+
PERMIT_PACKAGE=		Yes

WANTLIB += c gio-2.0 glib-2.0 gobject-2.0 icui18n icuuc intl
WANTLIB += json-glib-1.0 kvm m soup-2.4 sqlite3 uuid xml2

COMPILER =		base-clang ports-gcc base-gcc

MODULES=		devel/dconf \
			devel/meson \
			lang/python \
			x11/gnome

MODPY_VERSION=		${MODPY_DEFAULT_VERSION_3}
MODPY_BUILDDEP=		No
MODPY_RUNDEP=		No

TEST_DEPENDS=		devel/py-gobject3${MODPY_FLAVOR}

BUILD_DEPENDS=		shells/bash-completion \
			x11/dbus

LIB_DEPENDS=		devel/json-glib \
			devel/libsoup \
			sysutils/e2fsprogs \
			textproc/icu4c

MODGNOME_TOOLS=		gobject-introspection vala

CONFIGURE_ARGS=		-Dnetwork_manager=disabled

# needs libstemmer
CONFIGURE_ARGS +=	-Dstemmer=disabled

.include <bsd.port.mk>
