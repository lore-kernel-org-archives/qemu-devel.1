Received: from eggs.gnu.org ([2001:4830:134:3::10]:50875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eI1aS-0004VC-Sd
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 19:11:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eI1aR-0005GI-On
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 19:11:20 -0500
Date: Fri, 24 Nov 2017 11:09:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171124000918.GF22454@umbus.fritz.box>
References: <20171123170524.3865-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/Zw+/jwnNHcBRYYu"
Content-Disposition: inline
In-Reply-To: <20171123170524.3865-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] pcc: define the Power-saving mode Exit
 Cause Enable bits in PowerPCCPUClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--/Zw+/jwnNHcBRYYu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2017 at 06:05:24PM +0100, C=E9dric Le Goater wrote:
> and use the value to define precisely the default value of the LPCR in
> the helper routine cpu_ppc_set_papr()
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-2.12.

Sorry, I forgot if we needed this for 2.11 - if so, I can move it
over.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/Zw+/jwnNHcBRYYu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloXYywACgkQbDjKyiDZ
s5Ji2hAApA7C6cZX7EvBRMaGlPFNxE2dH34EknEtx6s1bHYgiZa0KUzAzi5ZWinX
AQVXAnAPorbJlz1SIHxiuF4aPp6Fs316Lj2VWe1drZAG9xzWa327ul8v6DRYfTda
Hby6Xtw6iQ+GESJzSyw1yipUJR8MbCf66020mi4Z/XKyQqsseUsyQ4yKiDDCjRBA
5Rfvzc//chpuBwTpyE3gn8HKOyAkvNIM9lWuubkQZAarGx3xDzpv6dogVKE4R04Z
W+J2cW8zaFMgUf74r92VwIcck8GdwF54hQ8tUgidfAra8csoX4drNB4pgCXOjLh8
3zEZ8kbsuZz+8i/Edzul051O1eXGO1wbPibbnwzNxeb/k/4+9AQ+UpMUSa0o72TW
g2vBO9reTE156KiH9h60xEMjU/L6pcztjALBZofNbOTGBObnhpFPtw+S5eVPvjXo
4dSbC1Cg+1D25iLTJN2RwO+/X/JF8aqFJ9YNO8XXFHgxhPzjOHnFsjFSxhTWo8NP
mD+jRBKQk1xS9ODoP4rTj3dKyoXgPijSfy89QjzqttkGBp4o16n0YD3hW17vsnQl
M35wGkUpRCjvqzIR2JPCW11tgaNFFrv+bMyIFCXa21YvvU+DR8oC7XLmltDx7705
A20OhPDXQGBPD+erka5k9ZTZufzQ8oHscZ4OOc9rPgvcCG4H+mg=
=29FP
-----END PGP SIGNATURE-----

--/Zw+/jwnNHcBRYYu--
