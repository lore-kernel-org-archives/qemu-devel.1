Received: from eggs.gnu.org ([2001:4830:134:3::10]:60769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fd8aH-0001E7-SF
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 02:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fd8aE-0008Cg-2a
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 02:26:41 -0400
Date: Wed, 11 Jul 2018 16:26:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180711062619.GQ22363@umbus.fritz.box>
References: <20180702062644.48040-1-aik@ozlabs.ru>
	<20180710122244.7466489f@aik.ozlabs.ibm.com>
	<20180710064248.GM22363@umbus.fritz.box>
	<20180710171453.6e3eee34@aik.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wr1Q/2bz0MCWWNYv"
Content-Disposition: inline
In-Reply-To: <20180710171453.6e3eee34@aik.ozlabs.ibm.com>
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


--wr1Q/2bz0MCWWNYv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 10, 2018 at 05:14:53PM +1000, Alexey Kardashevskiy wrote:
> On Tue, 10 Jul 2018 16:42:48 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Jul 10, 2018 at 12:22:44PM +1000, Alexey Kardashevskiy wrote:
> > > On Mon,  2 Jul 2018 16:26:44 +1000
> > > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> > >  =20
> > > > The following changes since commit edb1fb337f65f82fe32b989c4f018efe=
85c1dddb:
> > > >=20
> > > >   pseries: Update SLOF firmware image (2018-07-02 16:21:30 +1000)
> > > >=20
> > > > are available in the git repository at:
> > > >=20
> > > >   git@github.com:aik/qemu.git tags/qemu-slof-20180702
> > > >=20
> > > > for you to fetch changes up to edb1fb337f65f82fe32b989c4f018efe85c1=
dddb:
> > > >=20
> > > >   pseries: Update SLOF firmware image (2018-07-02 16:21:30 +1000)
> > > >=20
> > > > ----------------------------------------------------------------
> > > >=20
> > > > I just missed a couple of gcc 8.1 fixes and thought I can still squ=
eeze
> > > > them before the 3.0  soft freeze.
> > > >=20
> > > >=20
> > > > *** Note: this is not for master, this is for pseries =20
> > >=20
> > >=20
> > > Not good for 3.1 either? =20
> >=20
> > Ugh.. somehow I missed this SLOF update request, and now we're in 3.0
> > hard freeze.
> >=20
> > How bad are the bugs this SLOF update fixes?
>=20
> These only fix gcc 8.1 warnings and runtime errors =3D> not really
> bugfixes so it is not a big deal if they miss 3.0.

Ok, well, if you want to resend the update, I'll queue it for 3.1.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wr1Q/2bz0MCWWNYv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltFowsACgkQbDjKyiDZ
s5JhPBAAmop+/MDwcl9HWHJDs17fh9BF0BO47yHdB+q1+j4k35m6B5Sc9tm1J0qI
gaqZtml4Fm8IPCPRdCf1LG19LkDQtuTy0u7RNj58HaNTqWw2tympEi2tev43KakM
I/yw+WkCk9cG+qUNI82ce6O1KGooLE0psobJMMFGz0NwFgszPP1XV5B21bw1l/Av
HsDcTJ+/KVFmWgAVGF1K6iFZRUDIgXt32MobZjyn7Tsek8nssLi/Oi+8mOEOiOdh
W1nTkm/Nnb+2Sl8hUO/0vPNOmr7hEpWFFAevWgEa7XDW3uhUKSuazGJKscnX9o5z
8DDXDhm4X4fe3EvVmpL8fGN6eh7oM2wMWnzGs47lZV9xEmE2ESVMaDUuzIPlPzt/
K1zI7JSu6bFJZZBzzWtKLE1IcaNjsdmrRQ9uAOZ8LI9TjhnNNG+xzcInB/2TdAna
2hR/wgQfOpEo1pDCtv8u2hVcalbo9WIdB2lFPy/P1OVbwOjG8avXThLIDGPnk13V
UjeCBaHC+faftUZoaxq7zNC0DVi/M1ZlOZQMGUirmpZOaZARssX4kY/Io12tzKr0
uewamnLHwDW9Z2ZBwi8l6ucFIsjDy/LVcnEcoiGk3UqpQ1PdXlYO1D1jFD4wBJuD
FfHZPTsd8ZwofT/0nzMq/E8sPe8c2lNnR3qNoMdiMeinS1lvObc=
=Z/7A
-----END PGP SIGNATURE-----

--wr1Q/2bz0MCWWNYv--
