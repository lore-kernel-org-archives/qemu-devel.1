Received: from eggs.gnu.org ([2001:4830:134:3::10]:39507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWWk6-0002Iu-Ts
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 20:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWWk5-0007n4-Tn
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 20:49:30 -0400
Date: Sat, 23 Jun 2018 10:41:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180623004105.GL612@umbus.fritz.box>
References: <20180622103528.28598-1-david@gibson.dropbear.id.au>
	<CAFEAcA8-jSMy-9R69d7zQoEL593iiR5xitaPh17JwNzo-2U=1g@mail.gmail.com>
	<e56f27b2-63da-a8ae-4473-e75f341ef275@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gwtGiOGliFx8mAnm"
Content-Disposition: inline
In-Reply-To: <e56f27b2-63da-a8ae-4473-e75f341ef275@ilande.co.uk>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 00/25] ppc-for-3.0 queue
 2018-06-22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, qemu-ppc <qemu-ppc@nongnu.org>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--gwtGiOGliFx8mAnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 22, 2018 at 04:16:10PM +0100, Mark Cave-Ayland wrote:
11;rgb:ffff/ffff/ffff> On 22/06/18 16:03, Peter Maydell wrote:
>=20
> > On 22 June 2018 at 11:35, David Gibson <david@gibson.dropbear.id.au> wr=
ote:
> > > The following changes since commit 46012db666990ff2eed1d3dc199ab80064=
39a93b:
> > >=20
> > >    Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180619' =
into staging (2018-06-20 09:51:30 +0100)
> > >=20
> > > are available in the Git repository at:
> > >=20
> > >    git://github.com/dgibson/qemu.git tags/ppc-for-3.0-20180622
> > >=20
> > > for you to fetch changes up to e5ca28ecab5c69b7578e22391a66c97c3979ff=
d8:
> > >=20
> > >    spapr: Don't rewrite mmu capabilities in KVM mode (2018-06-22 14:1=
9:07 +1000)
> > >=20
> > > ----------------------------------------------------------------
> > > ppc patch queue 2018-06-22
> > >=20
> > > Another assorted patch of patches for ppc and spapr.
> > >      * Rework of guest pagesize handling for ppc, which avoids guest
> > >        visibly different behaviour between accelerators
> > >      * A number of Pnv cleanups, working towards more complete POWER9
> > >        support
> > >      * Migration of VPA data, a significant bugfix
> >=20
> > Applied, thanks.
> >=20
> > -- PMM
>=20
> Looks like this is missing the 2 Mac commits I submitted that David added=
 to
> the PR this morning?
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg06540.html
> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg06536.html
>=20
> David, did you forget to re-push the updated tag?

They just missed the window, sorry.  I merged them after I'd already
tagged and tested the pull request.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gwtGiOGliFx8mAnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlstlx4ACgkQbDjKyiDZ
s5Im9Q/+O6P0mfn/c/KoRHI/qwIZ0//oiGHBwBQEviE+vpxev/OkZ4GX1Vu9KkK4
7+SJMNDfpOWhvIFIPYnRagXMfIfCauZMRbbPcTBuzxIsSixqHZ8o0glmjnQMZhjo
p94d6uRunIZ/iG8Fx6u5cSMkqE5Kggn0d95NrHqbJihD9vtYB2i/JOwgUIBg1C9Y
Q+8a40rwJD9F0rmJMERwFUIrGMJsKAcWiXI1M0lfciktYZLAdblw6Hd2XT9SLxJ0
6vlgdUeySo9UWR4tOkUxU/glz5T9AU1Xq4Ksp/Ojbt2iJj8Q/V8o3z+8JKewWOyv
p4TBcp24MaLQ8fGS/4f1AytNN8FQ/kxcBOs3v9o94eb6dP8wkmVS6nskR/Wms3E5
C4F25HeYLI6bwWJGH59FkcDH+pZxXz9YkD25AYrna3BHqmkDKc3BOWC8p+mG0TKn
I2d6lCMBp8SQPPYXHtNoTodZBgtjUCax7llx09xuqXElKH991omSkfjLUEPSF28E
ytOLov3pbEgu8sUmaD+Umip0i610knVJ/hNumlw4QAGz5Tdhw6Xvv1qHNkoJ1Qxy
lqhk+U6iZwBZ7q4JFnWhQHzTi8UW03xy416SVSGGqZm0osedUccmCGu5gzxY6Km4
o5oA1rpCbkwtvBTRZVM2qvxl4ZW2m2tNNARPfHQ+rPZKryeAhP4=
=wVqT
-----END PGP SIGNATURE-----

--gwtGiOGliFx8mAnm--
