Received: from eggs.gnu.org ([2001:4830:134:3::10]:52516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emV5q-0002rz-RP
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 20:45:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emV5m-0000CK-V8
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 20:45:42 -0500
Date: Fri, 16 Feb 2018 12:14:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180216011458.GA2074@umbus.fritz.box>
References: <1518724309-5025-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <1518724309-5025-1-git-send-email-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCHv2 0/2] target/ppc: convert to generic
 translation loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2018 at 02:51:47PM -0500, Emilio G. Cota wrote:
> Changes from v1:
> - Removed use of translator_loop_temp_check; call tcg_check_temp_count
>   directly.
> - Add R-b's.

Applied to ppc-for-2.12, thanks.

>=20
> Thanks,
>=20
> 		Emilio
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqGMIwACgkQbDjKyiDZ
s5K8HRAAmbExwTZMACSvxC+1tCLZUMr3sKlsL2tABN1NgzWyGfKWzxlOkyKN6W0Q
9LTpNCCDFw6bpzq1H7JTZQoPKxh9a6IC0F41Rum3qduw2FG/boR1BCTe3+G7cD0N
w5BbZl8PpP5GUcdqt9xWQmhTWzGrJ+COzVI0yB9IiKKkPIWQ5UTRi5P/0tHojhaY
zmFkgsBK7gClyPShXaQdXgp9F2CauYvvkJBFL35TvrrmV4EyboZt7maJzesoyaCf
/XCO1D7kqpusb2dy3Ihsdfx8g5ft9DTRHtSn49XGRKVDScy07HM3v9+cr+znjyRR
0aEdNmDpvpQynMwm2lqV+75QJdha9r7QecDtV9oU9UuMc+ealKuQRpjisthvFgEY
cJo/RaWplG1J3aC95EU513gV9DOnHF8EcH9Jm1BZ0qDwCUgX/nk4o1WXxG3K9Urq
gl9vKGQTyNiBcnCJTjRaIUQBjGaYraTrUKACGhosgObteOV3KiGNwHc63GKYElhP
OpAXp8vMweW7GT9tqDDtqHn7Fcf2zdIO4oUTUXbtQ0hsTbgtUB6ll7wejmOTtKiQ
cVQypCRzxZZutI+Yc0Ze3/rchruqekr3p1k1s9FZtdvSx9UGhlTX8Sswg++qU+2s
669wZKs8545rgbw6G6Yj6aO5xoQkinHZ52bfpWAXg2YQ6cNoMPs=
=Eq1M
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
