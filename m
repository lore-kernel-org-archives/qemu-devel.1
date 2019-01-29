Received: from eggs.gnu.org ([209.51.188.92]:37160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1goJZK-0006W2-Qx
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 21:56:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1goJZK-0008Hq-8s
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 21:56:10 -0500
Date: Tue, 29 Jan 2019 10:56:03 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190129025603.GC3264@stefanha-x1.localdomain>
References: <20190125155630.17430-1-sourav.jb1988@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Content-Disposition: inline
In-Reply-To: <20190125155630.17430-1-sourav.jb1988@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] hw/arm/nrf51_soc: set object owner in
 memory_region_init_ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kumar sourav <sourav.jb1988@gmail.com>
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org, joel@jms.id.au, qemu-devel@nongnu.org


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2019 at 09:26:30PM +0530, kumar sourav wrote:
> set object owner in memory_region_init_ram() instead
> of NULL.
>=20
> Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>
> ---
>  hw/arm/nrf51_soc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcT8DDAAoJEJykq7OBq3PIK+cH/0l8V9pfs307KCKinbjQ60dR
F+qmqIPxXg6RTOnCQ5E5b5gNtxEtzR2xVu4l/E9WAnkeVe+6hrtD+SlI3Okx6WtL
ARiOOF8mx+ouitE+abwha42U+a+8GkjJvfo59V8C7n/LjYFtcJtZh0o0X03/e7wj
8vGSVnbYbYgRklVc3BkQf8OQXzIHFSlZDbYE+dEAaYFarB3IdvCpPoAKeEyPGAE9
jpD3wXwq3dT6UErsvIxyzpsiaUa4+X8UuEotlwoNq2JLGPH10uDm9+OOIZK/44dE
rvPJJcX8UzqcvYwae7/rmkSvPdZsVuEWePWgobCPEk8MNIV0x4sVo6SWYTkR0fM=
=DADY
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
