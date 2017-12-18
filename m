Received: from eggs.gnu.org ([2001:4830:134:3::10]:42323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQynQ-0004Gd-LD
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:01:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQynL-0001Vs-83
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:01:44 -0500
Date: Mon, 18 Dec 2017 17:01:32 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171218170132.GT16653@stefanha-x1.localdomain>
References: <20171215031547.31006-1-f4bug@amsat.org>
	<20171215031547.31006-21-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dBMBt2YGaTHbdllf"
Content-Disposition: inline
In-Reply-To: <20171215031547.31006-21-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2 20/20] sdhci: add a check_capab_v3()
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


--dBMBt2YGaTHbdllf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 12:15:47AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/sdhci-test.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--dBMBt2YGaTHbdllf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaN/RsAAoJEJykq7OBq3PITwoH/RFTx27aYr2R/ixEbtKur1cJ
DsZHrFkydQMX8AXqpEftOqkcnBAxhwi3ozm+4YvXzM7YczzSiudS6P8fRhGMjGLg
m3E/9KN3ztRqM2vdPKih/Xzso6HkH4VFq5+fL7FRQoss+R8g+bfLZsHJtk74I4mX
kdHhtGl1jBjoMVsiDmJpCQ59BEiQ9yXV9CFclYz2K7819uBoLCj9A2Si0DmTrvpW
BtS7VguxAYYM9qzGhTidwSPUszGHlKARnP54td3Viil+KKoFuqWcvMYF+MWoXzMr
orB4O0FDcB/t5A19tJMJQMOPcfjjrlonWh4GuFUUhMshC2XtRsK+mdRY//mTmlU=
=rn3n
-----END PGP SIGNATURE-----

--dBMBt2YGaTHbdllf--
