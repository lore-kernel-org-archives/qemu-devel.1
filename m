Received: from eggs.gnu.org ([2001:4830:134:3::10]:41973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d5YVT-0000Z6-VZ
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d5YVN-0007tK-3W
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:10:23 -0400
Date: Tue, 2 May 2017 15:10:02 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170502141002.GG22502@stefanha-x1.localdomain>
References: <20170428165517.30341-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="64j1qyTOoGvYcHb1"
Content-Disposition: inline
In-Reply-To: <20170428165517.30341-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] MAINTAINERS: Add
 qemu-progress to the block layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--64j1qyTOoGvYcHb1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2017 at 06:55:17PM +0200, Max Reitz wrote:
> util/qemu-progress.c is currently unmaintained. The only user of its
> functionality is qemu-img, so it effectively is part of the block layer.
>=20
> Suggested-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--64j1qyTOoGvYcHb1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCJM6AAoJEJykq7OBq3PI3RcH/1MCOVGl9k4WeX7UAr1mh2+L
SZyknYd/2gG6Lq33QgmkYsRicJWyBfF18xR9DwW/lc99JmjGeR5d5HedMidQE4SG
5Cb8QNhp1bYM0NGPQkruiVRMnIKt5syA/bs0CsGWjP6j6meiZuN6JeNerFdgTlX/
OOud09UUYGubnuoJx6OPX4WRkzh5CQXoovDlMmd8fU3+yGWhCTWbBRwM7dxENo7A
EAUlq4Tgmaii93R4zYPDlJwkWOLfh0TPOga99GUcLMJPuJ5543luR6LpQMG4QP+s
F9AlwS/UItup6yQfWs/IlX8QGzKl2SvS3poSMWJQRoB6eVk4tv3Wpvs5GWvTDqM=
=8LUi
-----END PGP SIGNATURE-----

--64j1qyTOoGvYcHb1--
