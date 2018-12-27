Received: from eggs.gnu.org ([208.118.235.92]:34024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gcc1I-0000Sp-KK
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 15:12:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gcc1D-0002Ld-Gn
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 15:12:40 -0500
Received: from mail-eopbgr680111.outbound.protection.outlook.com
	([40.107.68.111]:44526
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gcc1C-00028J-Sk
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 15:12:35 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 27 Dec 2018 20:12:29 +0000
Message-ID: <BN6PR2201MB12511122A92CA2470668238AC6B60@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20181217200444.14812-1-aleksandar.markovic@rt-rk.com>
	<20181217200444.14812-2-aleksandar.markovic@rt-rk.com>
	<48756599-1566-8b46-b742-40cea97bce15@wavecomp.com>,
	<32edc91d04374cfd8fb50bc26c9bd320@EX13D12UEA003.ant.amazon.com>
	<BN6PR2201MB1251B2C0C45E6E2BE91E60EEC6B60@BN6PR2201MB1251.namprd22.prod.outlook.com>,
	<8a875112d29047afbf2d5f83a96d6230@EX13D12UEA003.ant.amazon.com>
	<BN6PR2201MB12515E6A3326FD0F6A769E06C6B60@BN6PR2201MB1251.namprd22.prod.outlook.com>,
	<e23100879dcf440180ca19debf324d37@EX13D12UEA003.ant.amazon.com>
In-Reply-To: <e23100879dcf440180ca19debf324d37@EX13D12UEA003.ant.amazon.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/6] target/mips: MXU: Add missing
 opcodes/decoding for LX* instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Janeczek, Craig" <jancraig@amazon.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Janeczek, Craig <jancraig@amazon.com>
>
> Yes, both the comment and enum should be updated.

OK, this will be fixed in v2.

Thanks,
Aleksandar=
