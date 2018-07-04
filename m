Received: from eggs.gnu.org ([2001:4830:134:3::10]:33702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faWpZ-0006Fb-UL
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 21:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faWpW-0004EF-Sc
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 21:43:42 -0400
Date: Wed, 4 Jul 2018 11:30:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180704013054.GC14043@umbus.fritz.box>
References: <73dd5b26b622e6c59776976aa2c7a3a0@sebastianbauer.info>
	<20180619043631.GC11674@umbus.fritz.box>
	<607559ef0fd95f557b5001a5db29883f@sebastianbauer.info>
	<20180630061443.GP3422@umbus.fritz.box>
	<alpine.BSF.2.21.1806301325320.13465@zero.eik.bme.hu>
	<20180702040239.GS3422@umbus.fritz.box>
	<20180702052202.GY3422@umbus.fritz.box>
	<2fdb7495b7979040f40a361d78d35d85@sebastianbauer.info>
	<20180703044136.GN3422@umbus.fritz.box>
	<dbac814a-62bd-d46a-8d7c-b070cc307c87@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
In-Reply-To: <dbac814a-62bd-d46a-8d7c-b070cc307c87@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: Sebastian Bauer <mail@sebastianbauer.info>, BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, thuth@redhat.com, qemu-ppc@nongnu.org


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 10:20:41AM -0500, Eric Blake wrote:
> On 07/02/2018 11:41 PM, David Gibson wrote:
>=20
> > That's a good point.  At the moment there's really nothing there about
> > testing your patch before submission, which is a bit of an ommission.
> >=20
> > [1] covers a bunch of ways that qemu can be tested, but doesn't give
> > much idea about priority.
> >=20
> > +eblake, you seem to have made more mods than anyone else to the
> > SubmitAPatch wiki page.  What do you think about adding a subsection
> > about what basic testing you should do before posting a patch?
>=20
> No good deed goes unpunished :)

Heh.  I was just asking if you had any input, not requesting that you
make the change..

> I've added https://wiki.qemu.org/Contribute/SubmitAPatch#Test_your_patches

=2E.but thanks!

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls8I04ACgkQbDjKyiDZ
s5LSiw//aN8hQr6iwv8Ij/iH829JpcbqK9p1vhvEWgmnsdznAro0jK5vEGiTP8cg
0h1ai1jE8CqNNfL7ULDFh6p0KLfnTAW6UtnMegD+5ZLgxwHc4s27NeahwZ4VQ/3E
YoXX6y5bQhHH4CFYqgiulnjFU8EFGgYGBOtlOd4YudOhRU+xailnB4N37e4UUgGn
QmmjOpl/UzjWh/lstN+nFN3Z9R5H1bnf/NuuBrclkUoS8L2B6In1MX5ityRJ5Aq5
omNwa8magLGgv5LPCrna7bs15c57JnVgbefG2I2ZSuiVnE4q0tqy3ckbfPi9qdWI
wtQ2YVu8nC3JpqPWMQ8gMnmrNx52VYav9gBDCtid4qERfHkoUb8CuUQgBEGoVC81
01y+lRHnnZUeDIURVzLK9VZyJEMpta3VTdnRMF6R9hWzNtSv/i87s0rugnTC7CS2
Gco40Et1Fw2AXdX7ToHnm4RigticRMRFpJXsV6kcxs/dzL6p40ifpg62A1ccMysK
aI7fDOAMrrQF/0IJBVspjekETstokg9dY0jWgUwGO5k5pjIWRhxR09ZGiXmpX8u2
4O5VGW1oeYne8d72N6z5IDI5ST2ZKVGKR3+PmU+OnNC7P8N/kGPnK+CQl+RlJILW
Kzc7R3h867YS07AiKFLWbe5CPZ+l9rao5Pp0GCjTdgQyXvjFMsc=
=kTFw
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
