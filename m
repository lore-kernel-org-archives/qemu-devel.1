Received: from eggs.gnu.org ([2001:4830:134:3::10]:34837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gIC9E-0002QI-E8
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:32:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gIC2v-0004vG-Aj
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:26:00 -0400
Date: Thu, 1 Nov 2018 12:25:53 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181101122553.GO24946@stefanha-x1.localdomain>
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
	<20181031002526.14262-7-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GPOl6LAGMgeiWDic"
Content-Disposition: inline
In-Reply-To: <20181031002526.14262-7-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [PATCH v3 06/13] arm: Instantiate NRF51 special
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
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, "open list:NRF51" <qemu-arm@nongnu.org>


--GPOl6LAGMgeiWDic
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 30, 2018 at 08:25:20PM -0400, Steffen G=F6rtz wrote:
> Instantiates UICR, FICR and NVMC in nRF51 SOC.
>=20
> Signed-off-by: Steffen G=F6rtz <contrib@steffen-goertz.de>
> ---
>  hw/arm/nrf51_soc.c         | 37 ++++++++++++++++++++++++++++++++++---
>  include/hw/arm/nrf51_soc.h |  2 ++
>  2 files changed, 36 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--GPOl6LAGMgeiWDic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb2vDRAAoJEJykq7OBq3PI8DwH/jLR2AGFJpwq/k31r4a97TTN
ephxWoWEm/ONkAsTBcW2tfvVONSwO7vQtZU5d3kG7y/oU2v7asPkJSokZ8rkXlC7
7tEDHJ1TOCrigzvFMM5NsFwp5vHaPw3XEnygx0xWIg93DpHroB+MKAVb+X4ws42z
7pKdMm5LVCe6DRbZe99x2u3NIe0Y4Qs6o/HGZog3GCs0BtqkOgIUSrQmmGNizFDm
pAeCmj7hY4T21L+ToSs79KxStkGHmtGKkYclDnTFp7aSgpymqlphQL8ilbYF8CGr
RKeG4d/NjPrY/fZp2KjyVPzcOUzNeccPclV28MZE4puJQ8LloGUhzffm6wvM4VM=
=dpsh
-----END PGP SIGNATURE-----

--GPOl6LAGMgeiWDic--
