Received: from eggs.gnu.org ([2001:4830:134:3::10]:46837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7m89-0007lH-5D
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:07:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7m85-0003e6-6a
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:07:29 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d7m85-0003di-2d
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:07:25 -0400
Received: by mail-qk0-x242.google.com with SMTP id k74so10981071qke.2
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 10:07:25 -0700 (PDT)
Date: Mon, 8 May 2017 13:07:22 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170508170722.GI22428@stefanha-x1.localdomain>
References: <20170506110333.11000-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pe+tqlI1iYzVj1X/"
Content-Disposition: inline
In-Reply-To: <20170506110333.11000-1-aurelien@aurel32.net>
Subject: Re: [Qemu-devel] [PULL 0/1] tcg-mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>


--pe+tqlI1iYzVj1X/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 06, 2017 at 01:03:32PM +0200, Aurelien Jarno wrote:
> The following changes since commit 12a95f320a36ef66f724a49bb05e4fb553ac5d=
be:
>=20
>   Merge remote-tracking branch 'kwolf/tags/for-upstream' into staging (20=
17-05-04 13:44:32 +0100)
>=20
> are available in the git repository at:
>=20
>   git://git.aurel32.net/qemu.git tags/pull-tcg-mips-20170506
>=20
> for you to fetch changes up to 2f5a5f5774d95baacf86c03aa8a77a2d0390f2b2:
>=20
>   tcg/mips: fix field extraction opcode (2017-05-06 12:48:53 +0200)
>=20
> ----------------------------------------------------------------
> Fix MIPS R2 hosts support
>=20
> ----------------------------------------------------------------
>=20
> Aurelien Jarno (1):
>   tcg/mips: fix field extraction opcode
>=20
>  tcg/mips/tcg-target.inc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> --=20
> 2.11.0
>=20
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--pe+tqlI1iYzVj1X/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZEKXKAAoJEJykq7OBq3PI+ScIALqcCDo+r9DKEiwVPGQ3COUK
sOQaGVF9mliOzOnbKlrcZJr4mOgZwM7xuUVjeI9rRIMVMEqsHOb20htPmWJv0cox
4pLuT10Yg0zn32Famr4Ex63P/CgxZqnS0iBUgsD1vZaVYDMowfKgRxR6spVn4G36
PACzmhQjLdcnpLfKHi755ylEoWM+4Ehb7Mvv7/1MWY8Au4qKmHiRwhYempI3JSnM
V9CvV08qtZmw+B9Yecx0v7uOFtz2lf0pjsIPPDcyY/gRMxwYOLjO3yPNWnZTkD4A
vbqDz19dFW1e2Juig8HdgIa8kTcxoQ/apXrQzhiVOjhCA2jLmOjGv1paRR3TOCo=
=hztB
-----END PGP SIGNATURE-----

--pe+tqlI1iYzVj1X/--
