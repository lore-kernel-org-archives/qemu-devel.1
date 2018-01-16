Received: from eggs.gnu.org ([2001:4830:134:3::10]:55875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebJbz-0007gP-RN
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 00:16:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebJbw-0008DT-O4
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 00:16:39 -0500
Date: Tue, 16 Jan 2018 15:58:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180116045800.GF30352@umbus.fritz.box>
References: <20180115180406.28489-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l+goss899txtYvYf"
Content-Disposition: inline
In-Reply-To: <20180115180406.28489-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 0/6] ppc/pnv: misc fixes and cleanups for
 POWER9
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


--l+goss899txtYvYf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2018 at 07:04:00PM +0100, C=E9dric Le Goater wrote:
> Hello,
>=20
> Here are some preliminary and straight forward fixes before adding
> POWER9 support to the PowerNV machine.
>=20
> The full tree can be found here :
>=20
>   https://github.com/legoater/qemu powernv-2.12
>=20
> Thanks,

Applied to ppc-for-2.12.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--l+goss899txtYvYf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpdhlgACgkQbDjKyiDZ
s5JyHg/+K98OKiDv+RQxL2LXwySKFOtXm4SV7RLAnU7GfBsPGIksfeBxknffQ0pn
DVIF1zMNLF11iI+6TfkAP9eAV5jgg2JGFeyUHGflU3gohBoRsK/32Jh0EGsK3xdS
8N0e1v0w2OJu3R96bkNmffuSKixnA5LTbgSHAbCFeX4XI0Rr6nnOG94Bzs12Bs9E
DoqJwufEQHeTSaeVMvF4kvKpjXibzKyye/Vsjljex9B2gVsmlJW7VDcKrRmwr2Sb
6I8FY6tfYLyrzayGksTGJ+l870rCDgWNwuBsfV5PF4l1vauCI0DdTAaCciryP7v8
ZnSo/y//58uvsl9ya7h8Rabk+q/WrFqQ8WpxtafGjCVbudYqmlKSilB+Wy8toHwR
1QbF+KAa8MdnIFcaH2T0c7wgsOjshmYBbx7J9hVvIykS8jNgsn4Ck+gsQC9zQLYA
Zc9735kmV11ABSoDCE3ujSCO8bHAOM+Oys4LjNvs0VcPi2N07Mq/HFzGjZe42lw5
yE/U48I135pI+n7KPB54Ls5ezon/8iWCuV1yzZjpnkoTD/ZD0gtPErjJRbjHx0N1
QC+TN3aHO4lQejpTONfa5VuCuDHlEEEP02RN7mlPRphM3grDX87JO7spLYaqFFwa
WkP4kxJ70rBVq6xAVpTMe1LyRQo1h+F6qZzO0ESeyRTlzwcPQZY=
=cyz7
-----END PGP SIGNATURE-----

--l+goss899txtYvYf--
