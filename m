Received: from eggs.gnu.org ([2001:4830:134:3::10]:50174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fZq53-0005Jg-N4
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 00:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fZq50-0005XY-K6
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 00:04:49 -0400
Date: Mon, 2 Jul 2018 14:02:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180702040239.GS3422@umbus.fritz.box>
References: <20180618215601.8974-1-mail@sebastianbauer.info>
	<20180618235557.GB25461@umbus.fritz.box>
	<73dd5b26b622e6c59776976aa2c7a3a0@sebastianbauer.info>
	<20180619043631.GC11674@umbus.fritz.box>
	<607559ef0fd95f557b5001a5db29883f@sebastianbauer.info>
	<20180630061443.GP3422@umbus.fritz.box>
	<alpine.BSF.2.21.1806301325320.13465@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WVXkb2QE2eH0aWe4"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1806301325320.13465@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH] ppc: Include vga cirrus card into the
 compiling process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Sebastian Bauer <mail@sebastianbauer.info>, qemu-devel@nongnu.org, thuth@redhat.com, qemu-ppc@nongnu.org


--WVXkb2QE2eH0aWe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 30, 2018 at 01:29:05PM +0200, BALATON Zoltan wrote:
11;rgb:ffff/ffff/ffff> On Sat, 30 Jun 2018, David Gibson wrote:
> > On Fri, Jun 29, 2018 at 08:06:10PM +0200, Sebastian Bauer wrote:
> > > Hi,
> > >=20
> > > Am 2018-06-19 06:36, schrieb David Gibson:
> > > > Ok.  However, your patch doesn't apply against the ppc-for-3.0 tree.
> > > > It looks like you've made it against a tree including some of BALAT=
ON
> > > > Zoltan's proposed but not yet merged patches.
> > > >=20
> > > > Please make sure your patches are against the current ppc-for-3.0 t=
ree
> > > > before posting.
> > >=20
> > > The patch seems to apply now to ppc-for-3.0 without any problem as Zo=
ltan's
> > > changes have been integrated. Let me know if I shall resend the patch=
 or if
> > > you can use the original one. Thanks.
> >=20
> > Resend please.  Assuming it would need a respin, I didn't keep it
> > around.
>=20
> Still avalilable here:
>=20
> http://patchwork.ozlabs.org/patch/931209/
>=20
> or here
>=20
> http://patchew.org/QEMU/20180618215601.8974-1-mail@sebastianbauer.info/

Ok, applied.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WVXkb2QE2eH0aWe4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls5o90ACgkQbDjKyiDZ
s5I+BRAAq2MY+0lQ7uuPbAB3ZMNDsLjKU8txRzJQiwTpmyjtEA1vohQKNFVVoO3p
BgOxGmqUbJYLADqeNHhNSEmzwGkNQ/9eGy6PgoDm+THjVqMTDE/NR5rMUb1Ia/Y9
QWbrKmNqmx403ChHsvXmbNKkcyAP8FDbG1sPmaQ0+vfhSTdks28o2ms8Zdibffid
2zE8VOazK0ztrhO9nXOx88ZXv+Y9Ps/3tHiDMCtSjNItJ4V7VpzgN/DpTTQfxjbT
bbX1MsxHqXYvDu2HbOMuPfm2UHlxoCHOfsB8G+mzIfzWfVJr1ng5RLA6eVwKUYWz
1ZShMJMwENsDMFFCH8oQr+sEbnYCyPKXsZFqncFywfvX8f8LMeRvDzs4sZeCzuGQ
GeuDkNgHo0sJu/rFRUVC3Xb4afg5HSjcgL+rwglOyPmK33ElZqv3U7x5T7xOaTIK
+u4KlxmjwRObI1Zf+O1TvhV39Ob+cwdoo1KjGSjin/idu2v/9r3xtp/twize/KTb
pRFMgcE0ZvGP2RVkiOJgIF3X7NGhcu8XRS0963S8dHSi3hX2uonAf2B3j2REDIEz
Y8cXkuqrOuBDsIFbea5s6Bbo3rvHnzA+63TpBm8uPq/I/yeK9FkrR4nmTxeiml7m
ITNUg66jWvc9CT8TPBoWPB2/d28f5LQ5Ia3uKr6sS83FDEc1RpY=
=DzJJ
-----END PGP SIGNATURE-----

--WVXkb2QE2eH0aWe4--
