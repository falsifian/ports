#! /usr/bin/perl

# ex:ts=8 sw=4:
# $OpenBSD: Quirks.pm,v 1.675 2018/12/10 13:23:12 sthen Exp $
#
# Copyright (c) 2009 Marc Espie <espie@openbsd.org>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

use strict;
use warnings;
use OpenBSD::PackageName;

package OpenBSD::Quirks;

sub new
{
	my ($class, $version) = @_;
	if ($version == 1 || $version == 2 || $version == 3) {
		return OpenBSD::Quirks3->new;
	} else {
		return undef;
	}
}

package OpenBSD::Quirks3;
use Config;
sub new
{
	my $class = shift;

	bless {}, $class;
}


# ->tweak_list(\@l, $state):
#	allows Quirks to do anything to the list of packages to install,
#	if something is needed. Usually, it won't do anything
sub tweak_list
{
}

# packages to remove
# stem => existing file   hash table
#	if file exists, then it's now in base and we can remove it.

my $p5a = $Config{archlib};
my $p5 = "/usr/libdata/perl5";
my $base_exceptions = {
# 5.6
	'unbound' => '/usr/sbin/unbound',
# 5.7
	'p5-IO-Socket-IP' => "$p5/IO/Socket/IP.pm",
# 5.8
	'libepoxy' => '/usr/X11R6/lib/libepoxy.so.1.0',
	'flex' => '/usr/bin/flex',
# 6.0
	'p5-Term-ReadKey' => "$p5a/Term/ReadKey.pm",
# 6.2
	'p5-Test-use-ok' => "$p5/Test/use/ok.pm",
	'p5-Test-Tester' => "$p5/Test/Tester.pm",
};

