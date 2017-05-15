Received: from eggs.gnu.org ([2001:4830:134:3::10]:57298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAGtT-0005iu-9E
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAGtS-0004Hq-82
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:22:39 -0400
References: <20170515103551.31313-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b5e4d8ea-fffe-71c5-81f7-7cc948b6df92@redhat.com>
Date: Mon, 15 May 2017 09:22:22 -0500
MIME-Version: 1.0
In-Reply-To: <20170515103551.31313-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Vd0VSaEdmNPoh468d6F4RDnaf628foOqD"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Fix documentation of convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Vd0VSaEdmNPoh468d6F4RDnaf628foOqD
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <b5e4d8ea-fffe-71c5-81f7-7cc948b6df92@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Fix documentation of convert
References: <20170515103551.31313-1-famz@redhat.com>
In-Reply-To: <20170515103551.31313-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/15/2017 05:35 AM, Fam Zheng wrote:
> It got lost in commit a8d16f9ca "qemu-img: Update documentation for -U"=
=2E
>=20
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  qemu-img-cmds.hx | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Vd0VSaEdmNPoh468d6F4RDnaf628foOqD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZGbmeAAoJEKeha0olJ0NqUpIIAIJN6Kwa9DTXJ8r3xHMeMWnN
yEk+Grv4n2QFQAQEOMGSE7mOR1sLeoka2RaFNtSfvK6CjERKhOWwgYs935niMHwP
zDLuJrA2LYVvgekASl9PJVeG45w7hh/hXJoqnXV3JnmRT+u4stBfYuqZOmI7jfKF
DL9tDVIgS8vZEqVc7qUFiy13l2PHIAjy/rq7PRFwvskNjUCmwnI3BwrHEXpI3xcj
/CS9HL5kXVZ3xqZvYkhTHQXNt3CKYgM+FOAdIBhG6h1l7pEhV+xcBetJoRymLZfu
Bg9+Pge8zrgIemJSncG1NHbAMgErtDJmHzRSauEpfGy1XyIKIDMEjt0Ih+eGysw=
=2nEu
-----END PGP SIGNATURE-----

--Vd0VSaEdmNPoh468d6F4RDnaf628foOqD--
