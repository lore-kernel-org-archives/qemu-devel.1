Received: from eggs.gnu.org ([2001:4830:134:3::10]:53246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db45D-0004Pg-M7
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db45C-0002tv-W7
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:09:31 -0400
Date: Fri, 28 Jul 2017 13:09:21 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170728120921.GE12364@stefanha-x1.localdomain>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-11-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PGNNI9BzQDUtgA2J"
Content-Disposition: inline
In-Reply-To: <20170728053610.15770-11-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 10/47] MAINTAINERS: add missing entry for
 virtio/blk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-trivial@nongnu.org, qemu-block@nongnu.org, qemu-devel@nongnu.org


--PGNNI9BzQDUtgA2J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 02:35:33AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4f9ce6e686..2958dd2479 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1067,6 +1067,7 @@ S: Supported
>  F: hw/block/virtio-blk.c
>  F: hw/block/dataplane/*
>  F: tests/virtio-blk-test.c
> +F: include/standard-headers/linux/virtio_blk.h

This file is imported from Linux mechanically using a script.  I'm still
happy to review changes to the file though.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PGNNI9BzQDUtgA2J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZeylxAAoJEJykq7OBq3PIeRkH+gOkt7z+ACzrQGdbA/Uzko6U
fOsiAHoBcVKMFdSR6iviuIu4H7546xehLSKaxoT1CAXSZPCfi5/L6LIy2go1V6G8
2lrG5/OMBc+Zs6XvM5VS6RTJgX9KJLBtZ1nnCjqrlG0vF5rYoBtK1TOJO3HM6Y2a
V3XM1mZDB1VOHww8sy1eGkwcZJ5TizOCWGOKbOAbe/3o2TRdKqdmQOS5ec6LzgGy
Z3tuNenQ/jQz1Qg02c8fdgNqNeUJBcv00m5FHOjtkWbm0FRaVBsuJDevKAK8+SIH
loWoYm0DX5Mon4stfHii2YuWVv62gCGaNGl6ykmJPUW3D5JXpnKPWgFwrkUpG7U=
=IV/z
-----END PGP SIGNATURE-----

--PGNNI9BzQDUtgA2J--