my $stem_extensions = {
# 5.6
	'p5-Class-MOP' => 'p5-Moose',
	'libproxy-mozilla' => 'libproxy-webkit',
	'p5-Mozilla-CA' => 'p5-Mozilla-CA-Fake',
	'gnome-extra' => 'gnome-extras',
	'py-Imaging' => 'py-Pillow',
	'p5-Nagios-Plugin' => 'p5-Monitoring-Plugin',
	'nagios-plugins' => 'monitoring-plugins',
	'nagios-plugins-fping' => 'monitoring-plugins-fping',
	'nagios-plugins-game' => 'monitoring-plugins-game',
	'nagios-plugins-ntp' => 'monitoring-plugins', # merged to -main
	'nagios-plugins-samba' => 'monitoring-plugins-samba',
	'nagios-plugins-snmp' => 'monitoring-plugins-snmp',
	'nagios-plugins-dbi' => 'monitoring-plugins-dbi',
	'nagios-plugins-ldap' => 'monitoring-plugins-ldap',
	'nagios-plugins-mysql' => 'monitoring-plugins-mysql',
	'nagios-plugins-pgsql' => 'monitoring-plugins-pgsql',
	'kdnssd' => 'zeroconf-ioslave',
	'kwallet' => 'kwalletmanager',
	'p5-TAP-Parser' => 'p5-Test-Harness',
# 5.7
	'qlandkarte' => 'qlandkartegt',
	'mysql-client' => 'mariadb-client',
	'mysql-server' => 'mariadb-server',
	'mysql-tests' => 'mariadb-tests',
	'py3-distribute' => 'py3-setuptools',
	'symon-mon' => 'symon',
	'symon-mux' => 'symux',
	'ruby-dbus' => 'ruby21-dbus',
	'polarssl' => 'mbedtls',
	'mscore' => 'musescore',
# 5.8
	'california' => 'calendar',
	'ipv6-toolkit' => 'ipv6toolkit',
	'p5-Search-Xapian' => 'xapian-bindings-perl',
	'ruby-archive-tar-minitar' => 'ruby-minitar',
	'racket' => 'racket-minimal',
	'ruby-passenger-standalone' => 'ruby-passenger',
	'ruby19-passenger-standalone' => 'ruby19-passenger',
	'ruby20-passenger-standalone' => 'ruby20-passenger',
	'ruby21-passenger-standalone' => 'ruby21-passenger',
	'ruby22-passenger-standalone' => 'ruby22-passenger',
	'mirall' => 'owncloudclient',
# 5.9
	'consolekit' => 'consolekit2',
	'tint' => 'tint2',
	'py-nmap' => 'py3-nmap',
	'pudb' => 'py-pudb',
	'openexr-ctl' => 'ctl',
	'nimrod' => 'nim',
	'icinga2-mysql' => 'icinga2-ido-mysql',
	'icinga2-pgsql' => 'icinga2-ido-pgsql',
	'rcsparse' => 'py-rcsparse',
	'tesseract-dan-frak' => 'tesseract-dan_frak',
	'grive' => 'grive2',
	'py-reportlab-renderPM' => 'py-reportlab',
	'cmus-flac' => 'cmus',
	'cmus-wavpack' => 'cmus',
	'quake2' => 'yquake2',
	'apertium-es-an' => 'apertium-spa-arg',
	'apertium-nn-nb' => 'apertium-nno-nob',
	'weblint' => 'p5-HTML-Lint',
	'py-fabric' => 'fabric',
# 6.0
	'cosmic-sans-neue-mono' => 'fantasque-sans',
	'droid-fonts' => 'noto-fonts',
	'py-logilab-astng' => 'py-astroid',
	'apache-httpd-openbsd' => 'apache-httpd',
	'openmotif' => 'motif',
	'go-websocket' => 'go-net',
	'letsencrypt' => 'certbot',
# 6.1
	'zarafa-webaccess' => 'zarafa-mapi',
	'railo' => 'lucee',
	'radare-bindings2' => 'radare2-bindings',
	'py-httpie' => 'httpie',
	'py-ripe.atlas.tools' => 'ripe.atlas.tools',
	'u-boot' => 'u-boot-arm',
	'ja-w3m' => 'w3m',
	'markdown' => 'py-markdown',
	'netperf-wrapper' => 'flent',
	'kamailio-xmlrpc' => 'kamailio-xml',
# 6.2
	'qt3d-html' => 'qt5-html',
	'qtactiveqt-html' => 'qt5-html',
	'qtbase-html' => 'qt5-html',
	'qtcanvas3d-html' => 'qt5-html',
	'qtcharts-html' => 'qt5-html',
	'qtconnectivity-html' => 'qt5-html',
	'qtdatavis3d-html' => 'qt5-html',
	'qtdeclarative-html' => 'qt5-html',
	'qtdoc-html' => 'qt5-html',
	'qtgamepad-html' => 'qt5-html',
	'qtgraphicaleffects-html' => 'qt5-html',
	'qtimageformats-html' => 'qt5-html',
	'qtlocation-html' => 'qt5-html',
	'qtmultimedia-html' => 'qt5-html',
	'qtnetworkauth-html' => 'qt5-html',
	'qtpurchasing-html' => 'qt5-html',
	'qtquickcontrols-html' => 'qt5-html',
	'qtquickcontrols2-html' => 'qt5-html',
	'qtremoteobjects-html' => 'qt5-html',
	'qtscript-html' => 'qt5-html',
	'qtscxml-html' => 'qt5-html',
	'qtsensors-html' => 'qt5-html',
	'qtserialbus-html' => 'qt5-html',
	'qtserialport-html' => 'qt5-html',
	'qtspeech-html' => 'qt5-html',
	'qtsvg-html' => 'qt5-html',
	'qtvirtualkeyboard-html' => 'qt5-html',
	'qtwebchannel-html' => 'qt5-html',
	'qtwebkit-html' => 'qt5-html',
	'qtwebsockets-html' => 'qt5-html',
	'qtx11extras-html' => 'qt5-html',
	'qtxmlpatterns-html' => 'qt5-html',

	'qt3d-qch' => 'qt5-qch',
	'qtactiveqt-qch' => 'qt5-qch',
	'qtbase-qch' => 'qt5-qch',
	'qtcanvas3d-qch' => 'qt5-qch',
	'qtcharts-qch' => 'qt5-qch',
	'qtconnectivity-qch' => 'qt5-qch',
	'qtdatavis3d-qch' => 'qt5-qch',
	'qtdeclarative-qch' => 'qt5-qch',
	'qtdoc-qch' => 'qt5-qch',
	'qtgamepad-qch' => 'qt5-qch',
	'qtgraphicaleffects-qch' => 'qt5-qch',
	'qtimageformats-qch' => 'qt5-qch',
	'qtlocation-qch' => 'qt5-qch',
	'qtmultimedia-qch' => 'qt5-qch',
	'qtnetworkauth-qch' => 'qt5-qch',
	'qtpurchasing-qch' => 'qt5-qch',
	'qtquickcontrols-qch' => 'qt5-qch',
	'qtquickcontrols2-qch' => 'qt5-qch',
	'qtremoteobjects-qch' => 'qt5-qch',
	'qtscript-qch' => 'qt5-qch',
	'qtscxml-qch' => 'qt5-qch',
	'qtsensors-qch' => 'qt5-qch',
	'qtserialbus-qch' => 'qt5-qch',
	'qtserialport-qch' => 'qt5-qch',
	'qtspeech-qch' => 'qt5-qch',
	'qtsvg-qch' => 'qt5-qch',
	'qtvirtualkeyboard-qch' => 'qt5-qch',
	'qtwebchannel-qch' => 'qt5-qch',
	'qtwebkit-qch' => 'qt5-qch',
	'qtwebsockets-qch' => 'qt5-qch',
	'qtx11extras-qch' => 'qt5-qch',
	'qtxmlpatterns-qch' => 'qt5-qch',
	'cargo' => 'rust',
	'apertium-fr-ca' => 'apertium-fra-cat',
	'py-doit' => 'doit',
	'cython' => 'py-cython',

	'zarafa' => 'kopano-core',
	'zarafa-mapi' => 'kopano-mapi',
	'zarafa-webapp' => 'kopano-webapp',
	'extract_url' => 'extracturl',
# 6.3
	'ruby-arirang' => 'arirang',
	'ja-mplus-ttf' => 'mixfont-mplus-ipa',
	'kdirstat' => 'qdirstat',
	'stem' => 'py-stem',
	'arm' => 'nyx',
	'luabitop' => 'lua-bitop',
	'livestreamer' => 'streamlink',
	'newsbeuter' => 'newsboat',
	'php-fastcgi' => 'php-cgi',
	'advancemess' => 'advancemame',
# 6.4
	'gnome-tweak-tool' => 'gnome-tweaks',
	'latexila' => 'gnome-latex',
	'osh' => 'etsh',
	'gnome-themes-standard' => 'gnome-themes-extra',
	'open-cobol' => 'gnucobol',
	'fanstasque-sans' => 'fantasque-sans',
	'pecl-chroot' => 'pecl56-chroot',
	'pecl-geoip' => 'pecl56-geoip',
	'pecl-http' => 'pecl56-pecl_http',
	'pecl-imagick' => 'pecl56-imagick',
	'pecl-libsodium' => 'pecl56-libsodium',
	'pecl-lzf' => 'pecl56-lzf',
	'pecl-mailparse' => 'pecl56-mailparse',
	'pecl-memcache' => 'pecl56-memcache',
	'pecl-memcached' => 'pecl56-memcached',
	'pecl-proctitle' => 'pecl56-proctitle',
	'pecl-propro' => 'pecl56-propro',
	'pecl-raphf' => 'pecl56-raphf',
	'pecl-rar' => 'pecl56-rar',
	'pecl-redis' => 'pecl56-redis',
	'pecl-ssh2' => 'pecl56-ssh2',
	'pecl-swish' => 'pecl56-swish',
	'pecl-uploadprogress' => 'pecl56-uploadprogress',
	'rope' => 'py-rope',
	'py-upt-rubygems' => 'upt-rubygems',
	'pygame' => 'py-game',
	'py-cryptodomex' => 'py-cryptodome',
	'py3-cryptodomex' => 'py3-cryptodome',
	'py-crypto' => 'py-cryptodome',
	'py3-crypto' => 'py3-cryptodome',
	'py-link-grammar' => 'py3-link-grammar',
	'py-buildbot' => 'buildbot',
	'py-buildbot-www' => 'py3-buildbot-www',
	'py-buildbot-pkg' => 'py3-buildbot-pkg',
	'py-buildbot-grid-view' => 'py3-buildbot-grid-view',
	'py-buildbot-console-view' => 'py3-buildbot-console-view',
	'py-buildbot-waterfall-view' => 'py3-buildbot-waterfall-view',
	'py-buildslave' => 'buildbot-worker',
	'sdlmame' => 'mame',
	'sdlmame-tools' => 'mame',
	'sdlmess' => 'mame',
# 6.5
	'ValyriaTear' => 'valyriatear',
	'apertium-es-ast_NO-PN' => 'apertium-es-ast',
	'py-pafy' => 'py3-pafy',
	'py-libmagic' => 'py-magic',
	'py3-libmagic' => 'py3-magic',
};

