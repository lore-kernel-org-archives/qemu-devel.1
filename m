Received: from eggs.gnu.org ([2001:4830:134:3::10]:54675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gL7vF-0000im-SX
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:38:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gL7vC-0003T7-Q4
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:38:09 -0500
Received: from mail-eopbgr700105.outbound.protection.outlook.com
	([40.107.70.105]:28160
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gL7vC-0003Lc-Hj
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:38:06 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 9 Nov 2018 14:37:55 +0000
Message-ID: <BN6PR2201MB12513465BDF12670379AA72DC6C60@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1541616663.git.noring@nocrew.org>
	<e8e6bfd053f051d5195ec030f06749b24f867b13.1541616663.git.noring@nocrew.org>
	<BN6PR2201MB12512C561DAD7AE29946682CC6C50@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<BN6PR2201MB1251F9977B0D4B901801275CC6C60@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181109132411.GA2303@sx9>
	<BN6PR2201MB12512E2D06C8A6CD54BBEE8EC6C60@BN6PR2201MB1251.namprd22.prod.outlook.com>,
	<20181109143529.GA10409@sx9>
In-Reply-To: <20181109143529.GA10409@sx9>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 4/6] target/mips: Fix decoding mechanism
 of special R5900 opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Fredrik Noring <noring@nocrew.org>
> Subject: Re: [PATCH v2 4/6] target/mips: Fix decoding mechanism of specia=
l R5900 opcodes
>=20
> Hi Aleksandar,
>=20
> > Tx79 mentions the opposite: that DDIV, DDIVU, DMULT, DMULTU are not
> > included in R5900 set.
> >
> > I think that the best solution that you exclude DDIV, DDIVU, DMULT, DMU=
LTU
> > in a separate patch - there is no document to support their inclusion.
>=20
> As Maciej noted, the 64-bit MIPS Linux psABI is indivisible, so how could
> your alternative possibly work?

Provide the document, and then let's talk.

Thanks,
Aleksandar=
