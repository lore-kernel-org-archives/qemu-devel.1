Received: from eggs.gnu.org ([2001:4830:134:3::10]:35076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gIC8g-0002UQ-I7
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gIC43-0005pc-Ko
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:27:10 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gIC43-0005oo-BM
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:27:07 -0400
Received: by mail-wm1-x342.google.com with SMTP id v24-v6so1239167wmh.3
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 05:27:07 -0700 (PDT)
Date: Thu, 1 Nov 2018 12:27:04 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181101122704.GP24946@stefanha-x1.localdomain>
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
	<20181031002526.14262-8-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FbmEh7Ek6NM6xKh/"
Content-Disposition: inline
In-Reply-To: <20181031002526.14262-8-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [PATCH v3 07/13] tests: Add bbc:microbit / nRF51
 test suite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>


--FbmEh7Ek6NM6xKh/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 30, 2018 at 08:25:21PM -0400, Steffen G=F6rtz wrote:
> The microbit-test includes tests for the nRF51 NVMC
> peripheral and will host future nRF51 peripheral tests
> and board-level bbc:microbit tests.
>=20
> Signed-off-by: Steffen G=F6rtz <contrib@steffen-goertz.de>
> ---
>  tests/Makefile.include |   2 +
>  tests/microbit-test.c  | 117 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 119 insertions(+)
>  create mode 100644 tests/microbit-test.c

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--FbmEh7Ek6NM6xKh/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb2vEYAAoJEJykq7OBq3PIXUoH/ivPop1IciVA7oxh9Oy04VAM
gak6YsKML5BxejH+WXrNREmrTlAgnmfC20K1vWoTSobO5DmxzgImUR4VIH+XF7ct
fp5Vc+rLIwitUSnx5NaEbPOslwqBouZffRl/hEbeeTXUVHHMWT1/2PL6ZsPabpkw
vBU8xPKZ/7mjoE9jIQ9sXqUyeO57UGygjqZY0b2zgufcraLg2ajVqBndORfhn5RE
Qjg0J/CYK3hklN9ZLJr0Obes7asl5/NSy1dQBDBXcO9Q+NN0ZoTP3WAPKkT5nTrT
8fFhCdUdcTIrJh6IdAts2al8SOhynNZCsEZUd1KufD7YEC37Au6o6OZyZHb9PgE=
=IKY1
-----END PGP SIGNATURE-----

--FbmEh7Ek6NM6xKh/--
