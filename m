Received: from eggs.gnu.org ([2001:4830:134:3::10]:37690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gAD8q-0007Mu-NP
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gAD8l-0000M1-MV
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:59:04 -0400
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:54467)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gAD8l-0000LJ-FT
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:58:59 -0400
Received: from player687.ha.ovh.net (unknown [10.109.146.1])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id B217936FB4
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 13:58:57 +0200 (CEST)
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20180928135003.8650-1-clg@kaod.org>
	<e6e6fff6-8983-e97a-073b-e8fb906e13cf@kaod.org>
Message-ID: <8a302ca4-34b8-5b69-1ab2-14826ca87b56@kaod.org>
Date: Wed, 10 Oct 2018 13:58:54 +0200
MIME-Version: 1.0
In-Reply-To: <e6e6fff6-8983-e97a-073b-e8fb906e13cf@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/11] net: convert SysBus init method to a
 realize method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

On 10/10/18 1:57 PM, C=C3=A9dric Le Goater wrote:
> Hello,
>=20
> On 9/28/18 3:49 PM, C=C3=A9dric Le Goater wrote:
>> Hello,
>>
>> Here is my take to the SysBus init to realize method conversion. I
>> picked the /net directory and did them all. Also added a couple of
>> reset methods in separate patches.
>>
>> make check tested
>=20
> Do we have enough review for this series ? if so, may be it could
> go through Jason's tree ?

I meant v2.

	https://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D68378

Thanks,

C.