my $obsolete_reason = {
# 5.6
	'radiusd-cistron' => 2,
	'radiusd-lucent' => 2,
	'emesene' => 0,
	'celt051' => 0,
	'lasem' => 0,
	'memphis' => 3,
	'bzip' => 3,
	'silverstripe' => 1,
	'dnetc' => 0,
	'gitlist' => 1,
	'telepathy-inspector' => 0,
	'telepathy-spec' => 0,
	'svk' => 3,
	'p5-SVN-Dump' => 3,
	'p5-SVN-Mirror' => 3,
	'chipmunk' => 0,
	'maple' => 3,
	'mapleshare' => 3,
	'p5-Event-Lib' => 3,
	'gnome-search-tool' => 3,
	'gnome-system-log' => 3,
	'mash' => 3,
	'p5-RTx-Tags' => 0,
	'gedit-cossa' => 3,
	'anjuta-extras' => 3,
	'moserial' => 3,
	'ethos' => 3,
	'ekiga' => 0,
	'kpoppassd' => 2,
	'p5-Authen-Krb5-Simple' => 2,
	'py-pykpass' => 2,
	'mod_auth_kerb' => 2,
	'p5-GSSAPI' => 2,
	'opal' => 0,
	'p5-GetLive' => 3,
	'bonk' => 3,
	'xmms-bonk' => 3,
	'mailcrypt' => 0,
	'tcpcat' => 4,
# 5.7
	'ctm' => 3,
	'papyon' => 3,
	'bacula-web' => 1,
	'waf' => 0,
	'ruby-echoe' => 3,
	'ruby-rubyforge' => 0,
	'luastatgrab' => 3,
	'ruby-home_run' => 3,
	'ruby-parsetree' => 3,
	'ruby-rdoc' => 3,
	'ruby-rcov' => 3,
	'ruby-fastercsv' => 3,
	'ruby-fastri' => 3,
	'ruby-mongrel' => 3,
	'eruby' => 3,
	'mod_ruby' => 3,
	'py3-distribute' => 3,
	'raggle' => 3,
	'gnome-icon-theme-extras' => 3,
	'ruby-fastthread' => 3,
	'dellflash' => 0,
	'libgee06' => 3,
	'smarty' => 2,
	'smarty-docs' => 2,
	'wdsetup' => 0,
	'pptp' => 0,
	'aumix' => 0,
	'ac3dec' => 3,
	'flash' => 3,
	'ruby-columnize' => 3,
	'ruby-mini_magick' => 3,
	'ruby-spreadsheet' => 3,
	'ruby-minion' => 3,
	'ruby-bunny' => 3,
	'ruby-randexp' => 3,
	'synaesthesia' => 0,
	'auctex' => 0,
	'emacs-zenirc' => 3,
	'emacs-zenirc-el' => 3,
	'newsfetch' => 2,
	'esound' => 3,
	'extace' => 3,
	'gkrellmss' => 3,
	'mixer.app' => 0,
	'wmix' => 0,
	'wmmixer' => 0,
	'xmix' => 0,
	'xmmix' => 0,
	'pecl-APC' => 3,
	'fxtv' => 3,
	'hudson' => 2,
	'epdfview' => 0,
	'p5-HTTP-GHTTP' => 3,
	'libghttp' => 3,
	'ruby-hub' => 3,
	'erl-webmachine' => 0,
	'commons-io' => 2,
	'qt4-qtsolutions-singleinstance' => 3,
	'hs-HsParrot' => 5,
	'hs-HsSyck' => 5,
	'hs-MetaObject' => 5,
	'hs-control-timeout' => 5,
	'hs-pugs-DrIFT' => 5,
	'hs-pugs-compat' => 5,
	'hs-regex-pcre-builtin' => 5,
	'hs-stringtable-atom' => 5,
	'pugs' => 5,
	'xawtv' => 5,
# 5.8
	'qt4-eventsview' => 0,
	'rioutil' => 3,
	'chmsee' => 0,
	'p5-Image-Scale' => 0,
	'appdata-tools' => 3,
	'ksmp3play' => 3,
	'xchat' => 3,
	'moovida' => 3,
	'moovida-plugins-bad' => 3,
	'moovida-plugins-good' => 3,
	'moovida-plugins-ugly' => 3,
	'ntop' => 2,
	'onyx' => 3,
	'libunicode' => 5,
	'cook' => 3,
	'schroedinger' => 3,
	'wordpress' => 1,
	'polari' => 6,
	'gtk3-xfce-engine' => 3,
	'shell-fm' => 6,
	'ruby-cucumber' => 0,
	'ap2-mod_fastcgi' => 6,
	'ap2-mod_fcgid' => 6,
	'mono-basic' => 5,
	'boo' => 5,
	'nant' => 5,
	'ADMfzap' => 0,
	'ruby-jekyll' => 5,
	'ruby-couchrest' => 5,
	'ruby-rest-client' => 5,
	'libavl' => 6,
	'daapd' => 0,
	'gnomad2' => 3,
	'mpdBrowser' => 3,
	'p5-Palm' => 6,
	'palm2ical' => 6,
	'aguri' => 3,
	'bonnie' => 3,
	'xlogout' => 3,
	'mp3encode' => 3,
	'xmms-smpeg' => 3,
	'nvi-m17n' => 3,
	'ruby-term-ansicolor' => 5,
	'star' => 6,
	'sdd' => 6,
	'tt-rss' => 1,
	'pear-Benchmark' => 5,
	'pear-PHPUnit2' => 3,
	'pear-HTML-Common2' => 5,
	'pear-HTML-QuickForm' => 5,
	'p5-XML-LibXML-Common' => 5,
	'drac' => 3,
	'vifm' => 0,
	'ruby-amqp' => 5,
	'dbh' => 5,
	'yaws' => 6,
	'pidgin-facebookchat' => 6,
	'py-sslwrapper' => 0,
	'hs-snap' => 5,
	'hs-snap-core' => 5,
	'hs-snap-loader-dynamic' => 5,
	'hs-snap-loader-static' => 5,
	'hs-snap-server' => 5,
	'lmbench' => 5,
	'wterm' => 0,
	'hs-asn1-data' => 5,
	'hs-attoparsec-enumerator' => 5,
	'hs-attoparsec-iteratee' => 5,
	'hs-heist' => 5,
	'hs-certificate' => 5,
	'hs-tls' => 5,
	'opera' => 2,
	'redhat_libc5' => 2,
	'p5-Net-TCLink' => 2,
	'pg_top' => 5,
	'qtoctave' => 3,
	'ocsync' => 6,
	'tla' => 3,
	'googlecl' => 3,
	'cyphertite' => 3,
# 5.9
	'cxxtools' => 5,
	'tntnet' => 6,
	'dwb' => 6,
	'ns4' => 3,
	'tcplist' => 0,
	'wide-dhcp' => 0,
	'cfs' => 0,
	'rubinius' => 5,
	'xorp' => 5,
	'faac' => 6,
	'god' => 5,
	'ivan' => 3,
	'hs-xhtml-combinators' => 5,
	'feldspar-compiler' => 5,
	'feldspar-language' => 5,
	'hs-MonadCatchIO-mtl' => 5,
	'hs-MonadCatchIO-transformers' => 5,
	'hs-QuickAnnotate' => 5,
	'hs-clientsession' => 5,
	'hs-comonad' => 5,
	'hs-comonad-transformers' => 5,
	'hs-comonads-fd' => 5,
	'hs-contravariant' => 5,
	'hs-cprng-aes' => 5,
	'hs-data-lens' => 5,
	'hs-data-lens-template' => 5,
	'hs-distributive' => 5,
	'hs-either' => 5,
	'hs-errors' => 5,
	'hs-ghc-mtl' => 5,
	'hs-hint' => 5,
	'hs-iteratee' => 5,
	'hs-lens' => 5,
	'hs-monads-tf' => 5,
	'hs-semigroupoids' => 5,
	'hs-syntactic' => 5,
	'hs-type-level' => 5,
	'hs-vector-algorithms' => 5,
	'hs-ListLike' => 5,
	'hs-atom' => 5,
	'gstreamermm' => 3,
	'opencm' => 3,
	'libglademm' => 3,
	'hs-zlib-enum' => 5,
	'hs-blaze-builder-enumerator' => 5,
	'hs-monad-par' => 5,
	'hs-monad-par-extras' => 5,
	'swfdec-plugin' => 3,
	'yui' => 2,
	'yui-docs' => 2,
	'tkrat' => 3,
	'bustle' => 5,
	'bluetile' => 5,
	'hs-cairo' => 5,
	'hs-gio' => 5,
	'hs-glade' => 5,
	'hs-glib' => 5,
	'hs-gtk' => 5,
	'hs-pango' => 5,
	'hs-webkit' => 5,
	'node-pg' => 7,
	'node-sqlite3' => 7,
	'node-async' => 7,
	'node-bindings' => 7,
	'node-buffer-writer' => 7,
	'node-cloned' => 7,
	'node-expresso' => 7,
	'node-fibers' => 7,
	'node-generic-pool' => 7,
	'node-gir' => 7,
	'node-mnm' => 7,
	'node-canvas' => 7,
	'node-java' => 7,
	'node-typescript' => 7,
	'node-bcrypt' => 7,
	'node-always' => 7,
	'node-daemon' => 7,
	'node-rmdir' => 7,
	'node-syslog' => 7,
	'gtk2hs-buildtools' => 5,
	'coffeescript' => 7,
	'pb-browser' => 0,
	'unace' => 0,
	'edict' => 3,
	'ADMsmb' => 6,
	'mrtd' => 3,
	'openobex' => 6,
	'obexftp' => 6,
	'py-openbsd' => 3,
	'antisniff' => 3,
	'WebGUI' => 2,
	'tinyca2' => 3,
	'kxmleditor' => 3,
	'hs-hashed-storage' => 5,
	'gnome-common' => 3,
	'emacs-haskell' => 7,
	'statusnet' => 1,
	'p5-Goo-Canvas' => 6,
	'hs-blaze-builder-conduit' => 3,
	'hs-network-conduit' => 3,
	'hs-http-attoparsec' => 5,
	'hs-shellish' => 5,
	'hs-xmlhtml' => 5,
	'hs-blaze-html' => 5,
	'hs-blaze-markup' => 5,
	'zsnes' => 2,
	'its4' => 3,
	'august' => 3,
	'hs-hlint' => 7,
	'monodevelop' => 5,
	'hs-hoogle' => 7,
	'hs-configurator' => 5,
	'hs-safe' => 5,
	'hs-uniplate' => 5,
	'hs-vault' => 5,
	'hs-haskell-src-exts' => 5,
	'hs-tagsoup' => 5,
	'hs-http-types' => 5,
	'hs-wai' => 5,
	'hs-warp' => 5,
	'hs-hackage-db' => 5,
	'c2hs' => 5,
	'hs-language-c' => 5,
	'hs-simple-sendfile' => 5,
	'monadius' => 3,
	'hs-bimap' => 5,
# 6.0
	'nicotine' => 3,
	'toprump' => 3,
	'fedora_base' => 0,
	'fedora_cups' => 0,
	'fedora_gtk+2' => 0,
	'adom' => 0,
	'xcept' => 0,
	'cqcam' => 6,
	'uisp' => 6,
	'libretto-config' => 6,
	'courtney' => 2,
	'junkbuster' => 2,
	'icb' => 0,
	'libshrink' => 3,
	'libclog' => 3,
	'libexude' => 3,
	'assl' => 3,
	'libxmlsd' => 3,
	'p5-I18N-LangTags' => 4,
	'p5-Text-Restructured' => 3,
	'p5-Safe-World' => 3,
	'p5-Safe-Hole' => 3,
	'p5-Slay-Makefile-Gress' => 3,
	'p5-Slay-Makefile' => 3,
	'p5-Slay-Maker' => 3,
	'p5-Test-Harness' => 4,
	'mpegaudio' => 0,
	'fvwm95' => 0,
	'rplay' => 0,
	'amsn' => 6,
	'pebrot' => 6,
	'alacarte' => 3,
	'logstash-forwarder' => 3,
	'py-Xlib' => 5,
	'pypanel' => 3,
	'gtkhtml3' => 5,
	'libunique3' => 5,
	'swfdec' => 3,
	'asm' => 5,
	'libqzeitgeist' => 6,
	'zeitgeist' => 6,
	'gedit-latex' => 3,
	'rackmonkey' => 3,
	'mod_auth_bsd' => 6,
	'mod_auth_ldap' => 6,
	'mod_auth_mysql' => 6,
	'mod_auth_pgsql' => 6,
	'mod_auth_radius' => 6,
	'mod_encoding' => 6,
	'mod_fastcgi' => 6,
	'mod_geoip' => 6,
	'mod_gzip' => 6,
	'mod_jk' => 6,
	'mod_layout' => 6,
	'mod_ldapvhost' => 6,
	'mod_log_sql' => 6,
	'mod_mp3' => 6,
	'mod_random' => 6,
	'mod_scgi' => 6,
	'mod_security' => 6,
	'mod_text2html' => 6,
	'p5-CGI-SpeedyCGI' => 6,
	'p5-HTML-Embperl' => 6,
	'p5-libapreq' => 6,
	'mod_perl' => 6,
	'ocamlduce' => 0,
	'yt' => 0,
	'gmime-sharp' => 6,
	'py-subvertpy' => 5,
# 6.1
	'clamz' => 3,
	'p5-Net-Abuse-Utils-Spamhaus' => 6,
	'mlite' => 3,
	'hgd' => 3,
	'gfortran' => 5,
	'cherokee' => 3,
	'cherokee-geoip' => 3,
	'cherokee-ldap' => 3,
	'cherokee-mysql' => 3,
	'cherokee-streaming' => 3,
	'gecko-mediaplayer' => 3,
	'io' => 5,
	'dbic++' => 5,
	'hs-postgresql-simple' => 5,
	'hs-uuid' => 5,
	"ocaml-mlgmp" => 3,
	"ocaml-batteries" => 5,
	"ocaml-bitstring" => 5,
	"ocaml-calendar" => 5,
	"ocaml-curses" => 5,
	"ocaml-net" => 5,
	"ocaml-camlimages" => 5,
	"ocaml-cryptokit" => 5,
	"ocaml-csv" => 5,
	"ocaml-rss" => 5,
	"ocaml-xml-light" => 5,
	"ocaml-xmlm" => 5,
	"ocaml-postgresql" => 5,
	"ocaml-sqlite3" => 5,
	"utop" => 7,
	"ocaml-lambda-term" => 5,
	"ocaml-lwt" => 5,
	"ocaml-react" => 5,
	"ocaml-text" => 5,
	"ocaml-ssl" => 5,
	"ocaml-ppx-tools" => 5,
	"ocaml-zed" => 5,
	"ocaml-camomile" => 5,
	"elinks" => 2,
	"wyrd" => 3,
	"sudoku-solver" => 3,
	"clearsilver" => 3,
	"poppler-qt" => 3,
	'amarok' => 2,
	'digikam-doc' => 6,
	'gwenview-i18n' => 6,
	'kaffeine' => 6,
	'kbiff' => 6,
	'kdbg' => 3,
	'kdewebdev' => 5,
	'kmplayer' => 6,
	'kountdown' => 3,
	'kslide' => 3,
	'ktimeclock' => 6,
	'okle' => 2,
	'qinx' => 6,
	'quadkonsole' => 6,
	'taskjuggler' => 6,
	'icinga2-migration' => 3,
	'poppassd' => 0,
	'wmthemeinstall' => 0,
	'gkrellmms' => 5,
	'py-xmms' => 5,
	'xmms' => 5,
	'xmms-faad' => 5,
	'xmms-flac' => 5,
	'xmms-fmradio' => 5,
	'xmms-kj' => 5,
	'xmms-mad' => 5,
	'xmms-mikmod', => 5,
	'xmms-mp3' => 5,
	'xmms-shn' => 5,
	'xmms-sid' => 5,
	'xmms-speex' => 5,
	'xmms-tremor' => 5,
	'xmms-vorbis' => 5,
	'xmms-wavpack' => 5,
	'xmms-xf86audio' => 5,
	'xmmsctrl' => 5,
	'glib' => 5,
	'gtk+' => 5,
	'gnome-user-share' => 8,
	'letskencrypt' => 4,
	'emiclock' => 0,
	'rygel' => 8,
	'vino' => 8,
	'ttcp' => 0,
	'aget' => 3,
	'xfprint' => 3,
	'notification-daemon-xfce' => 3,
	'xfce4-wmdock' => 3,
	'xfce4-modemlights' => 3,
	'xfce4-quicklauncher' => 3,
	'libxfcegui4' => 5,
	'libsexy' => 5,
	'twitux' => 3,
	'gnash' => 2,
	'eclipse-sdk' => 2,
	'swt' => 2,
	'swt-gnome' => 2,
	'eclipse-plugin-emf-sdk' => 2,
	'eclipse-plugin-epic' => 2,
	'eclipse-plugin-findbugs' => 2,
	'eclipse-plugin-gef-sdk' => 2,
	'eclipse-plugin-ivyde' => 2,
	'py-dev' => 2,
	'eclipse-plugin-rdt' => 2,
	'eclipse-plugin-struts-console' => 2,
	'eclipse-plugin-subclipse' => 2,
	'eclipse-plugin-uml2-sdk' => 2,
	'eclipse-plugin-wtp-sdk' => 2,
	'lsof' => 0,
	'l0phtcrack' => 0,
	'bunny' => 3,
	'jakarta-servletapi' => 5,
	'ldistfp' => 0,
	'py-webkitgtk' => 2,
	'xombrero' => 3,
	'claws-mail-htmlviewer' => 2,
	'postgresql-jdbc' => 6,
	'postgresql-jdbc-docs' => 6,
	'plor' => 3,
	'coherence' => 3,
	'hugs98' => 3,
	'hmake' => 3,
	'nhc98' => 3,
	'logsurfer' => 3,
	'scsh' => 3,
	'bladeenc' => 3,
	'pilot_makedoc' => 6,
	'clog' => 4,
	'pigment' => 3,
	'py-pigment' => 3,
	'gogo' => 3,
# 6.2
	'spectemu' => 3,
	'pinpoint' => 3,
	'anjuta' => 3,
	'libneural' => 5,
	'toolame' => 5,
	'gpointing-device-settings' => 3,
	'ja-jvim' => 3,
	'teknap' => 6,
	'trafd' => 4,
	'topbeat' => 3,
	'logic2cnf' => 3,
	'bytebench' => 3,
	'libdivxdecore' => 5,
	'xgrab' => 9,
	'quirc' => 3,
	'xspread' => 3,
	'sharity-light' => 6,
	'py-axiom' => 5,
	'py-epsilon' => 5,
	'hellanzb'=> 3,
	'londonlaw'=> 3,
	'castle-combat'=> 3,
	'rxvt' => 2,
	'irssi-silc' => 3,
	'teapop' => 3,
	'daala' => 6,
	'aiccu' => 6,
	'samhain' => 5,
	'samhain-docs' => 5,
	'samhain-server' => 5,
	'texapp' => 6,
	'surf2' => 5,
	'mrxvt' => 2,
	'cutegram' => 3,
	'libqtelegram-aseman-edition' => 5,
	'qca-tls' => 3,
	'py-qt5-docs' => 3,
	'qtenginio' => 3,
	'qtenginio-docindex' => 3,
	'qtenginio-examples' => 3,
	'qtenginio-html' => 3,
	'qtenginio-qch' => 3,
	'crxvt' => 2,
	'qt3d-docindex' => 6,
	'qtactiveqt-docindex' => 6,
	'qtbase-docindex' => 6,
	'qtcanvas3d-docindex' => 6,
	'qtcharts-docindex' => 6,
	'qtconnectivity-docindex' => 6,
	'qtdatavis3d-docindex' => 6,
	'qtdeclarative-docindex' => 6,
	'qtdoc-docindex' => 6,
	'qtgamepad-docindex' => 6,
	'qtgraphicaleffects-docindex' => 6,
	'qtimageformats-docindex' => 6,
	'qtlocation-docindex' => 6,
	'qtmultimedia-docindex' => 6,
	'qtnetworkauth-docindex' => 6,
	'qtpurchasing-docindex' => 6,
	'qtquickcontrols-docindex' => 6,
	'qtquickcontrols2-docindex' => 6,
	'qtremoteobjects-docindex' => 6,
	'qtscript-docindex' => 6,
	'qtscxml-docindex' => 6,
	'qtsensors-docindex' => 6,
	'qtserialbus-docindex' => 6,
	'qtserialport-docindex' => 6,
	'qtspeech-docindex' => 6,
	'qtsvg-docindex' => 6,
	'qtvirtualkeyboard-docindex' => 6,
	'qtwebchannel-docindex' => 6,
	'qtwebkit-docindex' => 6,
	'qtwebsockets-docindex' => 6,
	'qtx11extras-docindex' => 6,
	'qtxmlpatterns-docindex' => 6,
	'conkeror' => 3,
	'xulrunner' => 5,
	'xulrunner-devel' => 5,
	'libaccounts-glib' => 6,
	'mico' => 0,
	'leveldb' => 5,
	'py-graphics' => 3,
	'akode' => 5,
	'zendframework' => 5,
	'kbilliards' => 5,
	'knutclient' => 5,
	'pgpsendmail' => 3,
	'banshee' => 3,
	'mono-zeroconf' => 5,
	'mono-avahi' => 5,
	'toad' => 3,
	'pgp' => 3,
	'gonzui' => 3,
# 6.3
	'puppet-dashboard' => 5,
	'dnsfilter' => 3,
	'empathy' => 6,
	'telepathy-salut' => 3,
	'telepthy-haze' => 3,
	'telepathy-idle' => 3,
	'telepathy-gabble' => 3,
	'telepathy-qt' => 3,
	'telepathy-farstream' => 3,
	'farstream' => 3,
	'libnice' => 6,
	'ardour' => 5,
	'aubio' => 5,
	'liblo' => 5,
	'libgnomecanvasmm' => 5,
	'mixmaster' => 2,
	'xscorch' => 0,
	'libwbxml' => 5,
	'haskell-platform' => 6,
	'gnokii' => 0,
	'dee' => 5,
	'pidgin-tlen' => 6,
	'pep8' => 5,
	'hs-aeson' => 6,
	'hs-GLURaw' => 6,
	'hs-GLUT' => 6,
	'hs-OpenGL' => 6,
	'hs-OpenGLRaw' => 6,
	'gnuvd' => 6,
	'gtkhtml4' => 5,
	'livestreamer-curses' => 6,
	'xdmchoose' => 6,
	'hs-BoundedChan' => 6,
	'hs-HDBC-mysql' => 6,
	'hs-HDBC-postgresql' => 6,
	'hs-MonadRandom' => 6,
	'hs-ObjectName' => 6,
	'hs-PSQueue' => 6,
	'hs-StateVar' => 6,
	'hs-abstract-deque' => 6,
	'hs-abstract-par' => 6,
	'hs-base-unicode-symbols' => 6,
	'hs-blaze-textual' => 6,
	'hs-bytestring-mmap' => 6,
	'hs-bytestring-nums' => 6,
	'hs-case-insensitive' => 6,
	'hs-cgi' => 6,
	'hs-cmdlib' => 6,
	'hs-concurrent-extra' => 6,
	'hs-crypto' => 6,
	'hs-cryptocipher' => 6,
	'hs-curl' => 6,
	'hs-data-hash' => 6,
	'hs-directory-tree' => 6,
	'hs-enumerator' => 6,
	'hs-failure' => 6,
	'hs-ghc-paths' => 6,
	'hs-half' => 6,
	'hs-hashtables' => 6,
	'hs-haskell-src' => 6,
	'hs-hedis' => 6,
	'hs-hexpat' => 6,
	'hs-hood' => 6,
	'hs-largeword' => 6,
	'hs-logict' => 6,
	'hs-murmur-hash' => 6,
	'hs-mwc-random' => 6,
	'hs-network-info' => 6,
	'hs-newtype' => 6,
	'hs-parallel' => 6,
	'hs-patch-combinators' => 6,
	'hs-postgresql-libpq' => 6,
	'hs-pwstore-fast' => 6,
	'hs-readline' => 6,
	'hs-sendfile' => 6,
	'hs-skein' => 6,
	'hs-strict' => 6,
	'hs-tuple' => 6,
	'hs-zlib-bindings' => 6,
	'vomit' => 0,
	'p5-WWW-YouTube-Download' => 6,
	'oggtag' => 6,
	'tacacs+' => 0,
	'aimsniff' => 6,
	'pork' => 6,
	'ntimed' => 3,
	'hs-dataenc' => 3,
	'man2web' => 2,
	'decss' => 6,
	'libgcal' => 6,
	'akonadi-googledata' => 6,
	'arora' => 3,
	'powerdns-ldap' => 6,
	'p5-Net-LDNS' => 6,
	'sirc' => 0,
	'hgview' => 6,
	'xerces' => 5,
# 6.4
	'mozjs17' => 2,
	'qvwm' => 3,
	'prepop' => 3,
	'centerim' => 3,
	'gpgmepp' => 3,
	'hs-resource-pool' => 6,
	'hs-List' => 6,
	'hs-OneTuple' => 6,
	'hs-blaze-builder' => 6,
	'hs-unbounded-delays' => 6,
	'hs-unordered-containers' => 6,
	'hscolour' => 6,
	'hs-multipart' => 6,
	'hs-bytestring-lexing' => 6,
	'hs-scanner' => 6,
	'xnc' => 0,
	'nepenthes' => 3,
	'mongrel2' => 6,
	'ja-groff' => 6,
	'gtkglextmm' => 3,
	'goocanvas' => 3,
	'osm2go' => 6,
	'kedpm' => 6,
	'mediatomb' => 3,
	'apache-couchdb' => 6,
	'py-couchdb' => 6,
	'chive' => 3,
	'opengroupware' => 3,
	'git-bz' => 3,
	'hot-babe' => 3,
	'wmgrabimage' => 0,
	'wmphoto' => 0,
	'wmminichess' => 0,
	'wmifinfo' => 0,
	'wmnet' => 0,
	'wmwave' => 0,
	'wmcb' => 0,
	'wmpinboard' => 0,
	'wmbiff' => 0,
	'wmmail' => 0,
	'wmtimer' => 0,
	'py-crypto' => 3,
	'py3-crypto' => 3,
	'tremor' => 5,
	'tremor-tools' => 5,
	'xtrkcad' => 3,
	'webkit' => 2,
	'py-test-capturelog' => 5,
	'py3-test-capturelog' => 5,
	'snapdl' => 3,
	'ccnet' => 6,
	'dkim-milter' => 10,
	'aircontrol' => 11,
	'corebird' => 3,
	'py-pcs' => 5,
	'ifmcstat' => 5,
# 6.5
	'py-dtopt' => 5,
	'py3-dtopt' => 5,
	'memtest86+' => 0,
	'py-reat' => 5,
	'dovecot-antispam' => 12,
	'py-hgtools' => 3,
	'py3-hgtools' => 3,
	'py-hgsubversion' => 3,
	'py-hgnested' => 5,
	'py-keyczar' => 6,
	'py-hg-git' => 5,
	'py-czmq' => 3,
	'p5-Math-Pari' => 13,
	'p5-Math-BigInt-Pari' => 13,
	'p5-Crypt-Random' => 13,
	'p5-Crypt-DH' => 13,
	'p5-Crypt-Primes' => 13,
	'p5-Crypt-RSA' => 13,
	'p5-Crypt-OpenPGP' => 13,
	'directoryassistant' => 0,
	'x-pack' => 3,
	'libepc' => 5,
	'dysnomia-en' => 0,
	'casperjs' => 3,
	'phantomjs' => 3,
	'owncloud' => 6,
	'php-librdf' => 13,
};

