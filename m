Received: from eggs.gnu.org ([208.118.235.92]:47874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQxKb-0008FE-FL
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQxKR-000202-Kx
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:27:53 -0500
Date: Mon, 18 Dec 2017 15:27:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171218152734.GP16653@stefanha-x1.localdomain>
References: <20171215031547.31006-1-f4bug@amsat.org>
	<20171215031547.31006-17-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jXoUnAu9pZeaHebo"
Content-Disposition: inline
In-Reply-To: <20171215031547.31006-17-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2 16/20] sdhci: add qtest to check the SD
 Spec version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Andrzej Zaborowski <balrogg@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>


--jXoUnAu9pZeaHebo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 12:15:43AM -0300, Philippe Mathieu-Daud=E9 wrote:
> with check_specs_version()
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/sdhci-test.c     | 74 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  tests/Makefile.include |  2 ++
>  2 files changed, 76 insertions(+)
>  create mode 100644 tests/sdhci-test.c

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jXoUnAu9pZeaHebo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaN95mAAoJEJykq7OBq3PI7uwH/02/UvWBSHJCYy2Ivsgj5nVS
7Z/Cr0YHl7Z7PgMpwX1IGnYaLf3/R9GDBFQh1wqZ88k4yCkEm/UG2bu5S2yMiM/1
AnItQYhTjHy4kCygQONq2fm3gRrHvSarYW3jv8D8od93zOejDawCPDlizcHbn90i
rMwtxopxetdaP3wxS1Zh8kJqvCWFBi+iTKrmWzkoP0MMpcGy389GFuwnGUJ5YADk
pvIYdv+AHBa4wo8lJF9qTVR2gl/OmETnDPnGY7SKJ84+V+kywX6IRw3GQXKNEcKq
8xQsiDcB9W1TTbKH3Gts6nU50egw0o7FEg8S+EUyaiEfbdA9hVZfgviKiSFsnpY=
=ZStG
-----END PGP SIGNATURE-----

--jXoUnAu9pZeaHebo--
