Received: from eggs.gnu.org ([2001:4830:134:3::10]:46743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWBIo-0002ka-Gj
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 21:28:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWBIn-0002BO-M9
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 21:28:10 -0500
Date: Mon, 10 Dec 2018 12:27:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181210012755.GB4261@umbus.fritz.box>
References: <20181207160806.13569-1-mark.cave-ayland@ilande.co.uk>
	<20181207160806.13569-2-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <20181207160806.13569-2-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 1/3] MAINTAINERS: add myself as maintainer
 for Mac Old World and New World machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 07, 2018 at 04:08:04PM +0000, Mark Cave-Ayland wrote:
> I've unofficially been doing most of the work on the Mac machines for a w=
hile
> now, so update MAINTAINERS to reflect this. David is still happy to be li=
sted
> as a reviewer as per our discussion at KVM forum.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  MAINTAINERS | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 63effdc473..64bffaecca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -935,7 +935,8 @@ F: hw/ppc/mpc8544ds.c
>  F: hw/ppc/mpc8544_guts.c
> =20
>  New World
> -M: David Gibson <david@gibson.dropbear.id.au>
> +M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> +R: David Gibson <david@gibson.dropbear.id.au>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
>  F: hw/ppc/mac_newworld.c
> @@ -949,7 +950,8 @@ F: include/hw/misc/mos6522.h
>  F: include/hw/ppc/mac_dbdma.h
> =20
>  Old World
> -M: David Gibson <david@gibson.dropbear.id.au>
> +M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> +R: David Gibson <david@gibson.dropbear.id.au>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
>  F: hw/ppc/mac_oldworld.c

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwNwRsACgkQbDjKyiDZ
s5LsLg//ZkVhBeVxhOeyeO+XA+ecK6xq9j2ZEfK7pKw/laWBpyYkhehQooiW8IRv
vEHhLtj86roSxiWkx9g6d2HS+YeGM+xQSX7wKGKUe7/uWDgCbDyxU5RCkImCEmeP
qwlkaUn1GquTDyNo4PT9Tq4Tk0BvF6YK+MTlBEzAPl6rUmeDIh/L0s2M1ErxNxc6
Xcq7TzaH5rxjiKCBFw9snxx2H5BhRQKAKrBz1pB6H0DJi/r59UJLHBUOXaddftNu
pIb7o6ngQt3jTEOdAjtUk/RGpVBTtn8M7Is9xJWV14BuPE0Uow+BooYWr1OhwNPC
YljGFyGHHabikLAfcssIwv4G6kPyxD4QEB2BsBZ3NOVW6YX9uUS35c9tMhmYdKBI
IDNuLTfvh6gcL3nTimxAeMm761uLhQ9/eh1tl76jaP67NNcCPKGMW+vwvoXOONI4
S9oYCwXRMTwnWHv0imyPx69ttmCtxUoNoGlCqlWRKVQc+0IIRIL009/83jRUWSuY
RLkeEJXlBsi3nqGNxaQHGG3mR30xEl0B83a1imKQI6RJwz/DFItmaGjplMPjA6bU
X7wPW/Ih0Uy3x8Y3m1YXVhTPyAg9aY7mdUnJ0fqgCSI9gN//7NPSg0dSr7FaGyP9
+nzeoj3HC7WAhCC4upD8nXhhIWgXMtdjGr+EOuLmxJZzG6DdrBE=
=hGB/
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
