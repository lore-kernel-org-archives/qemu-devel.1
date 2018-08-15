Received: from eggs.gnu.org ([2001:4830:134:3::10]:41252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fprhG-0001e2-I0
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 05:02:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fprhF-0007x8-IO
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 05:02:30 -0400
References: <20180814124254.5229-1-peter.maydell@linaro.org>
	<20180814124254.5229-2-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <b36091d5-fd70-86ed-ccc1-e4787cc9e27e@greensocs.com>
Date: Wed, 15 Aug 2018 11:02:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180814124254.5229-2-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LkgqzUjjsYqyMe2r1n6WQ7AdIHgVNbTc3"
Subject: Re: [Qemu-devel] [PATCH 01/10] target/arm: Correct typo in HAMAIR1
 regdef name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, edgari@xilinx.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LkgqzUjjsYqyMe2r1n6WQ7AdIHgVNbTc3
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org, edgari@xilinx.com
Message-ID: <b36091d5-fd70-86ed-ccc1-e4787cc9e27e@greensocs.com>
Subject: Re: [PATCH 01/10] target/arm: Correct typo in HAMAIR1 regdef name
References: <20180814124254.5229-1-peter.maydell@linaro.org>
 <20180814124254.5229-2-peter.maydell@linaro.org>
In-Reply-To: <20180814124254.5229-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 8/14/18 2:42 PM, Peter Maydell wrote:
> We implement the HAMAIR1 register as RAZ/WI; we had a typo in the
> regdef, though, and were incorrectly naming it HMAIR1 (which is
> a different register which we also implement as RAZ/WI).
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-By: Luc Michel <luc.michel@greensocs.com>


--LkgqzUjjsYqyMe2r1n6WQ7AdIHgVNbTc3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAltz7BQACgkQd8knW3Qn
Tr69ig//b8y2CK1p3Zu1i/pLFnWiP2mn0fzvOAIJXM1GNzZf4bCsmVXDymZZd1pa
G6hmu0M7yVHScJZkQ0YKWliyNl+eW5TbDvtmLgYiE5sDlLMNokayFnf3uD/vAoIq
T31YtEPInrK3nzRubISqtppe9X5ARTm18cKpvrrGdZ8OhUzFl9Iv8LhXQleg65Oi
LtiXKfHmjR1sXUytcfDiSa/YXWRCNSXSJ9TkmVeY7r3o6iotQBXjHV6NqRBwxcuT
HUtnaoKa5B4wVUGnpmETbPbtrNZ3iBT7rEj7xL3jUsXIjAsvrLPMXmKc/XK7m5pp
5TbIibOLY/AMWFjtm+1nMfXyB7JRbG6l6q577uAxi+joto6cVSStTxmmQUCq+ErE
MA2sKYBQy/1y5cgNPZ3vdpW0/nIL6az4Ld2rOtM3ecBxfBBad7AxHvIOFAPhAE5U
wUi/S6ryUYgZ5Y8MWD6Ol/UNw6YPAQ9849qPES9eGVA5Mvs5gfpNKPpCIaikKQb3
SOzxet7Rkb3xJ8SULnjTJ+W+A1s2HDToICLAe2ZonTrMSSG4KBAHRX6Ey97YA1Km
ALkW/T3uVl5GfZAwiwHLOko9YhT31ykWtxYML58JfH16KIrwfPKQUXi1mY635Fvo
l6pu1PuOxRozldadNn8HNmuHrH6fJu1E0hfXFbEUvXgs321UJHA=
=N916
-----END PGP SIGNATURE-----

--LkgqzUjjsYqyMe2r1n6WQ7AdIHgVNbTc3--
