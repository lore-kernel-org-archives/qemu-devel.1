Received: from eggs.gnu.org ([2001:4830:134:3::10]:33315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekRJf-0002io-Rq
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 04:19:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekRJd-0004as-70
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 04:19:27 -0500
Date: Sat, 10 Feb 2018 18:34:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180210073439.GO11634@umbus.fritz.box>
References: <20180209075503.16996-1-aik@ozlabs.ru>
	<20180209075503.16996-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rQ7Ovc9/RBrrr0/1"
Content-Disposition: inline
In-Reply-To: <20180209075503.16996-2-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v7 1/4] linux-headers: update to
 f1517df8701c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>


--rQ7Ovc9/RBrrr0/1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 06:55:00PM +1100, Alexey Kardashevskiy wrote:
> Update headers against f1517df8701c.
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Df1517df8701c
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Might be worth mentioning that a32295c612c57 is the specific kernel
commit you want to include here, but in any case

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rQ7Ovc9/RBrrr0/1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlp+oIwACgkQbDjKyiDZ
s5JuHRAAnr7I88EPkczBWyAWob7QP+y4LCpKgJFF9vE78rDN4x2dOtTlhcSvQZIt
4/nmOnYJXrnVYr6MmIbWc1z3kh4CDaerzy4TqkCqy/GVSNtoiGqxxFUrp22tArOo
ecRHi43lYUy3NPnp1CuMPnam6BtBCzM9wJRpe5T2dhZs9TTLHKpCQ8a06k5UaVCk
yFWGZ+3cYQpVPpXI+hmVk1KlKA6cys5b1HaV60INKJGV/42vBE3IXz3//5+XKgJl
WGNk6EVKsoPdYd3f9MtkOEeijDc+aXONrKa+q7EZfdGYzzk8KXDqFqvSFeIgR4Br
iVnQOw2A4WTVOnjNyvXZl9j0qbTj7aXrsHI82OwhaMqDUPvHRXSvQhoKPkoB6wKm
03iIRFZcCvsQlQieaBBTZSZ8nKgwZZ1Hs08nf0v1oTpwh62NN1uDEORHHZES6lcL
CxCXf4lnjKqq82wlIRU8G8W+9t77gvRwDVZLJa563uIgOpKifiYK0H6UM1kmPaY3
KLQglDW6o3hzPnFSvcQmo63Z7pZfFAnfs8WM84MBUslYudxsYUORjsajuxJOPrp/
u+VtcXwEaVHroyHivEw4F79IpXSozw0dl5VJe4ApEIC7MkGw/25HXimmKtfSvQBI
4by3GlWHAS6fHvfLtUsCIxNcpmsXOyPTRWLQmhRC5OOcgCfObQ0=
=JHf+
-----END PGP SIGNATURE-----

--rQ7Ovc9/RBrrr0/1--
