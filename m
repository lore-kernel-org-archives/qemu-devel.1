Received: from eggs.gnu.org ([2001:4830:134:3::10]:47167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cjbWV-0007Er-TR
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 19:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cjbWS-0002WI-TV
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 19:56:44 -0500
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:33031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1cjbWS-0002WA-OW
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 19:56:40 -0500
Received: by mail-io0-x243.google.com with SMTP id f84so9959327ioj.0
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 16:56:40 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <CAJhHMCDZY5JeifFgVn2MRAz1XvS=8C8cg7padnQWPGd0sepWtw@mail.gmail.com>
Date: Thu, 2 Mar 2017 19:56:38 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <2C876DAF-34C4-4472-A39F-5EF0088D3FAD@gmail.com>
References: <mailman.54661.1487925109.22739.qemu-devel@nongnu.org>
	<D18A2230-B3C1-46E9-A43E-291E5F672CBB@gmail.com>
	<87efynl9k1.fsf@linaro.org>
	<8EE0E791-D80F-416B-B145-5D423310B65C@gmail.com>
	<CAJhHMCDZY5JeifFgVn2MRAz1XvS=8C8cg7padnQWPGd0sepWtw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v14 00/24] MTTCG Base enabling patches with
 ARM enablement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>


On Feb 25, 2017, at 10:03 PM, Pranith Kumar wrote:

> On Sat, Feb 25, 2017 at 8:46 PM, Programmingkid
> <programmingkidx@gmail.com> wrote:
>>=20
>>=20
>> With the i386 target, I did see host CPU usage go up to 120%. That =
was nice
>> to see. Windows XP and Windows 2000 would not boot to the desktop for =
some
>> reason.
>=20
> For windows XP, you need the patch here:
> http://patchwork.ozlabs.org/patch/731915/
>=20
> Let me know if that patch helps.
>=20
> Thanks,
> --
> Pranith


The patch does make Windows 2000 work again. While playing a game I saw =
qemu-system-i386 use 120% of CPU usage, which shows mttcg patches are =
working. Thanks.=
