Received: from eggs.gnu.org ([2001:4830:134:3::10]:57681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1d3bv8-0005KS-LL
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1d3bv5-0004bP-H3
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:24:50 -0400
Received: from mail-db5eur01on0116.outbound.protection.outlook.com
	([104.47.2.116]:39088
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.fonnemann@hexagon.com>)
	id 1d3bv5-0004ai-6V
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:24:47 -0400
From: FONNEMANN Mark <mark.fonnemann@hexagon.com>
Date: Wed, 26 Apr 2017 18:51:00 +0000
Message-ID: <VI1PR0601MB2479950F84BBE26A46F549FA9C110@VI1PR0601MB2479.eurprd06.prod.outlook.com>
References: <VI1PR0601MB2479DE114384C023CA45C41E9C040@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170416080930.luq2l4p3e36vovkj@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479E581256475D80164322A9C070@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<cd2a810c-d717-4666-4a95-b185c02d83df@weilnetz.de>
In-Reply-To: <cd2a810c-d717-4666-4a95-b185c02d83df@weilnetz.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Samuel Thibault <samuel.thibault@gnu.org>

-----Original Message-----
From: Stefan Weil [mailto:sw@weilnetz.de]=20
Sent: Friday, April 21, 2017 15:58
To: FONNEMANN Mark <mark.fonnemann@hexagon.com>; qemu-devel@nongnu.org; Sam=
uel Thibault <samuel.thibault@gnu.org>
Subject: Re: [Qemu-devel] dns server not working in QEMU using usermode net=
working (SLIRP)

>See report on
>http://stackoverflow.com/questions/43308310/dns-server-not-working-in-qemu=
-usermode-networking.

>Mark, did you also get that problem with QEMU running on a Linux host, or =
is it specific for QEMU running on Windows?

I just verified the problem exists on Linux host as well. I cannot ping the=
 DNS or SMB server and the DNS server does not respond to nslookup requests=
.
