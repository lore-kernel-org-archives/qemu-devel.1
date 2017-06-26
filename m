Received: from eggs.gnu.org ([2001:4830:134:3::10]:49836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dPVQ6-0004ni-4I
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 10:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dPVQ3-0003X1-3g
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 10:55:18 -0400
Date: Mon, 26 Jun 2017 15:55:10 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170626145510.GF29664@stefanha-x1.localdomain>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-6-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yRA+Bmk8aPhU85Qt"
Content-Disposition: inline
In-Reply-To: <20170623124700.1389-6-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 5/8] block: add
 BlockDevOptionsThrottle to QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>


--yRA+Bmk8aPhU85Qt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2017 at 03:46:57PM +0300, Manos Pitsidianakis wrote:
> This is needed to configure throttle filter driver nodes with QAPI.
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  qapi/block-core.json | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--yRA+Bmk8aPhU85Qt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZUSBOAAoJEJykq7OBq3PITswH/0MSbHZbl6EQv+Gg9URncKxI
Dg/OGQtgAzKOfPDT6MBZbcAaboExHv/H7rfdqWCNrikeBrUdbbIUHW6eEo9lgBgW
AMSwQB91T48cg362XnT99Tn5aK4Gk0Ltw4C2OvVxGK92L6wwb8QybuTwpngFXuM7
923cxlrPMINgIHqzLffJri+Y93YnrUTM0alQ7yFXrMA3QYmzJ7usJVvMtxAIwgkm
bsYcMX4K4jEsRbl/GuzdWXW7mr0W1oGoGHjf0bPYss76O+zqY91pCfbVZI2+IUVc
WR4Wg/57k7J+cnUTjIa2YJr30PsvDYuAYeTKA0O29Y51l8Vey8FiTtRjyV+atRI=
=jpxy
-----END PGP SIGNATURE-----

--yRA+Bmk8aPhU85Qt--
