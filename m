Received: from eggs.gnu.org ([2001:4830:134:3::10]:54259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSsx7-00066v-P3
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 19:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSsx6-0001zZ-P9
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 19:43:53 -0400
Date: Wed, 13 Jun 2018 09:31:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180612233140.GH30690@umbus.fritz.box>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
	<CAFEAcA85qHjDLBYxWW9i4T91m1uTS6TAY_y2A6_840n-_tDZKw@mail.gmail.com>
	<20180612175241.7340be80@bahia.lab.toulouse-stg.fr.ibm.com>
	<CAFEAcA8yKyHX-xVx5VPxBOy7-hiKDo+DgztVZ_sD5FxK77Z-9w@mail.gmail.com>
	<20180612204603.7bf254cb@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4LFBTxd4L5NLO6ly"
Content-Disposition: inline
In-Reply-To: <20180612204603.7bf254cb@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PULL 00/33] ppc-for-3.0 queue 20180612
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--4LFBTxd4L5NLO6ly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2018 at 08:46:03PM +0200, Greg Kurz wrote:
> On Tue, 12 Jun 2018 16:55:08 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>=20
> > On 12 June 2018 at 16:52, Greg Kurz <groug@kaod.org> wrote:
> > > On Tue, 12 Jun 2018 15:34:22 +0100
> > > Peter Maydell <peter.maydell@linaro.org> wrote:
> > > =20
> > >> On 12 June 2018 at 07:44, David Gibson <david@gibson.dropbear.id.au>=
 wrote: =20
> > >> > ----------------------------------------------------------------
> > >> > ppc patch queue 2018-06-12
> > >> >
> > >> > Here's another batch of ppc patches towards the 3.0 release.  Ther=
e's
> > >> > a fair bit here, because I've been working through my mail backlog
> > >> > after a holiday.  There's not much of a central theme, amongst oth=
er
> > >> > things we have:
> > >> >     * ppc440 / sam460ex improvements
> > >> >     * logging and error cleanups
> > >> >     * 40p (PReP) bugfixes
> > >> >     * Macintosh fixes and cleanups
> > >> >     * Add emulation of the new POWER9 store-forwarding barrier
> > >> >       instruction variant
> > >> >     * Hotplug cleanups
> > >> > =20
> > >>
> > >> Applied, thanks. =20
> >=20
> > > Oh... so we've broken bisect until Cedric's fix is merged. =20
> >=20
> > If you want me not to merge a pullreq you need to follow up to
> > the cover letter saying "please don't merge this" or something
> > similar. Otherwise I will not notice.
>=20
> Yeah I've only answered to the offending patch, sorry...

And it was the middle of the night for me.

It's only with pretty old gcc, I think we can live with it, I intend
to send another pullreq with the fixup as soon as I can.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4LFBTxd4L5NLO6ly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsgV9oACgkQbDjKyiDZ
s5J8OBAA1ALxyvdFbaMPpCm+YwmfLPabuL/PVhgVLbK+Ggby1s8AlaXETeskaK8y
sPEeYCeQmCxDVjsViZBJWmm1F1UvAn/hpqNOuT5N1roxXlmCU4tA4oCGrxpyWGM+
13PmR9WN2c60eQNGJXXrL2h3cUBF6hBLyDCFUl46GNOgTHE+p9xFk41VvJC5XdwL
pBz3zvpkOpaSk/jpDtBWk7vVGFA7xLAR7P1T4e55mPzD4fwuRfQ5D7dpchpbQ3v3
8++yXnOyvystUsPNqwZqXTea/4zvt+T1gphF72y2T+d/5SzrJIFackfLr/O0qRDl
XD4WpApGSk239Gpeghcn2RTXB9XHkwYP1vaTXPPdgrgJ59alVJq058BNkbJ6NY19
YZYLANRYbZU67mH2OnW5i6IsQTtHcDEAcv8z0qC9HuaMFHAS5l3Nf6S7DP9q5wKq
fApsE+JmHefQ31ZsJ2JTV0Ir8Vr+KqFJamIT7VY1OVgeMONYALIYGG6TAfqSbHfk
jCf4BJnw6OoIzmEgUGBMP+3vRbuPZWHj//iPNV6AF/lH99xntSV13NoOJu89egIy
nppfFJYR2Pqb11fnj4JYjNS1jzaSh2rsdGZrDSD4rc4NPtIx1yObj7Wz9ZbOFQvx
3BTlK1uUEppAyOwzTwVv5/NDECLeHP3QeIXIzRF2rSa3xB5BCoM=
=wzz6
-----END PGP SIGNATURE-----

--4LFBTxd4L5NLO6ly--
