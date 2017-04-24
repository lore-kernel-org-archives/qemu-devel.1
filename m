Received: from eggs.gnu.org ([2001:4830:134:3::10]:56911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2Vw9-0007oB-9z
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 00:49:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2Vw6-0007sH-9D
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 00:49:21 -0400
Date: Mon, 24 Apr 2017 14:26:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170424042626.GD16882@umbus.fritz.box>
References: <20170421020528.1087-1-oss@buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Content-Disposition: inline
In-Reply-To: <20170421020528.1087-1-oss@buserror.net>
Subject: Re: [Qemu-devel] [Qemu-ppc] [RESEND PATCH] MAINTAINERS: Remove
 myself from e500
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Scott Wood <oss@buserror.net>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 20, 2017 at 09:05:28PM -0500, Scott Wood wrote:
> I recently left Freescale/NXP, and even before that it'd been a few years
> since I was actively involved in KVM/QEMU work.
>=20
> Signed-off-by: Scott Wood <oss@buserror.net>
> ---
> Sorry for the resend -- fixed mailing list address.

Applied to my ppc-for-2.10 branch.

>=20
>  MAINTAINERS | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c60235eaf6..dcb9be1c6c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -645,7 +645,6 @@ F: hw/ppc/ppc440_bamboo.c
> =20
>  e500
>  M: Alexander Graf <agraf@suse.de>
> -M: Scott Wood <scottwood@freescale.com>
>  L: qemu-ppc@nongnu.org
>  S: Supported
>  F: hw/ppc/e500.[hc]
> @@ -656,7 +655,6 @@ F: pc-bios/u-boot.e500
> =20
>  mpc8544ds
>  M: Alexander Graf <agraf@suse.de>
> -M: Scott Wood <scottwood@freescale.com>
>  L: qemu-ppc@nongnu.org
>  S: Supported
>  F: hw/ppc/mpc8544ds.c
> @@ -933,7 +931,6 @@ F: include/hw/ppc/ppc4xx.h
> =20
>  ppce500
>  M: Alexander Graf <agraf@suse.de>
> -M: Scott Wood <scottwood@freescale.com>
>  L: qemu-ppc@nongnu.org
>  S: Supported
>  F: hw/ppc/e500*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY/X5yAAoJEGw4ysog2bOSAvMP/iIRFNuHPjKm9pDkWJ8aNru9
oBofGspdnZAsj47kGBRBIdWw08OBY5VuC2B3YgOLTXtzmJQd+fNflvtKzwSEHn+J
hRvZW/m9S+BNuI8VgQGRdDfG2SV10ibEIh1ZD8kP0IcGc3d71KgySW5hk4ra/KgW
L3dWcHzBIxWuPh8SVp2H7MlrqvZsVovfFFHoDsKQYpLR8yH2CaU1/VIkZoHH5BUc
C5WBej6w5/Zjpgq76Iaxixw0f2NZ0SlcFFvymvvawlORIMBqqeL3e2/331YD0gwS
HvcfnKD6faEeMrfeerqUS8H661sBPR5W4HiuoJM1wDrWXQ5ZGDiRvn++i1ScToO2
ZLdZ5E4WRNbGwZoBj8ChCmjaP+9ibOqtg35K4RC0XBkossPjYvz9gf5f91KqUC7T
qaMR2E7K8xyLvsWwOwvQykNoOrRMkhhccVpkfgPkafE/JC/n8pH0Vvu7R+tnaT1j
p4gpjsmqWUMhGTkzl7RTcxc1HKvX0TcVAKUIjBCK4HRB90AjgBAuKJp6dBsBPnsL
0VaIZ3OXjZCSkV2c/AClD7MinfDCjKInr8l4zH/W49sbOz7bmdX9HRvIuYmH5v2Q
TBFe+WJQ636GWhjbIzTDzDYfj8mqmeu/VUu6dl+fb2xgVNddSJvbBjAlu+3cu339
Soh2ITWaDFXz6+Xd+ZVj
=3eww
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
