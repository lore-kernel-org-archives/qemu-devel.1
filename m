Received: from eggs.gnu.org ([2001:4830:134:3::10]:36557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gNiTW-0008Ba-2a
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 13:04:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gNiTS-0001yu-Ue
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 13:04:14 -0500
Date: Fri, 16 Nov 2018 18:04:06 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181116180406.GA24933@stefanha-x1.localdomain>
References: <20181112214224.31560-1-contrib@steffen-goertz.de>
	<20181112214224.31560-7-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20181112214224.31560-7-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [PATCH v5 06/14] arm: Instantiate NRF51 special
 NVM's and NVMC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "open list:NRF51" <qemu-arm@nongnu.org>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 12, 2018 at 04:42:16PM -0500, Steffen G=F6rtz wrote:
> Instantiates UICR, FICR, FLASH and NVMC in nRF51 SOC.
>=20
> Signed-off-by: Steffen G=F6rtz <contrib@steffen-goertz.de>
> ---
>  hw/arm/nrf51_soc.c         | 43 +++++++++++++++++++++++++++-----------
>  include/hw/arm/nrf51_soc.h |  2 ++
>  2 files changed, 33 insertions(+), 12 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb7waWAAoJEJykq7OBq3PIPH8IAJEDeZgHnPZEGPGe4nzYT/e6
bCEAOOx5UaIZYWRgTi9oF0PnZ4gZQo55rEA/1wcJA6+UapoYJIcA03z3C1NvjsK/
EP4noubPa9Sr2Is3hy2AVfDndOLGUyKVNaG/1rBLRYajmYotc9IhO+5U8QGzPDAk
5JqdE6ZNkAv4oCWniOxPxdlTD68y3Jp3GT/Cu8vy83hDRz1N4OPmS7RcffYu9Hux
p/Vn+nPT1SWsm2a1g7bKiKHSVRRtUjehURr07CdvqxX8qwgdAQLV5+lqGrkd0nB9
WYd+5v8+FRNT9ppweQnVvOVP6bFWK5fUvSCvWALG4sr/fYsVE6XBWFr3sN/VDB8=
=LLjC
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
