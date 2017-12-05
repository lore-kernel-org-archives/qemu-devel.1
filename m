Received: from eggs.gnu.org ([2001:4830:134:3::10]:37831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eM2jr-0004LK-O8
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 21:13:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eM2jq-0003Iq-KV
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 21:13:39 -0500
Date: Tue, 5 Dec 2017 12:23:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171205012309.GC3057@umbus.fritz.box>
References: <20171204034802.7336-1-david@gibson.dropbear.id.au>
	<CAFEAcA-DSVi1u9sQr5ZvCovtt+qTKoxPW2UiJxQt2YkLOWAuAQ@mail.gmail.com>
	<CAFEAcA9jp_gz25ZNvn1=y5qK+LHnqMUJfqKDtKcnNZnBRFRiMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9jp_gz25ZNvn1=y5qK+LHnqMUJfqKDtKcnNZnBRFRiMg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/3] ppc-for-2.11 queue 20171204
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alexander Graf <agraf@suse.de>, Greg Kurz <groug@kaod.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2017 at 02:39:42PM +0000, Peter Maydell wrote:
> On 4 December 2017 at 10:17, Peter Maydell <peter.maydell@linaro.org> wro=
te:
> > On 4 December 2017 at 03:47, David Gibson <david@gibson.dropbear.id.au>=
 wrote:
> >> The following changes since commit c11d61271b9e6e7a1f0479ef1ca8fb55fa4=
57a62:
> >>
> >>   Update version for v2.11.0-rc3 release (2017-11-29 17:59:34 +0000)
> >>
> >> are available in the Git repository at:
> >>
> >>   git://github.com/dgibson/qemu.git tags/ppc-for-2.11-20171204
> >>
> >> for you to fetch changes up to 768a20f3a491ed4afce73ebb65347d55251c0eb=
d:
> >>
> >>   spapr: Include "pre-plugged" DIMMS in ram size calculation at reset =
(2017-12-04 11:31:22 +1100)
> >>
> >> ----------------------------------------------------------------
> >> ppc patch queue 2017-12-04
> >>
> >> We are, alas, not yet to the bottom of ppc bugs.  This pull request
> >> fixes several more.  I believe they're important enough to include in
> >> 2.11. despite the late date.
> >>
> >> ----------------------------------------------------------------
> >> David Gibson (1):
> >>       spapr: Include "pre-plugged" DIMMS in ram size calculation at re=
set
> >>
> >> Kurban Mallachiev (1):
> >>       target-ppc: Don't invalidate non-supported msr bits
> >>
> >> Laurent Vivier (1):
> >>       pseries: fix TCG migration
> >
> > So my question here is about the same as to mst: are these fixes all
> > really vital? Were any of the bugs they fix present in 2.10 ?
> >
> > (A +7-4 diffstat is not too difficult to justify though.)
>=20
> ...so I looked at the patches and agreed they made sense for rc4.

Thanks!

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlol9PsACgkQbDjKyiDZ
s5K4IhAAh3AY16cWVcahBmuag/pC38bXC0+ytwklF2mW7o8Qql+UP2sFqCiW9Ex/
4QWXwAqFC2/x8EU43apDE7yX9ToBZrMLZmGjUdsZCU6wH89XImS8AYWSTNF9OmUP
/aEpl9EHsH7VV0+s0MCP7x+/l16rL5AjF6u51yBnTUhIyjYVNi0br1iFGb9RCnly
g9krq7MF2FVQcXuzg2z6plXtUI5Tu1S97miOIjxotAvSyWKf58nsySIOFTosSkG1
14li2ehuj00y33gVFlVSsGt/HFXzSrhHMBfn4mvZYJH6UR+MyLr7kE2CS+BIewJu
s/GySQoD38Qyr/o51a8mHMq/wtPRY2wv9SP89bA6EB0DR3GdXYwgsv/LG+iuzhzU
6s2Gbx2f8t21R60z5hnOpObIv7+hoD/e3tcRoy3CUmWZrRjPDb0+Y4hblvtJp4yo
ks9PmMEhso0lzln2+0yA8nDD06nkLcJwm3PcuVFDnaKFpXihG889OMQD4IFDQYRk
naIB/VWw6+jdeOwkmTG3NByHeN6DRz8fumxTFcyQ/rhaT4I0EDj2eVe80NAF5YuH
whCfq+zhWe8ZtsRbr5NUlmndWcO81Z2QhUmoCmO05U7B7VganH2D0F1VaWfpIitz
8ijfPUuVgx1Xg+uw0YEoGqBY2RJlhbI+OnwelRprXbVQeYB+0Iw=
=0Bwf
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
