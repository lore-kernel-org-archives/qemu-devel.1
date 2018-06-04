Received: from eggs.gnu.org ([2001:4830:134:3::10]:33133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fPnEr-0002lP-EB
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fPnEl-0000J7-Kq
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:01:25 -0400
References: <20180531212435.165261-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <dda41351-9c0c-7d71-30ec-0e0c6defe148@redhat.com>
Date: Mon, 4 Jun 2018 13:01:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180531212435.165261-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ASYYRH7X24bkQfHKcJ1qGvX2Yw7SPDGur"
Subject: Re: [Qemu-devel] [PATCH] block: Ignore generated job QAPI files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ASYYRH7X24bkQfHKcJ1qGvX2Yw7SPDGur
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <dda41351-9c0c-7d71-30ec-0e0c6defe148@redhat.com>
Subject: Re: [PATCH] block: Ignore generated job QAPI files
References: <20180531212435.165261-1-eblake@redhat.com>
In-Reply-To: <20180531212435.165261-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-31 23:24, Eric Blake wrote:
> Commit bf42508f introduced new generated files; make sure they
> don't get accidentally committed from an in-tree build.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  .gitignore | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--ASYYRH7X24bkQfHKcJ1qGvX2Yw7SPDGur
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsVG/YACgkQ9AfbAGHV
z0BU+Qf/cjYXqLEuOkQSGTZkyqGJGlZxtfh8BuS2Zqb24DwYCL6QR6iYWk84pKmU
ZJybJGr+ndJ76XJA0MbjGlNZqGb/qde2GKEBHryFSe2LA98Nw82z3r7chGVLhzrQ
gWEVcmhKYyHCdR3MWqvPZZUkA6dUrnkGm6oYAOXcTNkqWjlXA3mV1qRQMzU2CATW
I53maqZQW2KaoyEB4/bTB6LO5yy4tcJSfK/bNRwpcjN9Liw1ZSSKXxGIOQJ3IVG0
RrEtPq8wLKSFQ4fCt7fJ/3rLyxswgVd/hF9jWlCAwSucsabpopvJOUfqktM/25r2
CO3FEJijqUU5dFsQhPKM5LGudZiZhw==
=KGKi
-----END PGP SIGNATURE-----

--ASYYRH7X24bkQfHKcJ1qGvX2Yw7SPDGur--
