Received: from eggs.gnu.org ([2001:4830:134:3::10]:45586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWJPq-0000bw-1m
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWJPl-0003L5-TJ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:35:42 -0400
Date: Fri, 22 Jun 2018 20:32:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180622103258.GJ612@umbus.fritz.box>
References: <20180622042437.14259-1-david@gibson.dropbear.id.au>
	<20180622114439.08447173@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k1BdFSKqAqVdu8k/"
Content-Disposition: inline
In-Reply-To: <20180622114439.08447173@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 01/23] ppc/pnv: introduce a new
 intc_create() operation to the chip model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: peter.maydell@linaro.org, agraf@suse.de, aik@ozlabs.ru, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--k1BdFSKqAqVdu8k/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 22, 2018 at 11:44:39AM +0200, Greg Kurz wrote:
> Hi David,
>=20
> I'm a bit confused by this massive post... it doesn't have any cover lett=
er, but
> it contains all the patches you recently pushed to ppc-for-3.0. Was it su=
pposed
> to be a pull request ?

Gah.  Yes, it was.  I'm not sure quite what went wrong there.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--k1BdFSKqAqVdu8k/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlss0FoACgkQbDjKyiDZ
s5J57RAAjbMWjB4AtQMWpWcWBHnwr8YYJf9rgF0aLheh+uilNcx1kTOKn1g8LsS5
PJLeKa2nvmCcIS+RgAXnV41KxwJ2FUwYP2IyCWLBqeoBhveLL37VuLh87ULnr6Mq
s9krsN2zRStagfz6JUO5bxZYDH46eHJRNCm7i3wx2d29cPsha4wCCs7icQOJlWnX
O0dcUq6cW68oq8I3dkNogLyZLW4VPW4fmVi8nun3HkarWYsEuonGdte0bSi51N0N
PNrWUApeFeokzAsfz1ItC+YIXG2icIKQ40ukc7y6wTEyBDI60A7GAR+LYzFM08jG
1ZUS/3+/Zhp3OskUP6nuUwJrTo1MmAhNmrASM06X7mDnlJygcRm7D6d95sFRvExT
hJ4xcqADwRTSlWKkgWmapNFPHUWFToYFRqHvr5cjQyziYLPPS7X7smobh3S342HB
O2YzzfYZAnvBLBrcuTKgm9WphPNWsNUqLW3DwSbvQBt27nvTpMiB6R5KyB6yT6+M
ZuNk2emv32y01K2gA+1sK0CUZbyxMkWjEKDSboqgXBjKWd3uBZEjF8SQG2GFZ/mh
lDu1MPsGmun8kc5qIKFWUgCNrdDO08ohbgs+ZDOxpqnmhb3GhfypTvpMeNnVTapk
l3lnBjKdLAl04aOSUsjsAONvW99h1HiEGfizV6lx0Ui08jgMKgY=
=NKeX
-----END PGP SIGNATURE-----

--k1BdFSKqAqVdu8k/--
