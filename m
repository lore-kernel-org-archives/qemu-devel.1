Received: from eggs.gnu.org ([2001:4830:134:3::10]:37842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dhKQM-0004zg-Lz
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 14:49:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dhKQH-0002Rp-Qg
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 14:49:14 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:38820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dhKQH-0002RZ-LD
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 14:49:09 -0400
Received: by mail-io0-x243.google.com with SMTP id o9so8017248iod.5
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 11:49:09 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <b4268987-e25d-02fc-3931-7b9576969cc5@redhat.com>
Date: Mon, 14 Aug 2017 14:49:07 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <05CBF3D0-1FBE-4139-B968-9ED138206FFC@gmail.com>
References: <mailman.1778.1502715001.21954.qemu-devel@nongnu.org>
	<223B4DEC-A801-40E3-A118-33EBB9ED384D@gmail.com>
	<20170814140003.GF8506@redhat.com>
	<EEABAA69-F4C9-4525-8A01-CDF143BAD31B@gmail.com>
	<b4268987-e25d-02fc-3931-7b9576969cc5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/12] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>


> On Aug 14, 2017, at 2:20 PM, Eric Blake <eblake@redhat.com> wrote:
>=20
> On 08/14/2017 12:20 PM, Programmingkid wrote:
>>> These are based against git master, just save the series and then =
'git am'
>>> the lot in one go.
>>=20
>> Is there a tool that can be used to download a series of patches from =
a mailing list? Copying and pasting patches sometimes introduces =
problems.=20
>=20
> 'git am'.  I find it works well to save the patch series into a single
> mailbox, then save that mailbox for the file to feed to git am.
>=20

Thank you for the information. Can this be down when receiving emails as =
a digest, or does it only work for individual emails?=20
