Received: from eggs.gnu.org ([2001:4830:134:3::10]:44560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fdQPc-0002Ce-0k
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 21:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fdQPY-0002qn-5K
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 21:28:52 -0400
Date: Thu, 12 Jul 2018 11:01:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180712010152.GR22363@umbus.fritz.box>
References: <20180702062644.48040-1-aik@ozlabs.ru>
	<20180710122244.7466489f@aik.ozlabs.ibm.com>
	<20180710064248.GM22363@umbus.fritz.box>
	<20180710171453.6e3eee34@aik.ozlabs.ibm.com>
	<20180711062619.GQ22363@umbus.fritz.box>
	<20180711205305.0f3a42f1@aik.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PY8tzLeNxmyMVNR3"
Content-Disposition: inline
In-Reply-To: <20180711205305.0f3a42f1@aik.ozlabs.ibm.com>
Subject: Re: [Qemu-devel] [GIT PULL for qemu-pseries] pseries: Update SLOF
 firmware image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--PY8tzLeNxmyMVNR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 11, 2018 at 08:53:05PM +1000, Alexey Kardashevskiy wrote:
> On Wed, 11 Jul 2018 16:26:19 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Jul 10, 2018 at 05:14:53PM +1000, Alexey Kardashevskiy wrote:
> > > On Tue, 10 Jul 2018 16:42:48 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > On Tue, Jul 10, 2018 at 12:22:44PM +1000, Alexey Kardashevskiy wrot=
e: =20
> > > > > On Mon,  2 Jul 2018 16:26:44 +1000
> > > > > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> > > > >    =20
> > > > > > The following changes since commit edb1fb337f65f82fe32b989c4f01=
8efe85c1dddb:
> > > > > >=20
> > > > > >   pseries: Update SLOF firmware image (2018-07-02 16:21:30 +100=
0)
> > > > > >=20
> > > > > > are available in the git repository at:
> > > > > >=20
> > > > > >   git@github.com:aik/qemu.git tags/qemu-slof-20180702
> > > > > >=20
> > > > > > for you to fetch changes up to edb1fb337f65f82fe32b989c4f018efe=
85c1dddb:
> > > > > >=20
> > > > > >   pseries: Update SLOF firmware image (2018-07-02 16:21:30 +100=
0)
> > > > > >=20
> > > > > > ----------------------------------------------------------------
> > > > > >=20
> > > > > > I just missed a couple of gcc 8.1 fixes and thought I can still=
 squeeze
> > > > > > them before the 3.0  soft freeze.
> > > > > >=20
> > > > > >=20
> > > > > > *** Note: this is not for master, this is for pseries   =20
> > > > >=20
> > > > >=20
> > > > > Not good for 3.1 either?   =20
> > > >=20
> > > > Ugh.. somehow I missed this SLOF update request, and now we're in 3=
=2E0
> > > > hard freeze.
> > > >=20
> > > > How bad are the bugs this SLOF update fixes? =20
> > >=20
> > > These only fix gcc 8.1 warnings and runtime errors =3D> not really
> > > bugfixes so it is not a big deal if they miss 3.0. =20
> >=20
> > Ok, well, if you want to resend the update, I'll queue it for 3.1.
>=20
>=20
> It is still on github, why resend?

Good point, done.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PY8tzLeNxmyMVNR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltGqH4ACgkQbDjKyiDZ
s5Kz7g//X4333v1g3A/gUt7HMmGfQQTHYJ5IqYcjelekGZfTXXB2x+msUbeZ0oTp
H9ef6oESq7536HezDu7geosHRUSrID1UNlKJrdx4PykRG7h3C9EfMA6zY1Yzt7vy
W17Qf8roE58QBevmkKpGBCRLGtC2qmLozVNzQYVfqtIrWPf/zQEmubQpcsBct49p
41bn8zgqbjcCpcZTUTI/XbX8jLU19vp9OJFXERdRtARkQ97dE6M4Mq1Iw2Tx41pq
pl3a9va+uoJRAEkuSE+s0AatYvJMnfTxuZ7FnCt11VV3S8+g5cZCF1Qcy2YTEaWs
ckhpdTni4G+IXo8N9HaABpn8sBVzm3Fl6WEOUJL85FhuVyRo6dyO3njA7LM6Xz/d
DdvhSx0YBOlIHMycNMZIu0tYjBPQjNRruzOtr5+gKHg/c+JVNi9XCH+qoIPSc6mI
/33Mp3eKb5hwk+SgqwhjQhEIEkkwvPz+g60BZ92dHp2b2QKrskAcpYArD7NY8JpN
cOufAOXhbZg8S8JG2Po6ZnZTtkTArCWFHmPn5o6AqKtp36rtDGm5KKozDcoqTLmt
irAJfMdmM/X68wHlGz84dK/nOFyWTq4x66MPVem0C2WP9XXArrQLOFlxEU/aMBdf
bLwbK+Omev8n+sO9Skrj+K+4guzS5SYgYir3O1zIWS/3Yu4SQw4=
=BznU
-----END PGP SIGNATURE-----

--PY8tzLeNxmyMVNR3--
