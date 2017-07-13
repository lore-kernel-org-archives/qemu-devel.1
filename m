Received: from eggs.gnu.org ([2001:4830:134:3::10]:48399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dVkGV-0003kH-Qx
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 15:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dVkGS-0000pJ-0a
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 15:59:11 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:33776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dVkGR-0000p4-Rj
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 15:59:07 -0400
Received: by mail-it0-x244.google.com with SMTP id 188so8988629itx.0
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 12:59:07 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <c9179f0b-d978-31ad-19d5-2f4070a1b1b1@denx.de>
Date: Thu, 13 Jul 2017 15:59:04 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <C1AED432-9B05-4B84-AB8D-6BC1AEDEE4F8@gmail.com>
References: <4EE89732-1A49-4D45-B94A-F8A57873E6EB@gmail.com>
	<1a59d15c-9bba-fa7b-198b-bf4bbdc11488@denx.de>
	<C130A840-281E-4A82-A4E1-4142261AB2FC@gmail.com>
	<c9179f0b-d978-31ad-19d5-2f4070a1b1b1@denx.de>
Subject: Re: [Qemu-devel] Nios2 documentation page now up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marek Vasut <marex@denx.de>
Cc: crwulff@gmail.com, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


On Jul 13, 2017, at 3:01 PM, Marek Vasut wrote:

> On 07/13/2017 08:23 PM, Programmingkid wrote:
>>=20
>> On Jul 13, 2017, at 10:48 AM, Marek Vasut wrote:
>>=20
>>> On 07/13/2017 04:28 PM, Programmingkid wrote:
>>>> Hi I have recently created a new documentation page for the Nios2 =
target. I would greatly appreciate any feedback you might have on it. =
Thank you.
>>>=20
>>> Great, thanks !
>>>=20
>>> A few nits, we also support nios2 userspace binary emulation. And =
Nios2
>>> is I believe Altera specific. And we only support Nios2 R1 EL thus =
far.
>>>=20
>>>> Page: http://wiki.qemu.org/Documentation/Platforms/Nios2
>>>>=20
>>=20
>> Thank you for the info. Did the suggested command line look good to =
you?
>=20
> I mean, ./configure --target-list=3Dnios2-softmmu,nios2-linux-user =
when I
> say that userspace linux binary emulation is supported.

I just did a git pull and tried your configure command. This is the =
error I saw:

ERROR: Unknown target name 'nios2-linux-user'

>=20
>> Also would you know of any pre-made images the user could download to =
test the emulator?=20
>=20
> I build them using OE with meta-altera myself.

Actually I was talking about a HD image file the user could try to boot =
from. A simple test image file would be good enough.=20

>=20
>> I will add your note about how only Nios2 R1 EL is currently =
supported.
>>=20
>> If you have any pictures of this emulator running I would be glad to =
add them to the wiki page.=20
>=20
> Not at the moment, just a random post on my G+ (which I'd prefer to =
NOT
> have linked in the wiki) ; although feel free to copy-paste the =
console
> output:
>=20
> https://plus.google.com/+MarekVa%C5%A1ut/posts/BEvfXANeCs7

I will be glad to post any pictures whenever you decide to add pictures =
to the wiki page.
