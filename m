Received: from eggs.gnu.org ([2001:4830:134:3::10]:39542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fZ9F2-0004LU-TC
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fZ9Ey-0001uN-UK
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:20:16 -0400
Date: Sat, 30 Jun 2018 16:14:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180630061443.GP3422@umbus.fritz.box>
References: <20180618215601.8974-1-mail@sebastianbauer.info>
	<20180618235557.GB25461@umbus.fritz.box>
	<73dd5b26b622e6c59776976aa2c7a3a0@sebastianbauer.info>
	<20180619043631.GC11674@umbus.fritz.box>
	<607559ef0fd95f557b5001a5db29883f@sebastianbauer.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1LW0Rr0Uq98qh6Rv"
Content-Disposition: inline
In-Reply-To: <607559ef0fd95f557b5001a5db29883f@sebastianbauer.info>
Subject: Re: [Qemu-devel] [PATCH] ppc: Include vga cirrus card into the
 compiling process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sebastian Bauer <mail@sebastianbauer.info>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, balaton@eik.bme.hu, qemu-ppc@nongnu.org


--1LW0Rr0Uq98qh6Rv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 29, 2018 at 08:06:10PM +0200, Sebastian Bauer wrote:
> Hi,
>=20
> Am 2018-06-19 06:36, schrieb David Gibson:
> > Ok.  However, your patch doesn't apply against the ppc-for-3.0 tree.
> > It looks like you've made it against a tree including some of BALATON
> > Zoltan's proposed but not yet merged patches.
> >=20
> > Please make sure your patches are against the current ppc-for-3.0 tree
> > before posting.
>=20
> The patch seems to apply now to ppc-for-3.0 without any problem as Zoltan=
's
> changes have been integrated. Let me know if I shall resend the patch or =
if
> you can use the original one. Thanks.

Resend please.  Assuming it would need a respin, I didn't keep it
around.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1LW0Rr0Uq98qh6Rv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls3H9EACgkQbDjKyiDZ
s5LJ8g//YH1qK29hwnezBWRFMRYFm0jE9tj7C35et74NDJJZyr0zTpbDfPQP4Xcy
uvhD4Dm/nM6uOR2ynsNTYXTvS759OR2Bmc/iyfrpZvxf0aUdXVY5si4lhbhQJuZV
8almie9J6LNfidTvkeZPAlJWU3CVd0Yxa7Oh1PQYStYDdbawqjtEPPuqvjYvyLWV
6iP+ii1M3YF6qMSj+LSEgMuLWzSnt5uBBMWLZWg0Kf56/cT+5cqIQKfOsPCxWpYh
Na9o8Zb7FYIpKsybritHekI3XUkY855v1qPI5Lfl5jW5wqgdmHRjmVMWEXVngRNL
vnC0Rx7OcgLf33VX/xWkR9u4EXJh3HhvOzs7c/7ub+8hsBoaZlyGuXLm2RDZhRn4
mL3Oxr1UgLKstIoO+ppEdaKtbtbD2kNDzT0eotHI48dArj5/cFEL6MvxVR0/Zbmi
/C//P2LzlIpKcKPn143Hbz4uKZ6h4NDtUBbQnWh5PoJ4iSkMMFnE3edQcqzxYnD3
sW4QjSA96hhxtR82majzEncdClI4VnAGkhftsUYfpPVT6O87G1djhZncfwWCU+PM
BH+xOk+sK9v6wVgT6D7RkklgBKZJ+4cTOT9NGiXeg6x8eDUaf641KpaN7vkcRK10
svgyL04xV1WXpzuelfzCrn9cfJfBvNKk0ijUqCJ0Vse1SzJAOOA=
=Hoza
-----END PGP SIGNATURE-----

--1LW0Rr0Uq98qh6Rv--