# reasons for obsolete packages
my @msg = (
	"ancient software that doesn't work", #0
	"web application with no benefit being packaged", #1
	"no longer maintained and full of security holes", #2
	"no longer maintained upstream", #3
	"superseded by base component", #4
	"outdated and/or no longer required by other ports", #5
	"no longer useful", #6
	"removed in favor of using languages package manager", #7
	"requires systemd", #8
	"256 colors only, suggest scrot or xwd", #9
	"has been replaced by opendkim", #10
	"no longer packageable", #11
	"replace with IMAPSieve, see https://wiki.dovecot.org/HowTo/AntispamWithSieve", #12
	"has a dependency on obsolete software", #13
);

# ->is_base_system($handle, $state):
#	checks whether an existing handle is now part of the base system
#	and thus no longer needed.

sub is_base_system
{
	my ($self, $handle, $state) = @_;

	my $stem = OpenBSD::PackageName::splitstem($handle->pkgname);

	my $test = $base_exceptions->{$stem};
	if (defined $test) {
		if (-e $test) {
			$state->say("Removing #1 #2", $handle->pkgname,
			    " (part of base system now)");
			return 1;
		} else {
			$state->say("Not removing #1 #2 #3 #4", $handle->pkgname,
			 ", ", $test, " not found");
			return 0;
		}
	} else {
		return 0;
	}
}

