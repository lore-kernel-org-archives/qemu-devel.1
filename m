Received: from eggs.gnu.org ([2001:4830:134:3::10]:56393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4jcu-0003o8-68
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 03:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4jcr-0005Yi-62
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 03:50:40 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:56250)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4jcr-0005YV-00
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 03:50:37 -0400
Date: Sun, 30 Apr 2017 09:50:33 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170430075033.yjqj4ibssa52h4d7@var.youpi.perso.aquilenet.fr>
References: <VI1PR0601MB2479950F84BBE26A46F549FA9C110@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<VI1PR0601MB2479D2A56A202E3FD18C6DDF9C1F0@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429124421.2qcthvlsiwvtqov2@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479CBDA85F323A82C0CFBD99C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429171002.enxmz5dtuzhrxuc6@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479886B8955148FD8A2D06F9C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429191402.ebsdilnya67ispla@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479CA25619E1C66359EC3709C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429220156.bb4hdlsaf6zzqmtw@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479F31C301B954294452CA49C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0601MB2479F31C301B954294452CA49C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
Subject: Re: [Qemu-devel] dns server not working in QEMU using usermode
 networking (SLIRP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: FONNEMANN Mark <mark.fonnemann@hexagon.com>
Cc: Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

FONNEMANN Mark, on sam. 29 avril 2017 23:15:08 +0000, wrote:
> [mfonnemann@desktopPC qemu]$ /usr/local/bin/qemu-system-i386 -display curses -readconfig NG.cfg --enable-kvm

Could you show us your NG.cfg, your guest /sbin/ifconfig and /sbin/route
output and /etc/resolv.conf content for that host?

Samuel
