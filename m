Received: from eggs.gnu.org ([2001:4830:134:3::10]:54694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dxYHY-00084j-9h
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dxYHV-0008RG-8E
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:51:12 -0400
Received: from 1.mo177.mail-out.ovh.net ([178.33.107.143]:47369)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dxYHV-0008Qv-2G
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:51:09 -0400
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id CD0AE80BAA
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 14:51:05 +0200 (CEST)
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-19-clg@kaod.org> <20170919084406.GX27153@umbus>
	<5d9394e6-0e3f-7824-dd23-04107eb22582@kaod.org>
	<20170921013548.GB4998@umbus.fritz.box>
	<50588b22-8081-c353-9d83-70cf29a4daa4@kaod.org>
	<1506588226.25626.29.camel@kernel.crashing.org>
	<bb16322a-129d-6aa0-2d84-e06978ac3cae@kaod.org>
	<1506593024.25626.33.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <343aea30-4a14-5f66-d7b6-1b53d92f0288@kaod.org>
Date: Thu, 28 Sep 2017 14:50:58 +0200
MIME-Version: 1.0
In-Reply-To: <1506593024.25626.33.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 18/21] ppc/xive: add device tree
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>

On 09/28/2017 12:03 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2017-09-28 at 10:51 +0200, C=C3=A9dric Le Goater wrote:
>> probably, I just removed the properties under QEMU and could=20
>> boot the guest, with disks and network.
>=20
> As long as you don't use LSIs...

That I didn't test much. Which the devices could I use for=20
the guest ?=20

Thanks, =20

C.
