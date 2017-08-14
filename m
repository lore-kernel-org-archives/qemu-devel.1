Received: from eggs.gnu.org ([2001:4830:134:3::10]:47025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dhJ2A-0005lG-7B
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 13:20:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dhJ25-00014j-7l
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 13:20:10 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:38245)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dhJ25-00014L-2p
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 13:20:05 -0400
Received: by mail-it0-x244.google.com with SMTP id f16so8311410itb.5
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 10:20:05 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20170814140003.GF8506@redhat.com>
Date: Mon, 14 Aug 2017 13:20:02 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <EEABAA69-F4C9-4525-8A01-CDF143BAD31B@gmail.com>
References: <mailman.1778.1502715001.21954.qemu-devel@nongnu.org>
	<223B4DEC-A801-40E3-A118-33EBB9ED384D@gmail.com>
	<20170814140003.GF8506@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/12] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>


> On Aug 14, 2017, at 10:00 AM, Daniel P. Berrange <berrange@redhat.com> =
wrote:
>=20
> On Mon, Aug 14, 2017 at 09:39:56AM -0400, Programmingkid wrote:
>>=20
>>> On Aug 14, 2017, at 8:50 AM, qemu-devel-request@nongnu.org wrote:
>>>=20
>>> An update of:
>>>=20
>>> v1: =
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02047.html
>>> v2: =
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02471.html
>>>=20
>>> The keycodemap project[1] provides a database mapping between
>>> many different keysym/keycode/scancode sets, along with a
>>> tool to generate mapping/lookup tables in various programming
>>> languages. It is already used by GTK-VNC, SPICE-GTK and
>>> libvirt.
>>>=20
>>> This series enables its use in QEMU, thus fixing a great
>>> many bugs/ommissions in the 15+ key mapping tables people
>>> have manually written for QEMU.
>>=20
>> Would you have a git repository that has all your patches already =
applied? It would make testing your patches a lot easier.
>=20
> I only maintain stable public repos for pull requests.
>=20
> These are based against git master, just save the series and then 'git =
am'
> the lot in one go.

Is there a tool that can be used to download a series of patches from a =
mailing list? Copying and pasting patches sometimes introduces problems.=20=
