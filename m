Received: from eggs.gnu.org ([2001:4830:134:3::10]:41580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQymD-0003C5-CG
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:00:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQymC-0007Aq-LG
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:00:29 -0500
Date: Mon, 18 Dec 2017 17:00:18 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171218170018.GQ16653@stefanha-x1.localdomain>
References: <20171215031547.31006-1-f4bug@amsat.org>
	<20171215031547.31006-18-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eBTWNsZZiigckDWV"
Content-Disposition: inline
In-Reply-To: <20171215031547.31006-18-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2 17/20] sdhci: add check_capab_readonly()
 qtest
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


--eBTWNsZZiigckDWV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 12:15:44AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/sdhci-test.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--eBTWNsZZiigckDWV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaN/QhAAoJEJykq7OBq3PIp9UH/3fGuMOEB5akGkizycl8k6dx
bG+4Wz6cCXvz5QeYagKqGYr7IXbMFrs/8CSSU65lrwkLjRPUcIHU6BbVRO5tP/1A
DVysv918MyNqckwEnajnxMI5s+Af+hPke41TMEUSv80D72c7HcO8fkIMLt7x+wa6
6i29YuotSffsd5OMqx91fpVXRTqbsWmtcp+YttI4/3v0VJ7GFaL3+a4N5QOQoLFE
GulOo5P6gVWSL2CTxqGU9CadGrVRxBNcvpEs2sX6r4/oVricf5FI7ZIbdSg2O1Br
y3un0aEh7jcOCuvQqozJ2DSRNyu9yUaDbbmJVdnqQ7V4EAdeDYc0PkMv0/EapwM=
=91+5
-----END PGP SIGNATURE-----

--eBTWNsZZiigckDWV--
