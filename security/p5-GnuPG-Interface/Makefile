# $OpenBSD: Makefile,v 1.23 2021/01/18 13:41:34 robert Exp $

COMMENT=	perl5 interface to GnuPG

MODULES=	cpan
PKG_ARCH=	*
DISTNAME=	GnuPG-Interface-1.00
CATEGORIES=	security

# Perl
PERMIT_PACKAGE=	Yes

BUILD_DEPENDS=	${RUN_DEPENDS}
RUN_DEPENDS=	devel/p5-Any-Moose \
		devel/p5-MooX-HandlesVia \
		devel/p5-MooX-late \
		devel/p5-Type-Tiny \
		security/gnupg

.include <bsd.port.mk>