# ->filter_obsolete(\@list)
# explicitly mark packages as no longer there. Remove them from the
# list of "normal" stuff.

sub filter_obsolete
{
	my ($self, $list, $state) = @_;
	my @in = @$list;
	$list = [];
	for my $pkgname (@in) {
		my $stem = OpenBSD::PackageName::splitstem($pkgname);
		my $reason = $obsolete_reason->{$stem};
		$reason = 3 if (!defined $reason && $pkgname =~ m/^(drupal(-6|6-)|ruby(19|2[0-3])-|ruby-[^0-9])/);
		if (defined $reason) {
			$state->say("Obsolete package: #1 (#2)", $pkgname, 
			    $msg[$reason]);
		} else {
			push(@$list, $pkgname);
		}
	}
}


# ->tweak_search(\@s, $handle, $state):
#	tweaks the normal search for a given handle, in case (for instance)
#	of a stem name change.

sub tweak_search
{
	my ($self, $l, $handle, $state) = @_;

	if (@$l == 0 || !$l->[0]->can("add_stem")) {
		return;
	}
	my $stem = OpenBSD::PackageName::splitstem($handle->pkgname);
	my $extra = $stem_extensions->{$stem};
	if (defined $extra) {
		if (ref $extra) {
			for my $e (@$extra) {
				$l->[0]->add_stem($e);
			}
		} else {
			$l->[0]->add_stem($extra);
		}
	}
}

