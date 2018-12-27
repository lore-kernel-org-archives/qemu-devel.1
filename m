Received: from eggs.gnu.org ([208.118.235.92]:49476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gcdBh-0001bn-Ts
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 16:27:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gcdBe-000396-N6
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 16:27:29 -0500
Received: from mail-eopbgr690123.outbound.protection.outlook.com
	([40.107.69.123]:15232
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gcdBe-00035Q-BP
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 16:27:26 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 27 Dec 2018 21:27:19 +0000
Message-ID: <BN6PR2201MB1251D10E47C4B6103334BF3CC6B60@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20181217200444.14812-1-aleksandar.markovic@rt-rk.com>
In-Reply-To: <20181217200444.14812-1-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/6] target/mips: Amend MXU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jancraig@amazon.com" <jancraig@amazon.com>, Stefan Markovic <smarkovic@wavecomp.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Subject: [PATCH 0/6] target/mips: Amend MXU support
>=20
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> Various updates to MXU ASE support.
>=20
> Aleksandar Markovic (6):
>  target/mips: MXU: Add missing opcodes/decoding for LX* instructions
>  target/mips: MXU: Add generic naming for optn2 constants
>  target/mips: MXU: Improve textual description
>  target/mips: MXU: Add handlers for logic instructions
>  target/mips: MXU: Add handlers for max/min instructions
>  target/mips: MXU: Add handlers for an align instruction

If there is no objection, to get things going a little, I am going to integ=
rate patches 1, 2, and 3 into next MIPS pull request (scheduled shortly), w=
hile it looks other patches need more time for review.

(patch 1 is about "pool 17", issues around "pool 16" will be covered in a s=
eparate patch in v2)

Thanks to everyone,
Aleksandar=
