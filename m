Received: from eggs.gnu.org ([2001:4830:134:3::10]:45277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAGDP-0000oO-MF
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAGDM-00076q-IC
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:39:11 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:32903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dAGDM-00075Z-9t
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:39:08 -0400
Received: by mail-lf0-x244.google.com with SMTP id m18so269960lfj.0
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 06:39:08 -0700 (PDT)
Date: Mon, 15 May 2017 14:39:05 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170515133905.GK1201@stefanha-x1.localdomain>
References: <20170512143812.31067-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8kI7hWEHMS8Z+7/0"
Content-Disposition: inline
In-Reply-To: <20170512143812.31067-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PULL for-2.9 0/1] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>


--8kI7hWEHMS8Z+7/0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2017 at 10:38:11AM -0400, Stefan Hajnoczi wrote:
> The following changes since commit ecc1f5adeec4e3324d1b695a7c54e3967c5269=
49:
>=20
>   maintainers: Add myself as linux-user reviewer (2017-05-11 13:31:11 -04=
00)
>=20
> are available in the git repository at:
>=20
>   git://github.com/stefanha/qemu.git tags/tracing-pull-request
>=20
> for you to fetch changes up to 5651743c908d8c3b1ff0192ce9543a502ec7a206:
>=20
>   trace: add sanity check (2017-05-12 10:37:40 -0400)
>=20
> ----------------------------------------------------------------
>=20
> ----------------------------------------------------------------
>=20
> Anthony Xu (1):
>   trace: add sanity check
>=20
>  qom/cpu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> --=20
> 2.9.3
>=20
>=20

Thanks, applied to my master tree:
https://github.com/stefanha/qemu/commits/master

Stefan

--8kI7hWEHMS8Z+7/0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGa95AAoJEJykq7OBq3PI+nMH/RuehpKJjsSo9Ol3g6jZv58V
1/mYFZjBdWWyOjTrnFv3FR6CmC/uHn7UqPYXDNTuj0yadu9lrinFi/bcbW+Is6zW
TIh40dtdaU4Q1yME3Rt0JlFB8CxvdNEkjpjH71Qx7EgGzDrkhzj+tijKNxygiJZk
SbHKVXjb6lnCWwiz83KefhzFqKQu4gGA11jggMpi1O4gBjoqMS+dM/qRytKuvWlb
Lr81aCzGFbbADbeYrvn+ZoXx+fCPj6rL7tkuz5+DI/oagSPkh+ZlZwF39ObKod6v
SPTggLrhsxDF5/cx2vx5vtqjrFrFs4lDly8b8xdx+ll7XW2Hc3LXet3DlohciZk=
=dBZp
-----END PGP SIGNATURE-----

--8kI7hWEHMS8Z+7/0--
