Received: from eggs.gnu.org ([2001:4830:134:3::10]:57589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crSoM-0005KV-Gb
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:15:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crSoH-0008MD-JT
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:15:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1crSoH-0008M3-Dd
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:15:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 43202624B3
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 17:15:33 +0000 (UTC)
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-3-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5172eb13-0183-52a8-32af-4b37468ded67@redhat.com>
Date: Fri, 24 Mar 2017 12:15:30 -0500
MIME-Version: 1.0
In-Reply-To: <20170323204544.12015-3-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="l7Swm0HeBwOMKQRwxLhWwef1BWUx9x81w"
Subject: Re: [Qemu-devel] [PATCH 02/51] ram: rename block_name to rbname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l7Swm0HeBwOMKQRwxLhWwef1BWUx9x81w
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com
Message-ID: <5172eb13-0183-52a8-32af-4b37468ded67@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/51] ram: rename block_name to rbname
References: <20170323204544.12015-1-quintela@redhat.com>
 <20170323204544.12015-3-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-3-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/23/2017 03:44 PM, Juan Quintela wrote:
> So all places are consisten on the nambing of a block name parameter.

s/consisten/consistent/
s/nambing/naming/

>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--l7Swm0HeBwOMKQRwxLhWwef1BWUx9x81w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY1VQzAAoJEKeha0olJ0NqYzcIAKTfqRMlu7/IFUDB9yo1z565
5UoiW5zqXLKZzdc9KvRU3qqsB691GNefM1zVABmVGeP2E3T220d1sv7xOxALkmfn
dy/R66odu/X2WZkxLf+6KvfuZOZkGSXaB0YloJJwoa4Y8ZBkcBlYLdVt1bZQPg9k
wj/lD/MFk+EElDYbSFn5hv4U9i9SF6mn4uKVydNktHD3//vVruM+DMvLYTAGvv1x
RPysvK5rweofC+3M3nbryNesWKoK3Tvb7crJn4BQcHNg1G63VUS4712wcIZDkGG5
BpMQLswI8CmysqHZ46OolUyn8sGl2UtlwXLoH+/HmuRCbI8F38V03LJnG82kiO4=
=5wU3
-----END PGP SIGNATURE-----

--l7Swm0HeBwOMKQRwxLhWwef1BWUx9x81w--
