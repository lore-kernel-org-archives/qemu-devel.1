Received: from eggs.gnu.org ([209.51.188.92]:55303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghXfT-0004Ia-Ls
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghXfQ-00014N-Q6
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:34:30 -0500
Date: Thu, 10 Jan 2019 10:34:23 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190110103423.GF19025@stefanha-x1.localdomain>
References: <1545028456-2797-1-git-send-email-liq3ea@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DEueqSqTbz/jWVG1"
Content-Disposition: inline
In-Reply-To: <1545028456-2797-1-git-send-email-liq3ea@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] main-loop: remove unused header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-trivial@nongnu.org


--DEueqSqTbz/jWVG1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 16, 2018 at 10:34:16PM -0800, Li Qiang wrote:
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---

A candidate for the trivial patches tree.

>  util/main-loop.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/util/main-loop.c b/util/main-loop.c
> index affe0403c5..845a4b1f13 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -26,7 +26,6 @@
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "qemu/timer.h"
> -#include "qemu/sockets.h"	// struct in_addr needed for libslirp.h
>  #include "sysemu/qtest.h"
>  #include "sysemu/cpus.h"
>  #include "sysemu/replay.h"
> --=20
> 2.11.0
>=20
>=20

--DEueqSqTbz/jWVG1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcNx+vAAoJEJykq7OBq3PIlNAH/2qlNPFdnCjjvU+/5Dog2E2x
Nl8ruMYPt0pgLfTs91LN68F+Nx/jSWNXBjZpbz6q3RoVcelEB16SGZ7jerNrufvT
LSbMwqNek6yK4r1mBuk/Tpq76mSlrgNpl7FOUrpawhdowXHv1Zbcg59+AxKr9hX3
GfN8a6oa9m3Ywm6VmRTWhsQvIb2EBVixJ9HQIb+qacZ7XcaEro8+44D8KRjZgz6+
MmNzOPlwOlhal1AGN2b2jRGjvjZ1yQ2UpKvITX+IwyOx8oHbXmtSi6JpqyrCfiPB
sbt9nNx/RF+si46qaecJRZ55xwnpha9qzIt98g/dzEjdBxbdqZtXEz0s3LVPhzg=
=kz0A
-----END PGP SIGNATURE-----

--DEueqSqTbz/jWVG1--
