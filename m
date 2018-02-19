Received: from eggs.gnu.org ([2001:4830:134:3::10]:60170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1enaqn-0001BI-Ez
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 21:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1enaqj-0001sw-H0
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 21:06:41 -0500
Date: Mon, 19 Feb 2018 13:06:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180219020625.GE1109@umbus.fritz.box>
References: <cover.1518730026.git.balaton@eik.bme.hu>
	<0d6dd5c0e5279896b29b140b198f2a9f6b2d87ba.1518730026.git.balaton@eik.bme.hu>
	<20180216031014.GD2074@umbus.fritz.box>
	<alpine.BSF.2.21.1802161143460.98686@zero.eik.bme.hu>
	<alpine.BSF.2.21.1802180044120.3331@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Uwl7UQhJk99r8jnw"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1802180044120.3331@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 3/3] ppc: Add aCube Sam460ex
 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Francois Revol <revol@free.fr>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--Uwl7UQhJk99r8jnw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2018 at 12:48:27AM +0100, BALATON Zoltan wrote:
> On Fri, 16 Feb 2018, BALATON Zoltan wrote:
> > On Fri, 16 Feb 2018, David Gibson wrote:
> > > On Thu, Feb 15, 2018 at 10:27:06PM +0100, BALATON Zoltan wrote:
> > > > Add emulation of aCube Sam460ex board based on AMCC 460EX embedded =
SoC.
> > > > This is not a complete implementation yet with a lot of components
> > > > still missing but enough for the U-Boot firmware to start and to bo=
ot
> > > > a Linux kernel or AROS.
> > > >=20
> > > > Signed-off-by: Fran=E7ois Revol <revol@free.fr>
> > > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > > ---
> > > >=20
> > > > v2:
> > > > - Rebased to latest changes on master
> > > > - Replaced printfs with error_report
> > >=20
> > > This has a conflict in hw/ppc/Makefile.objs.  Looks like it was based
> > > on some other patch that added ppc440_pcix.o.  That's not there
> > > upstream.
> >=20
> > That's patch 2/3 of this series. Have you missed that?
>=20
> I've sent a v3 for this patch (3/3) now:
>=20
> http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg04774.html
>=20
> which includes the dts and dtb as well (I'll send a separate patch for the
> firmware after we agree on how to best do that). The missing 2/3 of the v2
> series is still valid and needed before this new patch:
>=20
> http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg04259.html
>=20
> The v3 is only replacing 3/3 of the previous series. Hope this is not too
> confusing.

Uh.. it's a bit awkward.  Especially since I do seem to have someone
mislaid the earlier 2/3.  Can you please resend with whatever's needed
on top of the current ppc-for-2.12.

>=20
> Regards,
> BALATON Zoltan


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Uwl7UQhJk99r8jnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqKMR8ACgkQbDjKyiDZ
s5KbNBAAhc0Q5lXNfSef9AJLKL/k5gEFCWgegpdXI9VCKK3qz4LOcSVhXyfObTkM
72s2CXoGUgN5HShJXTo+weIfPWFjeqO0fd7E/F7xfEfYzsBnhGJvbSks8emzDiEr
hAy7Wtw+R/jiDuQ+yyr9l29+7gkKFS28GlTdYoc4rob9BCnrWbeqThHGc9HGQYrd
SXssmz2SIprgvGDdw23DFs8Eh9J6tPv4FoCS1CMkJqFOueMlbuZkq2OAVDR2gFOH
WWHR6fytjUSZMDvOhjpJ9BAQeS6bgTM5+42CvqagRVyB/+Ozcf7qVSFb/xRe8njG
X2GOf76sZTx5b/7Ecab7FqZbEYo3Ko5dWVNAkOPHqiVeFwA8QjVQA0OEq0WPPU+W
r1TrXQpdRrzCggPiqchl9yE78mU2P6zA5mUdfV4Zvfb/PulrNXiRlGLWX0niK3OA
qLE3I2rqhFsi1LOxX6qnAU1DTtvpBQYuE87ldmw68lbnwEOFx0DPmQQ2TRomr5zk
S8rYDn5tJ+n41yBWbrzSPlDC1eqYBCga9224otgl1UaJZv0muxmB+SS8JlMlwfVT
evXlXVLlm5CnUksnYKoqDz9bNOVLbNQo0Qpq4KnSrqdVT2zKSmdu/adzsp7r/Rj5
iQgn6h05zOD4Uwgsu8sEmrKh1PUgifY0DC+DSg3YgR81wMKus5Y=
=y1Oq
-----END PGP SIGNATURE-----

--Uwl7UQhJk99r8jnw--
