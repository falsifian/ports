# $OpenBSD: Makefile,v 1.20 2020/12/29 14:49:37 landry Exp $

COMMENT =	Xfce4 developer tools and macros

XFCE_PROJECT =	xfce4-dev-tools
HOMEPAGE =	http://users.xfce.org/~benny/projects/xfce4-dev-tools/

# GPLv2
PERMIT_PACKAGE =	Yes

MODULES =	x11/xfce4

RUN_DEPENDS =	devel/libtool \
		textproc/gtk-doc \
		textproc/intltool \
		${MODGNU_AUTOCONF_DEPENDS} \
		${MODGNU_AUTOMAKE_DEPENDS} \
		shells/bash \
		devel/git \
		devel/subversion

AUTOMAKE_VERSION =	1.11
AUTOCONF_VERSION =	2.61
LIB_DEPENDS =	devel/glib2
WANTLIB = c glib-2.0 pcre pthread iconv intl

.include <bsd.port.mk>
