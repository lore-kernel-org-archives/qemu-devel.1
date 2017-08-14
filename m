Received: from eggs.gnu.org ([2001:4830:134:3::10]:60381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhJyl-0004ym-CZ
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 14:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhJyh-00061G-Rq
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 14:20:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dhJyh-0005y8-Co
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 14:20:39 -0400
References: <mailman.1778.1502715001.21954.qemu-devel@nongnu.org>
	<223B4DEC-A801-40E3-A118-33EBB9ED384D@gmail.com>
	<20170814140003.GF8506@redhat.com>
	<EEABAA69-F4C9-4525-8A01-CDF143BAD31B@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b4268987-e25d-02fc-3931-7b9576969cc5@redhat.com>
Date: Mon, 14 Aug 2017 13:20:33 -0500
MIME-Version: 1.0
In-Reply-To: <EEABAA69-F4C9-4525-8A01-CDF143BAD31B@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jmQ5VbtDiIMSh4o7KC0V2eM71WURDSPB1"
Subject: Re: [Qemu-devel] [PATCH v3 00/12] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jmQ5VbtDiIMSh4o7KC0V2eM71WURDSPB1
From: Eric Blake <eblake@redhat.com>
To: Programmingkid <programmingkidx@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <b4268987-e25d-02fc-3931-7b9576969cc5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/12] Convert over to use keycodemapdb
References: <mailman.1778.1502715001.21954.qemu-devel@nongnu.org>
 <223B4DEC-A801-40E3-A118-33EBB9ED384D@gmail.com>
 <20170814140003.GF8506@redhat.com>
 <EEABAA69-F4C9-4525-8A01-CDF143BAD31B@gmail.com>
In-Reply-To: <EEABAA69-F4C9-4525-8A01-CDF143BAD31B@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/14/2017 12:20 PM, Programmingkid wrote:
>> These are based against git master, just save the series and then 'git=
 am'
>> the lot in one go.
>=20
> Is there a tool that can be used to download a series of patches from a=
 mailing list? Copying and pasting patches sometimes introduces problems.=
=20

'git am'.  I find it works well to save the patch series into a single
mailbox, then save that mailbox for the file to feed to git am.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jmQ5VbtDiIMSh4o7KC0V2eM71WURDSPB1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmR6fEACgkQp6FrSiUn
Q2oYkwgAijnank6cGQ0r7Q9r31WXO3DzhiwWBMNzHxmqC/qRbbgnozXmMroc2ZUD
2kbq318wliV/gY9I842SROdC9sEkn1grudNUgOpdjBsRBfGhMQ549o/zVe8R0Rjz
csg0MxzzroC5sl4aSLGdr9hRzGFVsOKRaeFf2p2nHTFhFHcG69ar4P4H81JB0UVr
h8YzV1XQuNdUExxdzAGNzFa3gvxOYlxF+hBCI9+9kPXv4kIfIwNKkdo3BXM8LJzW
ZZ75KBcZh0h35qV90E7XJtGOoSBJbLzGg/agTdvSTZHrroXyD7uUpC8EWJQ2U94z
TPvOv3GDpNUBg39yM53pWdD2x1mAzQ==
=sKag
-----END PGP SIGNATURE-----

--jmQ5VbtDiIMSh4o7KC0V2eM71WURDSPB1--
