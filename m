Received: from eggs.gnu.org ([209.51.188.92]:60289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hBeas-0006hX-4M
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hBeaq-0001xU-VO
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:02:13 -0400
Date: Wed, 3 Apr 2019 13:01:59 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190403120159.GB32425@stefanha-x1.localdomain>
References: <20190401024406.10819-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
In-Reply-To: <20190401024406.10819-1-jbi.octave@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] util/readline: errors clean-ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jules Irenge <jbi.octave@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 03:44:04AM +0100, Jules Irenge wrote:
> This v2 version combines two fix of errors into one  and replace tab
> indent by four spaces
>=20
> Jules Irenge (2):
>   util/readline: add a space to fix errors by checkpatch tool
>   util: readline: replace tab indent by four spaces to fix checkpatch
>     errors
>=20
>  util/readline.c | 132 ++++++++++++++++++++++++------------------------
>  1 file changed, 66 insertions(+), 66 deletions(-)

This file is unmaintained, I'll take this patch through my tree.

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcpKC3AAoJEJykq7OBq3PIo2cIALmRVg5tmU0DZSQZMsihVOSn
Imxgo03Z6rOZYtqbugKvV0HgOupBs4KSQULoj9z+leMcqv5GqdGAXr2iuiuIA1GM
JUO8WzD1l4Xi3SlYTLVkxLphKKy68h2VSz03lY0Xp+NX59UUD7s9zLLLs+O/9S7e
n4CAIHKp5uttlPFRU2dVFx3JVG2kxdeR79Xf5KsugJ+I2TCt6Nf8jLhjhF2K2oUJ
weLOeDwfq/Ay55IU2EEswgvIPoItOuaXC2E/GRsQTwcRaKZOEtvr6y7vV2ISbAoT
5tXywxrYa4fQxVp1t//+jXoCoo4M39Equ1DzIsj/3sK/VQHJukarGaGpn+BBen4=
=nG44
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
