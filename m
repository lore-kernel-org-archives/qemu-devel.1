Received: from eggs.gnu.org ([2001:4830:134:3::10]:33636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faen4-0008M4-Qw
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 06:13:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faen3-0008Jh-F2
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 06:13:38 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:53561)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1faen2-0008IT-Qu
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 06:13:37 -0400
Date: Wed, 4 Jul 2018 20:04:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180704100432.GA14307@umbus.fritz.box>
References: <cover.1530697258.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <cover.1530697258.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v3 0/7] Misc sm501 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Sebastian Bauer <mail@sebastianbauer.info>, Philippe Mathieu-Daude <f4bug@amsat.org>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 04, 2018 at 11:40:58AM +0200, BALATON Zoltan wrote:
> Version 3 with changes to 1/7 suggested by Philippe Mathieu-Daud=E9.
> Hopefully this haven't missed 3.0 yet.

It has, sorry.  Applied to ppc-for-3.1.

>=20
> BALATON Zoltan (3):
>   sm501: Implement i2c part for reading monitor EDID
>   sm501: Fix support for non-zero frame buffer start address
>   sm501: Set updated region dirty after 2D operation
>=20
> Sebastian Bauer (4):
>   sm501: Perform a full update after palette change
>   sm501: Use values from the pitch register for 2D operations
>   sm501: Implement negated destination raster operation mode
>   sm501: Log unimplemented raster operation modes
>=20
>  default-configs/ppc-softmmu.mak    |   1 +
>  default-configs/ppcemb-softmmu.mak |   1 +
>  default-configs/sh4-softmmu.mak    |   2 +
>  default-configs/sh4eb-softmmu.mak  |   2 +
>  hw/display/sm501.c                 | 230 +++++++++++++++++++++++++++++++=
++++--
>  5 files changed, 224 insertions(+), 12 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls8m6gACgkQbDjKyiDZ
s5IiXBAAkl56Po6CST6P7lsQbjBrt+xm+AwT7gaKzicvYBmBfXt5qojD2pgOtVuH
S+w8OWSENDxncNgyJhLemGkKvVDgPqlIxeZCaymdiuJcigmEuhlRmrt23MrSLO0/
oXHSfov9ni1Eef1SqTeUyaI1+v3znQCvsO8BFmGz4gkZiJjc6Y3S806PU4ZPeekL
BPhbOnSTx0x9Tg7hFwz4dKB4QTdtyF9jkfEAMiWP0BP7JkvFhgWeR76TIXePExU9
aWT73WDf3PiOtsJBEBJ5ZdRCKhmic3mxlx9VKb6Nxq+nTUctbuZEFp0Xs/HAnAkf
ehg4Cskh7G6ktiGtlzOJ0OFU58W/2n3ybGo32u+9Iv00jM5RetOrCzM+eabYp0NP
4JsvrmzMWzTZ7EWO+ODi1IcvrozTfs92N+VtwxIKTo6kAT0FNXatymWFnfasJ1Fo
qdzbCOgsvwd4sr5LEYAWVWtIQa1vr+HbijnFBTUtZ3+dluYvgAD84cbKHITXyPWj
ZWfIzNoggB24ktNsCn60D4x0sAiXNod7Vfo6OGTlh3X/WTVC4MQsXGRJXI2HVs5S
jiiw7IZTFYgewoqsUGqi9HBRHQ+lqborr91KYDjgZ0V9JK3lyUChZav9xWwjjz1M
PXXQuAKNPd/J5f/X2uFPKWC6Z9tws74ZXOGbKlbtdFwlRCjaKBU=
=wbyR
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