# list of
#   cat/path => badspec
my $cve = {
	'archivers/cabextract' => 'cabextract-<1.8',
	'archivers/libmspack' => 'libmspack-<0.8alpha',
	'audio/flac' => 'flac-<1.3.0p1',
	'databases/mariadb,-main' => 'mariadb-client-<10.0.36',
	'databases/mariadb,-server' => 'mariadb-server-<10.0.36',
	'databases/postgresql,-main' => 'postgresql-client-<10.6',
	'databases/postgresql,-server' => 'postgresql-server-<10.6',
	'devel/git,-main' => 'git-<2.19.1',
	'devel/git,-svn' => 'git-svn-<2.19.1',
	'devel/git,-x11' => 'git-x11-<2.19.1',
	'devel/libgit2/libgit2' => 'libgit2-<0.27.7',
	'devel/mercurial,-main' => 'mercurial-<4.5.3p1',
	'devel/mercurial,-x11' => 'mercurial-x11-<4.5.3p1',
	'devel/pcre' => 'pcre-<8.38',
	'graphics/tiff' => 'tiff-<4.0.4beta',
	'lang/php/5.6,-main' => 'php-<5.6.38',
	'lang/php/7.0,-main' => 'php->7.0,<7.0.32',
	'lang/php/7.1,-main' => 'php->7.1,<7.1.22',
	'lang/php/7.2,-main' => 'php-7.2->7.2,<7.2.10',
	'lang/ruby/2.3,-main' => 'ruby-<2.3.8',
	'lang/ruby/2.4,-main' => 'ruby->2.4,<2.4.5',
	'lang/ruby/2.5,-main' => 'ruby->2.5,<2.5.3',
	'mail/exim' => 'exim-<4.83',
	'mail/p5-Mail-SpamAssassin' => 'p5-Mail-SpamAssassin-<3.4.2',
	'mail/roundcubemail' => 'roundcubemail-<1.3.8',
	'net/curl' => 'curl-<7.62.0',
	'net/icecast' => 'icecast-<2.4.4',
	'net/isc-bind' => 'isc-bind-<9.11.4pl2',
	'net/lldpd' => 'lldpd-<0.7.18p0',
	'net/ntp' => 'ntp-<4.2.8pl7',
	'net/powerdns,-main' => 'powerdns-<4.1.5',
	'net/powerdns,-mysql' => 'powerdns-mysql-<4.1.5',
	'net/powerdns,-pgsql' => 'powerdns-pgsql-<4.1.5',
	'net/samba,-main' => 'samba-<4.8.4',
	'net/tinc' => 'tinc-<1.0.35v0',
	'net/transmission,-gtk' => 'transmission-gtk-<2.84',
	'net/transmission,-main' => 'transmission-<2.84',
	'net/transmission,-qt' => 'transmission-qt-<2.84',
	'net/wireshark,-gtk' => 'wireshark-gtk-<2.6.3',
	'net/wireshark,-main' => 'wireshark-<2.6.3',
	'net/wireshark,-text' => 'tshark-<2.6.3',
	'print/cups,-main' => 'cups-<1.7.4',
	'security/clamav' => 'clamav-<0.100.2',
	'security/polarssl' => 'mbedtls-<2.14.1',
	'shells/bash' => 'bash-<4.3.27',
	'sysutils/ansible,-main' => 'ansible-<2.7.1',
	'sysutils/mcollective' => 'mcollective-<2.5.3',
	'telephony/asterisk,-main' => 'asterisk-<13.23.1',
	'www/apache-httpd,-main' => 'apache-httpd-<2.4.35',
	'www/bozohttpd' => 'bozohttpd-<20130711p0',
	'www/chromium' => 'chromium-<69.0.3497.100',
	'www/drupal7/core7' => 'drupal->=7.0,<7.60',
	'www/drupal7/theme-newsflash' => 'drupal7-theme-newsflash-<2.5',
	'www/iridium' => 'iridium-<2018.5.67',
	'www/mozilla-firefox' => 'firefox-<62.0.2p0',
	'www/nginx' => 'nginx-<1.4.1',
	'www/p5-CGI-Application' => 'p5-CGI-Application-<4.50p0',
	'www/py-requests' => 'py-requests-<2.20.0',
	'www/py-requests,python3' => 'py3-requests-<2.20.0',
	'www/ruby-rack,ruby24' => 'ruby24-rack-<2.0.6',
	'www/ruby-rack,ruby25' => 'ruby25-rack-<2.0.6',
	'www/webkitgtk4' => 'webkitgtk4-<2.20.5',
	'x11/gnome/gdm' => 'gdm-<3.28.3',
};
# please maintain sort order in above $cve list, future updates need to
# replace existing entries

