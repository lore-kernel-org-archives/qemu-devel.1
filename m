Received: from eggs.gnu.org ([2001:4830:134:3::10]:50718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gNcll-0004Bd-28
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 06:58:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gNclc-0003ir-4e
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 06:58:38 -0500
Received: from mail-eopbgr740125.outbound.protection.outlook.com
	([40.107.74.125]:23303
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gNcla-0003dp-St
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 06:58:32 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 16 Nov 2018 11:58:21 +0000
Message-ID: <BN6PR2201MB1251A73A6407CCD722F98CCDC6DD0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1542202628-6538-1-git-send-email-stefan.markovic@rt-rk.com>,
	<bbd30407-51c9-1719-f3e3-baf22d7ebe7f@vivier.eu>
In-Reply-To: <bbd30407-51c9-1719-f3e3-baf22d7ebe7f@vivier.eu>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] linux-user: Update MIPS specific prctl()
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Stefan Markovic <smarkovic@wavecomp.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, Petar Jovanovic <pjovanovic@wavecomp.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>

From: Laurent Vivier <laurent@vivier.eu>

> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>=20
> If you plan to do a MIPS p-r before the next RC, don't hesitate to add
> this patch to it (my linux-user queue is empty for the moment).

Laurent,

I plan to create a MIPS pull request in next few days, and I am
going to include this patch in it (unless you tell me not to do so).

Thanks a bunch!!

Aleksandar
