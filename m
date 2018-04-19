Received: from eggs.gnu.org ([2001:4830:134:3::10]:34759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f945e-0006Gg-QD
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 03:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f945d-0001HM-SK
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 03:34:46 -0400
Date: Thu, 19 Apr 2018 17:34:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180419073438.GK2317@umbus.fritz.box>
References: <20180419064735.29928-1-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3MHXEHrrXKLGx71o"
Content-Disposition: inline
In-Reply-To: <20180419064735.29928-1-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v4] spapr: Support ibm,
 dynamic-memory-v2 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, nfont@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, imammedo@redhat.com


--3MHXEHrrXKLGx71o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 12:17:35PM +0530, Bharata B Rao wrote:
> The new property ibm,dynamic-memory-v2 allows memory to be represented
> in a more compact manner in device tree.
>=20
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>

Applied to ppc-for-2.13.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3MHXEHrrXKLGx71o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrYRokACgkQbDjKyiDZ
s5KQvA//ZOwByJfOsEZXT62iZO6xh+dJdxUZMH99xxjd8WPEDJZRoRi2HVEN10CM
6Ys4PYo+dSXM8LEDUWjK7b6S6mVZkrUmbMUPcQgLpixQiMRH8snCX1wVpGRwuh5j
hx4ZZ7Y92YqbpM3CaulxW8w6MG1VFb6jSJwjrLf3ObQFHSTS+yp+QmDdTSQNt3aG
igLGKfGTTokzJ6sRbj9HBxNn0WaLjFvumBuYYtO0iNNEd7pt0LIyYX/TO8yV3uG2
g//5qYfzkHmI8QFDURjN2rSE1YP07QjrytbrCiwrmmQDv7gLApyzKqh9HkY67iVg
xodFTmNisi+3klsXH3qBtmk5quYt5bbp2zQxXa5zmNnfPuldT41KLPEs7HsVgRf2
uM5swcZxxdvvnBsvk35z/S2zmwLRIQVgFF9nXGuEvHY71WTGc6RWGE3IcsMKVnoH
heWA1Re6bhASEZ/GHWnVJoNRWOcrm1/3QaCcpl9hBv9fLzE9OTjPrsI2uDycXDQG
ScZeHUVlR1989QKblyouNf7oXzxQXq9kYcCiAsKT07lQSz0KUlHUkuiCA/h/QIGx
01pj0eyKGF3hrvHqzKsb7C1QF2Y14me1T4ZzzD03naH2TT77rUHk9/6oTLJKgtBU
pTk/ko+3MQckbs0HVKdLPtvvBHDwHMm+eIUAjQJPakxGMPhXUdo=
=B/pF
-----END PGP SIGNATURE-----

--3MHXEHrrXKLGx71o--
