Received: from eggs.gnu.org ([2001:4830:134:3::10]:48235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnxmZ-0008Dc-Fe
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnxmU-0002hJ-Tz
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:31:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnxmU-0002h3-Ny
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:31:14 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-44-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8dd55f4d-1c0c-64e1-17bc-c798ffe82bb2@redhat.com>
Date: Tue, 14 Mar 2017 20:31:12 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-44-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2aEbWE4hAv66tKfOC9dXd3pC5Mwg9K8ug"
Subject: Re: [Qemu-devel] [PATCH for-2.9 43/47] qapi: struct_types is a list
 used like a dict, make it one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2aEbWE4hAv66tKfOC9dXd3pC5Mwg9K8ug
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <8dd55f4d-1c0c-64e1-17bc-c798ffe82bb2@redhat.com>
Subject: Re: [PATCH for-2.9 43/47] qapi: struct_types is a list used like a
 dict, make it one
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-44-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-44-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi.py | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--2aEbWE4hAv66tKfOC9dXd3pC5Mwg9K8ug
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyJlgAAoJEKeha0olJ0NqwJ4H/3aa5Bg9/irI7dVSmqv63MW4
o3g6xaWQZvbcW+N7gieCGCm5QlMzVreMEkPQ/6sKeq7J94mWd3sTJ49j+hiSEV9N
VX+AubBlIn1R/imxJWXfpN7YvKUSE6G8LtEnBKeMmJL9dGzNpcfwr5TyZKa0u/fW
jc5KEH8iTyvZBUKhroKcdnRIQQjC1RLJpBHHIlCiM3rc+eUlI//5JXPlZeZcuSdZ
KDh5gh99lq6D9K3WVtFqCInPiaTwNGqAtSZgGXjs43M62yx149Sp7ms2+ZN4ZjCb
SKcOvVQjTB+dglF9f5nQfOtqByp4qbEZDL3XdA0Tm3R/a3AT1nZ21q1x4QbCOT0=
=9Ctq
-----END PGP SIGNATURE-----

--2aEbWE4hAv66tKfOC9dXd3pC5Mwg9K8ug--
