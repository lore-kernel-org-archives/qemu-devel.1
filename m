Received: from eggs.gnu.org ([2001:4830:134:3::10]:41877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eXBsP-0004Wc-Az
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 15:12:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eXBsM-0002bZ-Lw
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 15:12:33 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:38894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1eXBsM-0002ax-HA
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 15:12:30 -0500
Received: by mail-it0-x243.google.com with SMTP id r6so3705805itr.3
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 12:12:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <f555034b-6952-0261-04d6-8707f7c11969@vivier.eu>
Date: Thu, 4 Jan 2018 15:12:28 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <0D867083-B7EF-4A13-B262-8B45EC88B0B2@gmail.com>
References: <mailman.16196.1515084191.27993.qemu-devel@nongnu.org>
	<AE31CFE4-27FD-40F8-81E3-0D7A8A9DE36E@gmail.com>
	<bee022ee-30de-586a-d892-68291159de77@vivier.eu>
	<6975EB15-A268-4332-AA38-B31BFA22F4E8@gmail.com>
	<f555034b-6952-0261-04d6-8707f7c11969@vivier.eu>
Subject: Re: [Qemu-devel] [PULL 00/17] M68k for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>


> On Jan 4, 2018, at 2:52 PM, Laurent Vivier <laurent@vivier.eu> wrote:
>=20
> Le 04/01/2018 =C3=A0 20:26, Programmingkid a =C3=A9crit :
>>=20
>>> On Jan 4, 2018, at 12:32 PM, Laurent Vivier <laurent@vivier.eu> =
wrote:
>>>=20
>>> Le 04/01/2018 =C3=A0 18:09, Programmingkid a =C3=A9crit :
>>>> What operating systems boot with this patch set? Does any version =
of the Mac OS run in this 68k emulator?=20
>>>>=20
>>>=20
>>> For the moment you can't boot anything more than the coldfire linux
>>> kernel with the semi-hosting patch.
>>>=20
>>> The remaining patches I have in my git branch allows to boot a =
debian
>>> etch-m68k with GNOME or a the latest debian unstable (without GNOME)
>>>=20
>>> git clone -b q800-dev https://github.com/vivier/qemu-m68k.git
>>>=20
>>> I'm working on booting MacOS...
>>>=20
>>> I think we should also be able to boot NeXTSTEP , but the work of =
Bryce
>>> Lanham (GSoC 2011) must be rebased on my branch and cleaned up.
>>=20
>> If you have any pictures of guests running in QEMU I would be =
interested in posting the pictures on the wiki page here: =
https://wiki.qemu.org/Documentation/Platforms/68k.
>>=20
>=20
> Can you add a video instead?
>=20
> https://www.youtube.com/watch?v=3DwKpzBwsLmhw
>=20
> Laurent

I can do both :)
