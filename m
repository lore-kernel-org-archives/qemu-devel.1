Received: from eggs.gnu.org ([2001:4830:134:3::10]:44178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYjBL-0003xK-3U
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 19:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYjBK-0007Ux-3S
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 19:53:55 -0500
Date: Wed, 1 Feb 2017 11:24:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170201002421.GD30639@umbus.fritz.box>
References: <1484299420-23031-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<87fuk954zp.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline
In-Reply-To: <87fuk954zp.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] POWER9 TCG enablements - part12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 12:17:22PM +0530, Nikunj A Dadhania wrote:
> Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> writes:
>=20
> > This series contains 5 new instructions for POWER9 ISA3.0
> >     VSX Scalar Test Data Class
> >     VSX Vector Test Data Class
> >
> > Changelog:
> > v1:
> > * Zero the match variable in the element loops
> >
> > v0:
> > * Concise logic for identifying data class in Scalar/Vector=20
> >   test data class instructions
> >
> > Nikunj A Dadhania (2):
> >   target-ppc: Add xvtstdc[sp,dp] instructions
> >   target-ppc: Add xststdc[sp, dp, qp] instructions
>=20
> Ping?

Sorry, I've been away.  I've applied them now.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYkSq1AAoJEGw4ysog2bOSc7YP/3nIsfTgWvg23fe8I3G01d83
Q79jzEzP1emK2zi3EwP0Q38anbkbuo2yXhpjMh6PlZ9C+7RzvvY14SFw2crsRRGD
bqTslNLBOke03Tp5ONP1M6ytFlajZu43Z99GZccI+qoa1AWqHh2Q5YavSGDYB1W9
0SBtd79yXQ+iB+Is2GrohNuxFss6epl7FeRyGSUqmLE3a5kSYnjYvHIpp5hRlMz6
TiUau533AV2hpn6DKXcpLHMRxDiDG7flpd6cYOiN76Bd3RG8/GR6F0PLHfm/hLyU
udR2cLlanoLnvR8NQqNL+ZSbl835a0fTCV2LC5GB8fBg3t/6LdO+GK9HYwNbAVhs
5DT+sRZswk9n84NawGZH3EbiUlEajjOYRMojS9EgeKk+tlbu9ahkWtkw230MKI5t
+n8dZ4y02U2UKWUZTcqDbLIeHCspEyjMflH2OMLK/LBZIXaDm0dY/VNW97dhZn2G
LJS/s7pPGNGQBMtCHvO7noJmThAGXia3lDGz/RPxK4Vh6JMXcBhJuhIyRbi1YaS/
6VDMBFJJKALbZSOpCBw8P5AUWwzac7rIXyEUnGbAkJFWPgBXpuZQ9dCkLum9xo/O
mpSTS4sB/SoZ4yZvuqrGGAh9YlMFCrAn/X3GOKD4vFfIlgK2oFjsNBp+zcny6Cbx
vT1uJ4vEo5cVB0viIkX1
=7lfg
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--
