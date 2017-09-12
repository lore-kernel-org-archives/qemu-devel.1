Received: from eggs.gnu.org ([2001:4830:134:3::10]:33425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1driIx-00039T-N8
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1driIt-000449-OP
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:20:31 -0400
Date: Tue, 12 Sep 2017 16:52:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170912065252.GA7550@umbus.fritz.box>
References: <150512483616.8642.15831240906912354238.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <150512483616.8642.15831240906912354238.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 0/2] spapr_pci: some more cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 12:13:56PM +0200, Greg Kurz wrote:
> ---
>=20
> Greg Kurz (2):
>       spapr_pci: convert sprintf() to g_strdup_printf()
>       spapr_pci: don't create 64-bit MMIO window if we don't need to

Applied to ppc-for-2.11.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm3hEIACgkQbDjKyiDZ
s5I04w/4xmccc7DIoWaLvRKzu39nhgD7oFl+iPKQ7y3mItbEwnsDCOEZlIpzJiP+
9scmyqPTP/AEMTKU9URiagacIIB2yGvgTJwZKDAy14t/ZU1CFSxii/J1w1rIsIDG
opAOW3RSqg52laheDai2noaUizfYxuor+HfZw+wm1HON32IRZdxDp+yqpLUvhr4y
HKSHIWyTgbENQw1zDi+E1L6A3qosVbqcTrQsiTtdC5GVNNEBGFo6dMiXH2Pp0cIl
HTIa7HzsOudR+Bnmnc8CJWrSUBh28I8SYsdUgXxduGSHCKW09ayr2pKKOdj5vi5c
lpSVSfHWZvqrZJmbetPOD0AN1aqm0wBAoAvT8jKISr5kP4mCK+M2Z1IZbTHWS9M2
04h+6EQ61yxKDT1L2P1iJCJ2obAcoqK00Y/kuf1kN1ElnbbsgrpCHZXnRG+RucV1
8ivKOj9VChLraYbXf4vB/A0lSoo63gKmquIYGKmDyQKb02LbVcWA1B1iTPIbGEeY
gUsablFl2yfgig4CWXLHbtJU8dSTgD5li1fvqCQ1zi26fC9so2dZfDu+ZvSC6+/p
YtUN/i/NS2uk6fH8CSiJCJq01wa7jEcxNQi44dtsfXJFHEw7CkOeV+aew4YMQZmE
eRVs4GFW8Y0gM/hZKysRBDhcvOpwNzzVMPO0hEKIg1eBOcQjrQ==
=GSFi
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
