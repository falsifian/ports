# $OpenBSD: Makefile,v 1.25 2020/10/22 20:17:56 fcambus Exp $

COMMENT =	ansi and ascii art to png converter

V =		4.1.4
DISTNAME =	ansilove-$V

CATEGORIES =	graphics

HOMEPAGE =	https://www.ansilove.org/

MAINTAINER =	Frederic Cambus <fcambus@openbsd.org>

# BSD
PERMIT_PACKAGE =	Yes

# uses pledge()
WANTLIB +=	ansilove c m

MASTER_SITES =	https://github.com/ansilove/ansilove/releases/download/$V/

LIB_DEPENDS =	graphics/libansilove

MODULES =	devel/cmake

.include <bsd.port.mk>
