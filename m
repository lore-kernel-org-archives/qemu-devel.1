Received: from eggs.gnu.org ([2001:4830:134:3::10]:41889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQymo-0003jj-RL
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:01:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQymj-0008R7-En
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:01:06 -0500
Date: Mon, 18 Dec 2017 17:00:52 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171218170052.GR16653@stefanha-x1.localdomain>
References: <20171215031547.31006-1-f4bug@amsat.org>
	<20171215031547.31006-19-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9uazBBczf8QSjDPd"
Content-Disposition: inline
In-Reply-To: <20171215031547.31006-19-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2 18/20] sdhci: add a
 check_capab_baseclock() qtest
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


--9uazBBczf8QSjDPd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 12:15:45AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/sdhci-test.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--9uazBBczf8QSjDPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaN/REAAoJEJykq7OBq3PIAQ4H/Rzdv3xXGy7hK+YmAD1nxMdn
Mf73YtgxYHNlQ0Rs9x9oPX8uYAQWC5GKTJSEgz+JYTUcF7P1Yy6BKV/cgbJti/h7
KUsJb0dcD6vvuyVW2v83tgokqP8qxCov/vB8ud+30eCMBJn49jWJXtd54UJsndLM
29yviAgzRVXJ5JB2XT4Y6NBzLlGzVEzlCgOwWqUZzWNvn8ob5MKcT8eJKo3AxHGG
YGTouwY343F+R2f7sL79qPmHzSql67vN87+VFioqFChV5+Qjmq/ZYNkJI4QydNlh
qqkPYdzAgfMqDIjLYaCzcURzrua1rkdlBiG3l3gT1DgfR6pNwDNiBoKRj0tWUuM=
=nHxE
-----END PGP SIGNATURE-----

--9uazBBczf8QSjDPd--
