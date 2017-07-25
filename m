Received: from eggs.gnu.org ([2001:4830:134:3::10]:39666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dZzmD-0004iF-Qo
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dZzm8-0005kn-TC
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:21:29 -0400
Date: Tue, 25 Jul 2017 14:21:21 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170725132121.GD23343@stefanha-x1.localdomain>
References: <20170724153952.26510-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Content-Disposition: inline
In-Reply-To: <20170724153952.26510-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 0/2] Test for bug
 fixes from byte-based block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 10:39:50AM -0500, Eric Blake wrote:
> Kevin is correct, and I need tests of my recent bug fixes :)
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07235.html
>=20
> Eric Blake (2):
>   iotests: Check dirty bitmap statistics in 124
>   iotests: Add test of recent fix to 'qemu-img measure'
>=20
>  tests/qemu-iotests/124     |  7 +++++-
>  tests/qemu-iotests/190     | 59 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  tests/qemu-iotests/190.out | 11 +++++++++
>  tests/qemu-iotests/group   |  1 +
>  4 files changed, 77 insertions(+), 1 deletion(-)
>  create mode 100755 tests/qemu-iotests/190
>  create mode 100644 tests/qemu-iotests/190.out
>=20
> --=20
> 2.13.3
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZd0XRAAoJEJykq7OBq3PI4FcIAMNy+4TJzNQDB5O8RVlWvukh
t8HYVSZnj6bAeDuD3O8B1EkDhziUDRZsNeoshuxuZrIxMKNV7HuyEhN9mCZmr8th
NhzDF/XFJchUx+vguzEGz//l2oWvixjTKDkYKmbu4G9ctIPpna3d0BZ9wk6aSDMt
2Jo0eFb1K3bdtch6Hjnkan3pY3rwj6GZ6glprR0dJiOjywwvsA2uBsF4KilZsH8s
moNjT6LqZi21wqpswMSnlIlQcCqgUaYLDHcUYm/xdSoNxERMMqbdggzAQSho3emt
jRFzib7/bJ/KKnF2S+65+03sMKihLa2BtC3QGkagE5dx0G3zgluEECM2hnf15XU=
=VRtc
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--
