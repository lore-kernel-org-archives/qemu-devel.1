Received: from eggs.gnu.org ([209.51.188.92]:58507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ghkpc-0005bH-Uy
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 19:37:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ghkpb-0003UO-QB
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 19:37:52 -0500
Date: Fri, 11 Jan 2019 11:37:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190111003735.GP6682@umbus.fritz.box>
References: <5c2e6965.1c69fb81.b832c.13ee@mx.google.com>
	<2c434536-6388-563f-344b-c6800769a733@vivier.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EkxpYdHiqGHPYbUt"
Content-Disposition: inline
In-Reply-To: <2c434536-6388-563f-344b-c6800769a733@vivier.eu>
Subject: Re: [Qemu-devel] [Qemu-trivial] Whitespace cleanup:
 target/ppc/translate_init.inc.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Jon Diekema <jon.diekema@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, qemu-trivial@nongnu.org


--EkxpYdHiqGHPYbUt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 11:15:26AM +0100, Laurent Vivier wrote:
> Hi Jon,
>=20
> please cc: qemu-devel and MAINTAINERS when you send a patch.
>=20
> You can have the list of maintainers using a script in qemu directory:
>=20
>    ./scripts/get_maintainer.pl XXXX.patch
>=20
> Thanks,
> Laurent

Hrm.  Like the other patch, I didn't seem to receive this - I checked
back through my archives.  I think something must be not working with
email from Jon to me, although I can't quite imagine what.

>=20
> On 03/01/2019 20:58, Jon Diekema wrote:
> > From: Jon Diekema <jon.diekema@gmail.com>
> > Date: Tue, 25 Dec 2018 04:03:04 -0500
> > Subject: Whitespace cleanup: target/ppc/translate_init.inc.c
> >=20
> > Signed-off-by: Jon Diekema <jon.diekema@gmail.com>
> > ---
> >  target/ppc/translate_init.inc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_ini=
t.inc.c
> > index c971a5faf7..b5f4c9bd55 100644
> > --- a/target/ppc/translate_init.inc.c
> > +++ b/target/ppc/translate_init.inc.c
> > @@ -5237,7 +5237,7 @@ static void init_proc_601(CPUPPCState *env)
> >                   0x00000000);
> >      /* Memory management */
> >      init_excp_601(env);
> > -    /* XXX: beware that dcache line size is 64=20
> > +    /* XXX: beware that dcache line size is 64
> >       *      but dcbz uses 32 bytes "sectors"
> >       * XXX: this breaks clcs instruction !
> >       */
> > @@ -10485,7 +10485,7 @@ static void ppc_cpu_class_init(ObjectClass *oc,=
 void *data)
> >      cc->tcg_initialize =3D ppc_translate_init;
> >  #endif
> >      cc->disas_set_info =3D ppc_disas_set_info;
> > -=20
> > +
> >      dc->fw_name =3D "PowerPC,UNKNOWN";
> >  }
> > =20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EkxpYdHiqGHPYbUt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlw35U8ACgkQbDjKyiDZ
s5IG1g//VvXNy8J7FYFtXA7vg7vNmovn6VVK0g4RdzegqTho0pnF7JMDsonsqsiX
u0173dqIPGWzwY3qNaQgpdMS47hiqr2gZSwkXNCtJnQvSb6GJxKBLywDgdNjFmjS
cWIDmzmSE7velgzozRwyEWGnQxtuv76r173VpDzRBDzt0V1v2OlIgeSKk8HL4REJ
OT1ieyFtQLpPk+GqRzEWIezfwPRtmaRn65RK7V2qn6zKd2BcilSqNOqWWQZUhK60
5VqLYaA6u5KKI6aPym5FP3H2oiggE0xYb1HLsn/Cjf3N22itC6PSrF116X0Yz/U7
U9E3HTmeedzaAmOgUDVt4Bp6LwiXtXQPl97Kp3bZX6EQ5ZNsiK4wVdf9OPZxmeqr
LbeOA2QWm5qK6Lqk+V45GhP6g0+BSncbiUZJxv6JalpzNc1PgV4g0ZHcwX9LTsTx
qTb1X487ZhuTfZwltOFR+rbvKRfnhgarNVIbQIwiUWX2um4pH/onxar+6jFBGqOP
KbSiSZZKwRz6IXUyQ6ZCGYAIojZPkMXgzmDBYhieK8Pn/TgkO8Qi4saHMHWTQ2sK
xOOEX3wKaIBknu9lL2LrMbjAY0oimLX2baRmwaSyrq+WjtA0UY+rEiwryUCreFZB
dJECEiInXJoQ5WfJN4iIHE5d9TquegN5cFEBVI+iIGikR1UmRh8=
=4qbU
-----END PGP SIGNATURE-----

--EkxpYdHiqGHPYbUt--
