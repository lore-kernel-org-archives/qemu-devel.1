Received: from eggs.gnu.org ([2001:4830:134:3::10]:39112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gICHy-0004S1-7j
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gICHj-00081j-EY
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:41:23 -0400
Date: Thu, 1 Nov 2018 12:41:12 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181101124112.GR24946@stefanha-x1.localdomain>
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
	<20181031002526.14262-10-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eyYj78xbwv+yMvU1"
Content-Disposition: inline
In-Reply-To: <20181031002526.14262-10-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [PATCH v3 09/13] arm: Instantiate NRF51 general
 purpose I/O
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


--eyYj78xbwv+yMvU1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 30, 2018 at 08:25:23PM -0400, Steffen G=F6rtz wrote:
> Instantiates GPIO peripheral model
>=20
> Signed-off-by: Steffen G=F6rtz <contrib@steffen-goertz.de>
> ---
>  hw/arm/nrf51_soc.c         | 16 ++++++++++++++++
>  include/hw/arm/nrf51_soc.h |  2 ++
>  2 files changed, 18 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--eyYj78xbwv+yMvU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb2vRoAAoJEJykq7OBq3PIXesH/3sra0UaIff56ob2DhPbY+Ls
lEDkXfxMTwdw4QQwhSaTW6yH3h2KEDx5qBp7LLp/6aZlsSQ+obBqeBqJ5vhTzM97
9OG21ZoYPBF0JQML82jc8NHPJu7LOQRG4CMoH2Uxt9fLalmUsdGbqhUf2WF3TVNF
SIoFeevXCBuL92KgPKqL1qFRtYJc7Gw7MggwEiYKHOPkAqbtZSDiHAwn4H0vyvwV
lRyH2e46HU04DFcQFrkti7AaG4GvBXNXXnuV0/obLiK44nPIkvs6DWfoUp1gpyR7
wBazZAFKemU9CKuxem3z7CMWYf+wxCTWuj6BbZN+bx1oRXKVzBhPHA1VybTOKWQ=
=XODn
-----END PGP SIGNATURE-----

--eyYj78xbwv+yMvU1--
