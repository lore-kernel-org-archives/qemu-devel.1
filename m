Received: from eggs.gnu.org ([2001:4830:134:3::10]:32931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ejvdU-0001BX-Fk
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 18:29:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ejvdS-0001Xp-Rl
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 18:29:48 -0500
Date: Fri, 9 Feb 2018 10:29:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180208232908.GD11634@umbus.fritz.box>
References: <20180130131716.5899D7456D5@zero.eik.bme.hu>
	<20180130194935.GL12900@umbus>
	<alpine.BSF.2.21.1802011250090.39992@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Hf61M2y+wYpnELGG"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1802011250090.39992@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH] sii3112: Change angle brackets to quotes
 in #include lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org


--Hf61M2y+wYpnELGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2018 at 12:51:04PM +0100, BALATON Zoltan wrote:
> On Wed, 31 Jan 2018, David Gibson wrote:
> > On Tue, Jan 30, 2018 at 02:10:10PM +0100, BALATON Zoltan wrote:
> > > This matches what other files do for qemu includes
> > >=20
> > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >=20
> > Applied, thanks.
>=20
> Thanks but Markus instead included this in his cleanup patches here:
> http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg00075.html
> so you can drop this from your tree now.

Ok, done.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Hf61M2y+wYpnELGG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlp83UQACgkQbDjKyiDZ
s5IspBAAsia6f+f/NNkZBp28CoAD83341pLadU9y238RKiLf8DN3Kw1RFgltLcFn
O4+dX36mNeueEQ9Yr4R7N30rs/oEkIjA0xIff/92EeiTDWj69iwAKWNfirNGvUNA
Kk9XB2g5LiBfFHiBXPud2VPp2vSJC4aMauYgIxyE8+MSwTiIDCyC/eyrDPU4akmj
h33KAfopAg66/0T4LMOV9wy2Pvk6JW/1DKKmczA23spbaDnUfZPoHOR+tFvWz614
l6yR3hjBlrelb2RMN1FEf+QZQWVDPGWw8mkmJZhSt2yKZX38sB4vNoLlbJPj0d15
9QBOjV+Y2QiXndWj6ojh3/T8g0ol0L2b3R+u381Q/3p840UFUwy8uHQ6WVOVOc1j
Ka/FmVaGroQBnJZRwjbGhHjejlU5sQh35HZ8AvlpXgbSN3TrjQDX9B6CE5F/u57g
T4zfHcMN2jgSC3MzZWVuCyE9SmLw3mTs8q8MBiIn8FCzRVzqJQHDpfuYdX0A3/tS
5EWsxrV1+aUbm5idAriIso70TVgf3kwew6Hcadqtl08NYOKmjjEEiLjP1rho0sPL
chlvGEnOQyY+SPwAZ/vSGgzpXNVBpz+OWFoCjBHGorS3jtnnALOLUoY69SCSJuWm
Op4LE9MINz06MtrPQgnZyGCq4g4e6zfB66vJWX6N3vO2wGO0B34=
=LRdY
-----END PGP SIGNATURE-----

--Hf61M2y+wYpnELGG--
