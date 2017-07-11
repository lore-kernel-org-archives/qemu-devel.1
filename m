Received: from eggs.gnu.org ([2001:4830:134:3::10]:42020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUxdy-0002np-3U
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUxdt-0002CG-7U
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:04:10 -0400
Date: Tue, 11 Jul 2017 17:04:00 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170711160400.GE31231@stefanha-x1.localdomain>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-10-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PGNNI9BzQDUtgA2J"
Content-Disposition: inline
In-Reply-To: <20170704220346.29244-10-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/35] block: bdrv_create() and
 bdrv_debug_event() are coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>


--PGNNI9BzQDUtgA2J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 12:03:20AM +0200, Marc-Andr=E9 Lureau wrote:
> Called from coroutine.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/block/block_int.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PGNNI9BzQDUtgA2J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZPbwAAoJEJykq7OBq3PIdp0IAK9ftcpjW4xjq2Ns/4q2bGXu
KPxLfBQlG2pAtOl+y+ghagSseHadilaRhynOfCKorgBwJLKzxn6pn2r6dNmAvUgb
RtSUcpvQ4GwhtCFI2uIt5citS+l9fbkXB8q3gkNXS0MnQ4USZ5WkxYg+ZZL7ql50
XDB1a5JSRRe/Ov+7OGnlKZf1b3vjR2D2JEPl0/FnjiKHnBC+znzLHb6Cqsxe2/EJ
xMjYn/9XrIj5hWZpzqnVbsDn3HD2XalyjAl/FZIdmbTJdL5vcHolEAJFb70x6CDe
IszYmgM2PUq5HKRLzLgQy9i/0CLdztv7ZektjbsLOAHgo2pud1HNk7GyiYUSPs8=
=OjM7
-----END PGP SIGNATURE-----

--PGNNI9BzQDUtgA2J--
