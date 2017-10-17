Received: from eggs.gnu.org ([2001:4830:134:3::10]:35520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@mips.com>) id 1e4Stb-0006yP-F0
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@mips.com>) id 1e4StV-0001SP-FY
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:31:03 -0400
Date: Tue, 17 Oct 2017 15:30:16 +0100
From: James Hogan <james.hogan@mips.com>
Message-ID: <20171017143015.GP15235@jhogan-linux>
References: <20171017141311.22194-1-james.hogan@imgtec.com>
	<1abdfc6b-6e23-0949-84b1-bd1b1f6121c3@vivier.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ie5iOtK4e9kgqh2F"
Content-Disposition: inline
In-Reply-To: <1abdfc6b-6e23-0949-84b1-bd1b1f6121c3@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH v2] Update James Hogan's email address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org

--Ie5iOtK4e9kgqh2F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2017 at 04:21:13PM +0200, Laurent Vivier wrote:
> Le 17/10/2017 =C3=A0 16:13, james.hogan@imgtec.com a =C3=A9crit=C2=A0:
> > From: James Hogan <james.hogan@imgtec.com>
> >=20
> > Update my imgtec.com email address to my kernel.org one in MAINTAINERS
> > as MIPS will soon no longer be part of Imagination Technologies, and add
> > a mapping in .mailcap so get_maintainer.pl reports the right address.
> >=20
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Cc: Michael Tokarev <mjt@tls.msk.ru>
> > Cc: Laurent Vivier <laurent@vivier.eu>
> > Cc: qemu-devel@nongnu.org
> > Cc: qemu-trivial@nongnu.org
> > ---
> > Changes in v2:
> > - Use my imgtec address as the author / SoB (Laurent Vivier)
> > ---
> >  .mailmap    | 1 +
> >  MAINTAINERS | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/.mailmap b/.mailmap
> > index 28defa1b2c57..5aec1bdf9f7d 100644
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -8,6 +8,7 @@ Aurelien Jarno <aurelien@aurel32.net> aurel32 <aurel32@=
c046a42c-6fe2-441c-8c8c-7
> >  Blue Swirl <blauwirbel@gmail.com> blueswir1 <blueswir1@c046a42c-6fe2-4=
41c-8c8c-71466251a162>
> >  Edgar E. Iglesias <edgar.iglesias@gmail.com> edgar_igl <edgar_igl@c046=
a42c-6fe2-441c-8c8c-71466251a162>
> >  Fabrice Bellard <fabrice@bellard.org> bellard <bellard@c046a42c-6fe2-4=
41c-8c8c-71466251a162>
> > +James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
> >  Jocelyn Mayer <l_indien@magic.fr> j_mayer <j_mayer@c046a42c-6fe2-441c-=
8c8c-71466251a162>
> >  Paul Brook <paul@codesourcery.com> pbrook <pbrook@c046a42c-6fe2-441c-8=
c8c-71466251a162>
> >  Thiemo Seufer <ths@networkno.de> ths <ths@c046a42c-6fe2-441c-8c8c-7146=
6251a162>
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9522d1b621bd..b01f5c46ef83 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -284,7 +284,7 @@ S: Maintained
> >  F: target/arm/kvm.c
> > =20
> >  MIPS
> > -M: James Hogan <james.hogan@imgtec.com>
> > +M: James Hogan <jhogan@kernel.org>
> >  S: Maintained
> >  F: target/mips/kvm.c
> > =20
> >=20
>=20
> Thank you.
>=20
> I don't understand why you need to update the .mailmap: updating the
> MAINTAINERS file should be enough to have the correct address with
> get_maintainer.pl?

It allows get_maintainer.pl results based on git history (e.g. git
blame) to show the up to date address. Admitedly I based that on my
equivalent patch for the Linux kernel, so perhaps it is less relevant
with QEMU?

Cheers
James

--Ie5iOtK4e9kgqh2F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlnmE/cACgkQbAtpk944
dnrSwxAAozhfXqaMDP+XEcMeJdTE+vSV6Jhh+J+leA2NRfxqvkRXFPbooyKNJiuS
fz+Iw5OZYwMaVbRyOzrYejWObVITr+R5ykHbjsqgF23R2jFMEsY4xyJaaR01aOlK
Xq0WXuYazKnjt2KjjegqG1SvL8i0Bd4xv7w3s6i9DRvwk867sA8ZfTnvmouUY+JX
Yp2b5enm2VEAW5hXR2b9QpnaVT9oM+v3Y1qcSEiaAfc++ChGG1B0elTBdQVW4bJ9
IA9oZHR0X3xyRWGm6tbnQtrMp6LTGPmEDS0l+XiR/TP4/g9ajPMwJ1vuFqPQcwTS
GHZDCKXdt3rTLZ3FaSDiAc9YQD7duEg/hrHcxyMBgZ7oZ31quhFRP7fBFH+iwIR4
tgRexrUP2R7WtYK2FgKL8xFfyzaVVhJB/cGhylhf+P5YmMiByqwEwOnpwxmlLNdH
AQZ4t1cZFSb2UzxQNDfE2RA508A76hjzOA7Ue6ru34xCmNFH1AoEl6168dPdOZMa
AcoEzbr9+E3ZzGNLhds54oZh3gQYH6b85wMz9TqDg/45uzJwb3mKt1kmnzFcr38Q
iGKHnq2YjviQIXP15/pLWGomWPe0BYe8l7Zmp+Uj6ngTQ62T8uPv02FkM/Ej19cN
U3XD6ccHFbQFfgmoaxtf2SJ7txpNNYavw47GvtuwHJhOGmDuHds=
=oSQ1
-----END PGP SIGNATURE-----

--Ie5iOtK4e9kgqh2F--
