Received: from eggs.gnu.org ([2001:4830:134:3::10]:52972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7j2P-0001N0-0f
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:49:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7j2L-0004xJ-UF
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:49:21 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d7j2L-0004xA-Q5
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:49:17 -0400
Received: by mail-qt0-x241.google.com with SMTP id a46so9577387qte.0
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 06:49:17 -0700 (PDT)
Date: Mon, 8 May 2017 09:49:14 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170508134914.GA28897@stefanha-x1.localdomain>
References: <20170508133908.12196-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20170508133908.12196-1-stefanha@redhat.com>
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


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2017 at 09:39:07AM -0400, Stefan Hajnoczi wrote:
> The following changes since commit dd1559bb267becbb838de41132ef60771d183e=
5d:
>=20
>   Merge remote-tracking branch 'elmarco/tags/chr-tests-pull-request' into=
 staging (2017-05-05 17:07:55 +0100)
>=20
> are available in the git repository at:
>=20
>   git://github.com/stefanha/qemu.git tags/tracing-pull-request
>=20
> for you to fetch changes up to f3fddaf60b9b983b82cd11e8087e7c8a3903ee14:
>=20
>   trace: disallow more than 10 arguments per trace event (2017-05-08 09:3=
8:30 -0400)
>=20
> ----------------------------------------------------------------
>=20
> ----------------------------------------------------------------
>=20
> Daniel P. Berrange (1):
>   trace: disallow more than 10 arguments per trace event
>=20
>  scripts/tracetool/__init__.py | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> --=20
> 2.9.3
>=20
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZEHdaAAoJEJykq7OBq3PIDA4IALy/VfiAS+0byfUQPRuyqGBr
Dj4T0UixoHv4TD/yLPAikyDFRAdRz3hTqimteSKbZRNMeum9BCXwjdxRBnYsJIaN
zOjXUyRFTcxoSHrTE67EkyyQbgXUaUVqURtFNhCOjxPYo4uOCHF1bchxM8en7ry3
/6RHv9VYm6yqFYeoPlQTcEts4/ra4tqEQ7AcSYe2vj3vav/yOZFfbKT0n7uJ34Tf
tXX+HveVRkz5aIeVZQVd7OzbpMNqX35YeTXPjwWDIItrMEwndN0yv3NRN9m4RzFl
CYbiELXn22GmUahulG5eh/GH/i5c8Y3aRDG/OZctWUouCJXY3YF8Tt9Sy8Zy6Pg=
=ZYr0
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
