Received: from eggs.gnu.org ([2001:4830:134:3::10]:57379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faD8Q-0007I3-Jn
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 00:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faD8M-0005rg-Ge
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 00:41:50 -0400
Date: Tue, 3 Jul 2018 14:41:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180703044136.GN3422@umbus.fritz.box>
References: <20180618215601.8974-1-mail@sebastianbauer.info>
	<20180618235557.GB25461@umbus.fritz.box>
	<73dd5b26b622e6c59776976aa2c7a3a0@sebastianbauer.info>
	<20180619043631.GC11674@umbus.fritz.box>
	<607559ef0fd95f557b5001a5db29883f@sebastianbauer.info>
	<20180630061443.GP3422@umbus.fritz.box>
	<alpine.BSF.2.21.1806301325320.13465@zero.eik.bme.hu>
	<20180702040239.GS3422@umbus.fritz.box>
	<20180702052202.GY3422@umbus.fritz.box>
	<2fdb7495b7979040f40a361d78d35d85@sebastianbauer.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vH3HHxf962mwD/qo"
Content-Disposition: inline
In-Reply-To: <2fdb7495b7979040f40a361d78d35d85@sebastianbauer.info>
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
To: Sebastian Bauer <mail@sebastianbauer.info>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, thuth@redhat.com, qemu-ppc@nongnu.org, eblake@redhat.com


--vH3HHxf962mwD/qo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 09:42:49AM +0200, Sebastian Bauer wrote:
> Am 2018-07-02 07:22, schrieb David Gibson:
> > And now unapplied, since it breaks make check all over the place for
> > ppc64-softmmu.
> >=20
> > Please folks, running an all-targets make check is really the
> > *minimum* bar for testing before posting a patch for inclusion.
>=20
> Okay, will do next time. Sorry for the inconvenience.
>=20
> But I can't find anything about this procedure in the Wiki. Maybe it would
> be a good idea to add this info for people that are new, or if it is writ=
ten
> somewhere it should be linked from here:
> https://wiki.qemu.org/Contribute/SubmitAPatch as this is most likely the
> starting point for new contributors.

That's a good point.  At the moment there's really nothing there about
testing your patch before submission, which is a bit of an ommission.

[1] covers a bunch of ways that qemu can be tested, but doesn't give
much idea about priority.

+eblake, you seem to have made more mods than anyone else to the
SubmitAPatch wiki page.  What do you think about adding a subsection
about what basic testing you should do before posting a patch?

[1] https://wiki.qemu.org/Testing

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vH3HHxf962mwD/qo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls6/oAACgkQbDjKyiDZ
s5KOKRAAxjXjmmRlDOz0B5jDx0nL/rkeMH9hSF2xw7q5/iCrSdqZOFihzXxvcMe2
pZVvGeKs2XWLUGBxBka8ekUYzC9JjisEGzn5gwXtI02fppSK7y29iHeIfkd/xJg+
G6sdNGts8IZbM3wuuanO4MPC91IGCq8POCWZOV8lOUj0DO+KfTayE1Hb63EcioiG
x9GOQ1lpzSdWUlaAOwNnt8Tsj+pSQBUGRfRQuLxvZuG2hTygntd8gK22jNrXbmoD
lzaD7cECBJScWF2WILk+yx57fuznBk9bgjVwx+U/vcmKvJeDzDH4BaN2xCeC67/X
1f4Kz6wAeqZZoRRMOc1Fb6djDvr8yIUP6ys4siaQBX7nmZA0uHxLy62+Pk4UUs2g
2o1nlxb6MyvmZ4Gfns/VRqT4zWM7QzAxZrkjYOlWS9rIH1EcnD8ykauI70yvDVam
YzyOAdeqxGO4uDtib49DeRq3IxDar72S1gh+4vai3X0VgcKSy8/y1GH2nGLRmFxf
eUTz7ZW8LTB4tmqYU/NC+a/LhSzYQWOku2Wx3fGQ6jAFGNAQynxPO72hLgNqkY9O
nObK80qUFLOo8+1nTM93lCeYcWHPjJG6QYDcN3P5AM1WvVha8Y0m1II8vmCWhQ0x
8MT0OuQyTzp7luT1Tu9ncXjXhZnKvN5xZ1EtkhoO+r28atE5m0M=
=j1XR
-----END PGP SIGNATURE-----

--vH3HHxf962mwD/qo--
