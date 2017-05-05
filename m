Received: from eggs.gnu.org ([2001:4830:134:3::10]:60703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1d6lrp-0007Km-FB
	for qemu-devel@nongnu.org; Fri, 05 May 2017 18:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1d6lrm-0001SF-BQ
	for qemu-devel@nongnu.org; Fri, 05 May 2017 18:38:29 -0400
Received: from mail-db5eur01on0139.outbound.protection.outlook.com
	([104.47.2.139]:20352
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.fonnemann@hexagon.com>)
	id 1d6lrl-0001RS-US
	for qemu-devel@nongnu.org; Fri, 05 May 2017 18:38:26 -0400
From: FONNEMANN Mark <mark.fonnemann@hexagon.com>
Date: Fri, 5 May 2017 22:38:20 +0000
Message-ID: <VI1PR0601MB247996FB5818A956470FE8169CEB0@VI1PR0601MB2479.eurprd06.prod.outlook.com>
References: <20170429124421.2qcthvlsiwvtqov2@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479CBDA85F323A82C0CFBD99C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429171002.enxmz5dtuzhrxuc6@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479886B8955148FD8A2D06F9C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429191402.ebsdilnya67ispla@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479CA25619E1C66359EC3709C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429220156.bb4hdlsaf6zzqmtw@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479F31C301B954294452CA49C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170430075033.yjqj4ibssa52h4d7@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB247905FC4B3FEE03780CF1EE9C150@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170430125703.pcp4ldw7oardptmn@var.youpi.perso.aquilenet.fr>
In-Reply-To: <20170430125703.pcp4ldw7oardptmn@var.youpi.perso.aquilenet.fr>
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
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, MCDONALD Margaret <margaret.mcdonald@hexagon.com>

>Could you run tcpdump inside the guest so we are sure what the nslookup ca=
ll emits?

Is there another way to determine this info? My guest OS is an embedded sys=
tem with BusyBox 1.25 and not much else.

Mark.
