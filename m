Received: from eggs.gnu.org ([2001:4830:134:3::10]:54045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcmRX-0001t1-N6
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcmRW-0004yJ-BY
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:48:11 -0400
Date: Tue, 10 Jul 2018 16:42:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180710064248.GM22363@umbus.fritz.box>
References: <20180702062644.48040-1-aik@ozlabs.ru>
	<20180710122244.7466489f@aik.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3FyYKcuUbgqNYeqV"
Content-Disposition: inline
In-Reply-To: <20180710122244.7466489f@aik.ozlabs.ibm.com>
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


--3FyYKcuUbgqNYeqV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 10, 2018 at 12:22:44PM +1000, Alexey Kardashevskiy wrote:
> On Mon,  2 Jul 2018 16:26:44 +1000
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
> > The following changes since commit edb1fb337f65f82fe32b989c4f018efe85c1=
dddb:
> >=20
> >   pseries: Update SLOF firmware image (2018-07-02 16:21:30 +1000)
> >=20
> > are available in the git repository at:
> >=20
> >   git@github.com:aik/qemu.git tags/qemu-slof-20180702
> >=20
> > for you to fetch changes up to edb1fb337f65f82fe32b989c4f018efe85c1dddb:
> >=20
> >   pseries: Update SLOF firmware image (2018-07-02 16:21:30 +1000)
> >=20
> > ----------------------------------------------------------------
> >=20
> > I just missed a couple of gcc 8.1 fixes and thought I can still squeeze
> > them before the 3.0  soft freeze.
> >=20
> >=20
> > *** Note: this is not for master, this is for pseries
>=20
>=20
> Not good for 3.1 either?

Ugh.. somehow I missed this SLOF update request, and now we're in 3.0
hard freeze.

How bad are the bugs this SLOF update fixes?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3FyYKcuUbgqNYeqV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltEVWUACgkQbDjKyiDZ
s5I79hAAiDEzPxfbKQhjDqxzW/0mz3AJPte5QzMCiHZoKEo6QNmtNX+wb59exaEs
T+lNsK2Zo6gCXHBvWo0N69Ug1e+hVyhyG9sQqQURFL+T55M+qOspIgS5x3bsByYW
7wIqU/ZA0+lX4khsrmDy908ihy4DEmbxTP+0gzAoJII5lqYB/yHkaRWJp1N7/LM8
vTp59HwrR+/3ue6KuEH5zke26Q500q9jgdBvzbsxkQD3klo/DMLx09jamApP2bnt
W20LV4oizu7jDMJnkwr6iiD27LxtSuYeO+GacEaJY/lLYh5DVoIx48HOYQSeqjDt
8UJVEc942NpBsiu0PPKQr/b/xjLml86p8BueE8u+15c2Xsj8hxgNPxCnfV9YZ01B
wxY0y2+ByFnCxKAhmDJCyaisxuKe6H7qM++wmeFOS/Qm4eJxGPE4GijDZBlVes9h
FY71Cx6c2bQ263YNyQ1U1kyJqbIxfnbeDK3tqj5laGIHDVkJTImr03BMyV1Ca/bx
vkeq2uszI9zCPZ5i3jokNc35uLKp+/oErxdyaGvj3f3lTE++EvFJdJsbTMQyiCzV
40GSuYGcFVANIeDU+Tx2ctSi7twknwzozhaqOn7xKK6kwaqUfQBipFACF0rR8mwM
6NaepFVdipdhdhUvpZwvcCzLY1Wy3OBkY3iQWn3HIrgn7Tq+Me8=
=LEXq
-----END PGP SIGNATURE-----

--3FyYKcuUbgqNYeqV--
