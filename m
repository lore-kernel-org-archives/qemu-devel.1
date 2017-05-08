Received: from eggs.gnu.org ([2001:4830:134:3::10]:37655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7lWH-00043d-GZ
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7lWG-00011J-LP
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:28:21 -0400
References: <20170428165517.30341-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <86054675-9a61-f6ad-1d3c-1bef5deae3a6@redhat.com>
Date: Mon, 8 May 2017 18:28:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170428165517.30341-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KQQ4AvPsw68hRWc1WsAefs6N7gOeIPnnE"
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add qemu-progress to the
 block layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KQQ4AvPsw68hRWc1WsAefs6N7gOeIPnnE
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <86054675-9a61-f6ad-1d3c-1bef5deae3a6@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Add qemu-progress to the block layer
References: <20170428165517.30341-1-mreitz@redhat.com>
In-Reply-To: <20170428165517.30341-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28.04.2017 18:55, Max Reitz wrote:
> util/qemu-progress.c is currently unmaintained. The only user of its
> functionality is qemu-img, so it effectively is part of the block layer=
=2E
>=20
> Suggested-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--KQQ4AvPsw68hRWc1WsAefs6N7gOeIPnnE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkQnJwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AyFIIAJTbcnfddu4UJOI0HwkfgR1hIjPgsxRg
3vbAKFVJYAKA5195sbvJLfGRcNbeOBrAmckYfaqJfhwNrCF5lNcVerhlg271LbyG
YrRFARZPiYrl0T6iBRQD6NpHsHobH9CMBUUbZXVb8/zhlwMS9YZg51P6OEyqxh5E
ZhW+8D8uBe0gSTb6pI9D5AXWlaMxwNRakR00R0DkZ5Vgx/1azUD9ydapMZBs5R23
z+uzbbFXjNhUSEIl9qowT+Mb5CMklVV3lbeBjVyfsXHf/jYcXA5aUnltI9uTfN9x
kOt+Ho2lj/OawEbWCWhIMcnOxpo0xk0TnxnKumOhBZ9a8L6GxyM4/g4=
=cffc
-----END PGP SIGNATURE-----

--KQQ4AvPsw68hRWc1WsAefs6N7gOeIPnnE--
