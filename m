Received: from eggs.gnu.org ([209.51.188.92]:35880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1h0ncY-0001lL-HA
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 08:27:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1h0ncW-00086u-F5
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 08:27:06 -0500
Received: from mail-eopbgr760118.outbound.protection.outlook.com
	([40.107.76.118]:34014
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1h0ncW-000850-2m
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 08:27:04 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 4 Mar 2019 13:27:00 +0000
Message-ID: <BN6PR2201MB1251959BC139F153BD5760A2C6710@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1550491301.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1550491301.git.balaton@eik.bme.hu>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Misc MIPS fulong2e improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Huacai Chen <zltjiangshi@gmail.com>, "philmd@redhat.com" <philmd@redhat.com>

> From: BALATON Zoltan <balaton@eik.bme.hu>
> v2 of http://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg02477.ht=
ml
> Addressed review comments and removed last patch (sending it
> separately) to make this series not depend on my ati-vga patch so it
> can be applied independently.

I plan to add bin file (that you mentioned) used for Fulong 2E tests into o=
ur
tree (in pc-bios directory, with an appropriate comment in pc-bios/README).
Please let me know if you this I should not do that, of if I should perhaps=
 include
more files, or different files, etc.

Regards,
Aleksandar=
