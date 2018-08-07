Received: from eggs.gnu.org ([2001:4830:134:3::10]:36199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fmzJK-0003BT-1I
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fmzJG-0006gW-UH
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:33:54 -0400
Received: from 5.mo3.mail-out.ovh.net ([87.98.178.36]:57118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fmzJG-0006gC-NU
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:33:50 -0400
Received: from player772.ha.ovh.net (unknown [10.109.160.217])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 2741C1C2EA3
	for <qemu-devel@nongnu.org>; Tue,  7 Aug 2018 12:33:49 +0200 (CEST)
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20180807075757.7242-1-joel@jms.id.au>
	<20180807075757.7242-7-joel@jms.id.au>
	<e8ca4c53-a0d0-65bb-69f2-05a5201e4bf6@kaod.org>
Message-ID: <9053cce7-a3b9-420b-3623-9827e1b614f8@kaod.org>
Date: Tue, 7 Aug 2018 12:33:40 +0200
MIME-Version: 1.0
In-Reply-To: <e8ca4c53-a0d0-65bb-69f2-05a5201e4bf6@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 6/7] aspeed: add a max_ram_size
 property to the memory controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 08/07/2018 12:29 PM, C=C3=A9dric Le Goater wrote:
> On 08/07/2018 09:57 AM, Joel Stanley wrote:
>> From: C=C3=A9dric Le Goater <clg@kaod.org>
>>
>> This will be used to construct a memory region beyond the RAM region
>> to let firmwares scan the address space with load/store to guess how
>> much RAM the SoC has.
>=20
> This is in another patch I can send later on.

I now see that you have merged two patches. This is fine then.


Thanks,

C.