for my $sub (qw(calendar http_post ldap odbc pgsql snmp speex tds)) {
	$cve->{"telephony/asterisk,-$sub"} = "asterisk-$sub-<13.23.1";
}

for my $sub (qw(apache cgi dbg bz2 curl dba gd gmp intl imap ldap mysqli
    odbc pcntl pdo_mysql pdo_odbc pdo_pgsql pdo_sqlite pgsql pspell
    shmop soap snmp sqlite3 pdo_dblib tidy xmlrpc xsl zip mysql
    sybase_ct mssql mcrypt)) {
	$cve->{"lang/php/5.6,-$sub"} = "php-$sub-<5.6.38";
	$cve->{"lang/php/7.0,-$sub"} = "php-$sub->7.0,<7.0.32";
	$cve->{"lang/php/7.1,-$sub"} = "php-$sub->7.1,<7.1.22";
	$cve->{"lang/php/7.2,-$sub"} = "php-$sub->7.2,<7.2.10";
}


# ->check_security($path)
#	return an insecure specification for the matching path
#	e.g., you should update.

sub check_security
{
	my ($self, $path) = @_;
	if (defined $cve->{$path}) {
		return $cve->{$path};
	} else {
		return undef;
	}
}

my $optional_tag = {
#	emacs => 'emacs-*|xemacs-*',
};

# -> is_optional_tag($tag)
#	return either undef or a pkgspec where to find the definition

sub is_optional_tag
{
	my ($self, $tag) = @_;
	return $optional_tag->{$tag->name};
}

1;
