# $OpenBSD: Makefile,v 1.12 2020/01/20 09:03:51 landry Exp $

V =		0.3.0
COMMENT =	poppler pdf plugin for zathura
PROJECT =	zathura-pdf-poppler


LIB_DEPENDS +=	print/poppler

WANTLIB += girara-gtk3 glib-2.0 gobject-2.0 poppler-glib

.include <bsd.port.mk>
