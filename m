Received: from eggs.gnu.org ([2001:4830:134:3::10]:58036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fZxwM-0004yk-4i
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fZxwH-0004wS-73
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:28:22 -0400
Date: Mon, 2 Jul 2018 13:28:14 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180702122814.GD2155@stefanha-x1.localdomain>
References: <20180627143815.1829-1-joel@jms.id.au>
	<20180627143815.1829-4-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
Content-Disposition: inline
In-Reply-To: <20180627143815.1829-4-joel@jms.id.au>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] MAINTAINERS: Add NRF51 entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Jim Mussared <jim.mussared@gmail.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 28, 2018 at 12:08:15AM +0930, Joel Stanley wrote:
> This contains the NRF51, and the machine that uses it, the BBC
> micro:bit.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8c626f6a079e..fef3d71dbef7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -656,6 +656,14 @@ F: include/hw/*/*aspeed*
>  F: hw/net/ftgmac100.c
>  F: include/hw/net/ftgmac100.h
> =20
> +NRF51
> +M: Joel Stanley <joel@jms.id.au>
> +L: qemu-arm@nognu.org

s/nognu/nongnu/

Aside from that:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbOhpeAAoJEJykq7OBq3PI724H/35xM0f3PMkg50f8sE2POCgY
R4rl7eZW858ODZCEazHRuGVca4Oa+Y7fryvWbw/SHCvxyxH5feeal+KSLlcLx+0i
J4u/OyOCq3l8xcGbsmp15Gec84j/rXpPSrh7f+npD2c2+vdw8VxKux8QvLYLzGIp
SLu6ZKIdA34MUg2DZCAof92lW7cGHXLV4jH01+4rPZIWmcBLNhkqznSjdPvyZDwg
O0V47GHgZHuSJlWICmwIo0KTZQ5pqJU3K+UtognzlCmZ464vYq+pPei9J1uLqoAa
zF8RZAn/kEMw5wMUj42zPKf5XCyc2EuuTZWZJX0buD7yfU1GeHdV60iDhAo/xY8=
=tKSU
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--
