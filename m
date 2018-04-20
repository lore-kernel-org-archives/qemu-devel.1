Received: from eggs.gnu.org ([2001:4830:134:3::10]:41287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f9ROH-0007gG-8z
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f9ROG-0005kg-5c
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:27:33 -0400
Date: Fri, 20 Apr 2018 17:15:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180420071512.GP2434@umbus.fritz.box>
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
	<20180417071722.9399-3-david@gibson.dropbear.id.au>
	<20180419192105.7eb51b26@bahia.lan>
	<20180420064057.GN2434@umbus.fritz.box>
	<AM6P194MB0440ED52FDC81F0C623EC91CC8B40@AM6P194MB0440.EURP194.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lx6+J6gHrzwEpYNy"
Content-Disposition: inline
In-Reply-To: <AM6P194MB0440ED52FDC81F0C623EC91CC8B40@AM6P194MB0440.EURP194.PROD.OUTLOOK.COM>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for-2.13 02/10] spapr: Remove
 support for PowerPC 970 with pseries machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luigi burdo <intermediadc@hotmail.com>
Cc: Greg Kurz <groug@kaod.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


--lx6+J6gHrzwEpYNy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 06:48:11AM +0000, luigi burdo wrote:
> (because testing if we broke it means finding
> a real 970 host).
>=20
> Hi, i have a real 970 host if you need an hand to test just ask

Thanks, and I'll keep it in mind, but borrowing a system from some
random person isn't really a manageable approach for the long term.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lx6+J6gHrzwEpYNy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrZk38ACgkQbDjKyiDZ
s5L9cg/8DLW1pvP+Gz8T6Yl5uiy1PfJIiJCWQeIU7a31KxRlRaYmrV5ygmZbStRd
h1goo6cpkVID/Rc3ykc2aaSbrV3DP8ryExhdlkc1MQEv6LSPtxTjfc4C6eayn+Jh
qm8g/SD9c+cqdnn8XcPVR0c5mibnOaGc0d1ARtlPEGbXRUpYMgrSi3eeNSPIu0DZ
JqvdOHKHUHASzbvCz5scJxpPPH3X5hYnZDo2cbvS+GQ/Fns8yc4kwBQ9PMzor//q
buk5rcHiR7FpA9xzJJVvO6/g0FJH/FWPOHvD569rh9bzmfHSMPXpJdgPPHXHwQC5
1ZG4XRHHaq2LV54SVxCfcZKfpEIG/iDJymRqNJw1N2Y/+A5+a517nK2nKHRDdA+p
Ff3YdwOs1n3oMvtkGyr07Uf3J46p6bi32LGsySmtsD5bZCpLoux1Sfwrj6ffxcme
F81CbXdb3JG1kwT2mQb2H/LwtNY3Va4lHXMVKi5x7d39Ww6T8cVtHCiuIwZTcIkA
kCN7wQBThoXKYrM2rZn0bbBc/r/j0BcHBNAXXnI0TJinHH1tQUjqHdQZuo2RXGB2
v51lx9ZF9MI3mDoUI0g2v9MwnSojdx7JlQaPmTXfHem7VjKdWOxKYxauUH/lCIzl
UPvtBqaSMQkhSNulzjztLJy5f0ZZ1J+hmGyLxHsh3AKMnjfxdoM=
=/Bvd
-----END PGP SIGNATURE-----

--lx6+J6gHrzwEpYNy--
