Received: from eggs.gnu.org ([2001:4830:134:3::10]:35717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqA7X-0007Tb-Qq
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqA7U-00028Y-Mn
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:06:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cqA7U-00027W-Ch
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:06:00 -0400
References: <1490011066479-474158.post@n7.nabble.com>
	<1490055970461-474432.post@n7.nabble.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7272f3e8-0bf3-8c16-f51a-2ed293bddb50@redhat.com>
Date: Mon, 20 Mar 2017 22:05:58 -0500
MIME-Version: 1.0
In-Reply-To: <1490055970461-474432.post@n7.nabble.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m8E9ke1NQ0xPvjxLJrhqvREivVm6hncNa"
Subject: Re: [Qemu-devel] [PATCH v4]COLO:Fix Colo doc,
 secondeary should be secondary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wangguang <wang.guang55@zte.com.cn>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m8E9ke1NQ0xPvjxLJrhqvREivVm6hncNa
From: Eric Blake <eblake@redhat.com>
To: wangguang <wang.guang55@zte.com.cn>, qemu-devel@nongnu.org
Message-ID: <7272f3e8-0bf3-8c16-f51a-2ed293bddb50@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4]COLO:Fix Colo doc, secondeary should be
 secondary
References: <1490011066479-474158.post@n7.nabble.com>
 <1490055970461-474432.post@n7.nabble.com>
In-Reply-To: <1490055970461-474432.post@n7.nabble.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/20/2017 07:26 PM, wangguang wrote:
> Subject: [PATCH] Fix Colo doc secondeary should be secondary This is an=
 error
> in COLO-FT.txt. secondeary-disk0 should be secondary-disk0. Signed-off-=
by:

> --
> View this message in context: http://qemu.11.n7.nabble.com/

Nabble may be a fine platform for viewing mailing list archives, and
even for commenting on existing posts without having a subscription, but
it is absolutely LOUSY at sending patches.  Please don't try to abuse
nabble for sending patches, but rather figure out how to get 'git
send-email' working properly.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--m8E9ke1NQ0xPvjxLJrhqvREivVm6hncNa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0JiWAAoJEKeha0olJ0NqpGMIAJ3kCm9sMPY98wV/kJPDSJBd
TZicuo6yxFOfQfola0RoHZyFqJp4drtAJu98xAlhrfUKA9D85m4c0IM093lTGzUK
su81NlU8VjbWXCWRFFVyI30WIN+ITyHZ+4Vv/0d1Ps8Y1TiomTsNi1g58nIcEq4p
DAUG42TdlSLAuQ/wTMO/OvR8dPunIQAbkhuLt4ogkoNpffK3Cn1alC5ytxaZcyJy
Z5sCEas4+Uhy21r7CkxlqXfu1/52dX6tH9mmUIKCNuGlqEkAhqpbqaCBsCLuZtlB
g1WKE3mlSBd1CPX+fNGavg6Az1TpFVc7v5MBLVrZUJjVax91vRR/W9hj81ZEOC0=
=C9t6
-----END PGP SIGNATURE-----

--m8E9ke1NQ0xPvjxLJrhqvREivVm6hncNa--
