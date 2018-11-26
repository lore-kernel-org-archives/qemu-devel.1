Received: from eggs.gnu.org ([2001:4830:134:3::10]:37322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gR4u5-0005fU-3z
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 19:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gR4u4-0001qr-7m
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 19:37:33 -0500
Date: Mon, 26 Nov 2018 11:15:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181126001540.GF2251@umbus.fritz.box>
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-9-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V4b9U9vrdWczvw78"
Content-Disposition: inline
In-Reply-To: <20181125205000.10324-9-philmd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.1 08/25] MAINTAINERS: Add a missing
 entry for the Old World machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org


--V4b9U9vrdWczvw78
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 25, 2018 at 09:49:43PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 81a22b2ccf..aa51ae813b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -936,6 +936,7 @@ F: hw/ppc/mac_oldworld.c
>  F: hw/pci-host/grackle.c
>  F: hw/misc/macio/
>  F: hw/intc/heathrow_pic.c
> +F: include/hw/intc/heathrow_pic.h
> =20
>  PReP
>  M: Herv=E9 Poussineau <hpoussin@reactos.org>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--V4b9U9vrdWczvw78
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv7OycACgkQbDjKyiDZ
s5KrZA//bhZPfoOo2Sy5yDgCtHH6Bqo0cSQgEYeFIb2GirVFwzsQ6I8UaDAW5dGV
h6lk1Qe7n4PtPx6ZrwCpVEQStAdsWivGit0y49iMhQyz0ivAd9ySI/RZ82YOrKj1
Z6BcAzDjx+PD85q19zYjSf2JqDv06hWk3DsHkAd0H0M6A4wiuI0zUwthcBYy7Cs4
Vu+YBu6BcEqW3OuvYkYXxyFaBDo6x9Pp29kZzfnjUtAmE5Pb6xlyzr4dFJ+/mWQn
R5zclKOSM7g0boT/bgW/NT8HC5KJ+9GsDRQp5pLuVGLpldmNgG0MY7uVAt25RTJ/
JjF0TECmqwEBT5I3BFF6b6JhiN/FtvleBvy3p48hJxlY22ruFueUS1XnthD+dNVS
OTSakLzeRgYaewMZeoV9Zo/S0eAliU/bh2rWdsVEgQIwv0KfbadR+RA6JQjWWxIR
vX3lDqpiGqxX9eiNUJ2RjwoEJnxAZQFcV6d7o1VcTGAefQOoSZDMfezEpDxAKn/f
KUXhQNoODZGNshkTpK5e9K/+DFpXmJVjcBalWCrxxqDpnmbAhJnuIhF43Ju1Xdeo
fu0XJqv0Dex0vv5LcJGWU9M9zZHJsJC9XSer7g+WubIc1d6loTXjt2Z3XHqTtcSh
sPfo2fwB8JKx7SHoAKbtDSEbhdWHQAmzb4+74pSS5wE1S22LNxI=
=yl+G
-----END PGP SIGNATURE-----

--V4b9U9vrdWczvw78--
