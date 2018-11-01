Received: from eggs.gnu.org ([2001:4830:134:3::10]:39926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gIAf0-0001RU-P2
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gIAex-0006gJ-75
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:57:10 -0400
Date: Thu, 1 Nov 2018 10:56:56 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181101105656.GK24946@stefanha-x1.localdomain>
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
	<20181031002526.14262-3-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQ77YLfPrO/qF/pM"
Content-Disposition: inline
In-Reply-To: <20181031002526.14262-3-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [PATCH v3 02/13] arm: Add header to host common
 definition for nRF51 SOC peripherals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, "open list:NRF51" <qemu-arm@nongnu.org>


--LQ77YLfPrO/qF/pM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 30, 2018 at 08:25:16PM -0400, Steffen G=F6rtz wrote:
> Adds a header that provides definitions that are used
> across nRF51 peripherals
>=20
> Signed-off-by: Steffen G=F6rtz <contrib@steffen-goertz.de>
> ---
>  hw/arm/nrf51_soc.c           | 33 ++++++++++-----------------
>  include/hw/arm/nrf51.h       | 44 ++++++++++++++++++++++++++++++++++++
>  include/hw/char/nrf51_uart.h |  1 -
>  3 files changed, 56 insertions(+), 22 deletions(-)
>  create mode 100644 include/hw/arm/nrf51.h

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--LQ77YLfPrO/qF/pM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb2tv4AAoJEJykq7OBq3PIQt0H/0Vpr11KB0rKIKgXmYwtfCGT
fRDyaMKTSMrw5qbccZMLwWzjicOZ3GziG9NUVOUIbWWUsnlUcaJTSlnwyKMCaVbD
BPxk6kBNoDCfGPWJO7Chmss1Z9I98CBgaGf6rgE4Is9R4bbCUAlEhSWfAyJRuA4/
vGYPRacUeOftJgKNZmVkaUJVWKXqcUi9cMYW7SdGOrm3jzn70pfHB8iSVrGs7YtD
OzHpQp3EULnORtz+c5EeN6Cv4s6oqPCTBfnD/oKWL5zNTP0C8j3wiWTAl9NXf6DY
4TFhYc670SMRUuimGohMCBsh9QPkM1FsPXlTST+7FXbj3CmxMX2ytryC92dgZzE=
=bAyz
-----END PGP SIGNATURE-----

--LQ77YLfPrO/qF/pM--
