Received: from eggs.gnu.org ([2001:4830:134:3::10]:50266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE3mg-0003WO-AL
	for qemu-devel@nongnu.org; Wed, 02 May 2018 22:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE3md-0001Ko-5e
	for qemu-devel@nongnu.org; Wed, 02 May 2018 22:15:50 -0400
Received: from ozlabs.org ([203.11.71.1]:43233)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fE3mc-0001EX-H8
	for qemu-devel@nongnu.org; Wed, 02 May 2018 22:15:47 -0400
Date: Thu, 3 May 2018 11:04:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180503010430.GF13229@umbus.fritz.box>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430162359.5c963c50@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yRA+Bmk8aPhU85Qt"
Content-Disposition: inline
In-Reply-To: <20180430162359.5c963c50@bahia.lan>
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>


--yRA+Bmk8aPhU85Qt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 04:23:59PM +0200, Greg Kurz wrote:
> On Fri, 27 Apr 2018 16:51:03 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>=20
> > Hi; I usually let people forget about releases for a month or
> > so before bringing this topic up, but:
> >=20
> > (1) do we want to call the next release 2.13, or something else?
> > There's no particular reason to bump to 3.0 except some combination of
> >  * if we keep going like this we'll get up to 2.42, which starts to
> >    get silly
> >  * Linus-style "avoid being too predictable"
> >  * triskaidekaphobia
> > but maybe we should anyway?
> >=20
>=20
> Do we care for machine versions to stick to QEMU versions ? I ask,
> because we've already added a pseries-2.13 machine type (in master
> since David's latest pull req). No big deal though if we have to
> turn it into pseries-3.0 I guess...

We definitely want this to match the overall release name, so we'll
need to change it if we decide on something other than 2.13.

>=20
> > (2) release timing:
> >  * usual schedule would give us a next release mid-to-late August
> >  * unless I can persuade Stefan to do the release management this
> >    cycle we might need to wind that in by a couple of weeks so
> >    it's definitely done by the middle of August, to avoid a clash
> >    with a personal commitment
> >  * so probably hardfreeze 10th July, softfreeze 3rd July
> >=20
> > (3) retrospective, lessons learned &c
> >  * please remember that if every single submaintainer submits
> >    a pull request on the morning of an RC, it is physically
> >    not possible for me to process all those pulls in time to
> >    tag the RC that day. We had several RCs which got delayed
> >    by a day because of this; please try to submit earlier
> >    rather than later...
> >  * provide your opinions here ?
> >=20
> > thanks
> > -- PMM
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yRA+Bmk8aPhU85Qt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrqYB0ACgkQbDjKyiDZ
s5KujQ//Qru9DJqakcTTTCojXIFOuIPCGYabmGN6H7jUsxsXPxqrj1h3Xgzav2WC
5ONIXouemNAFB/tz6BW1Ni49tZ6zpRvCua+rS0pN0U2OFroX58bWyAz2i+y2vMTS
DcRnev1B7utre7Bbh7kSN3uJ320hQ1eEuUV1kbiA1d6xicfKO8TvQKBvrPXo4NRz
13BWaisQdF9lw2PUKuxZ4ms7bR8aUeXKyl+gvZvBZWWeQn0w2kPHvoNDRNU5o8Vs
apqA/a5LGZA0xthjZa1ZilJGPYVusvJuucDSWMX0zuk0npN4dMeY3STtaIFepYkt
GH4sdfXTcc+Sg+049qfEZoAVVrvLCdD6s9sJOdWLUU9x2G6xCaFUrSJpLfy0l5bo
Bu0vzEiCGGefeapzvNcETz3gSmO51EE59P9xBE44M+gPPtPvB9qKlm21sGN/7sN+
T9quvivhBwlHW9nIwYLscLwgE1X4bubqpVOTJhnCMvvTAYuMyhesEckmPWhdW9B/
BWa210u4jYH4F444oDdBasGAKNj+mNqLEUHJJulBysC7j4cjt7PmfFezPt3Ztyh9
xuZMQxI7gMDQJmfBTm8SJOv3AjUUScGdGCOLX41AX+mudYm7AofeGSK1L0mEgDlL
GZEs8NzXF66eDyukvDae71uFn99PMrQXDKIJ3g+nwDlg1fanc6A=
=bHJk
-----END PGP SIGNATURE-----

--yRA+Bmk8aPhU85Qt--
