Received: from eggs.gnu.org ([2001:4830:134:3::10]:50967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKFQM-0007kD-1a
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 23:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKFQK-0005Hd-33
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 23:26:37 -0500
Date: Wed, 7 Nov 2018 15:25:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181107042520.GC5575@umbus.fritz.box>
References: <20181030093531.18587-1-agraf@suse.de>
	<655b9090-bb99-2255-5020-d2da2a404bfc@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline
In-Reply-To: <655b9090-bb99-2255-5020-d2da2a404bfc@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: PPC: Remove myself
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 30, 2018 at 02:34:46PM +0000, Mark Cave-Ayland wrote:
> On 30/10/2018 09:35, Alexander Graf wrote:
>=20
> > I haven't really been maintaining any PowerPC code for quite a while no=
w,
> > so let's reflect reality: David does all the work and embedded PPC is in
> > "Odd Fixes" state rather than supported now.
>=20
> It was a pleasure working with you, but of course life moves
> on... :)

[snip]
> >  New World
> > -M: Alexander Graf <agraf@suse.de>
> > +M: David Gibson <david@gibson.dropbear.id.au>
> >  L: qemu-ppc@nongnu.org
> > -S: Maintained
> > +S: Odd Fixes
>=20
> There was actually a patch floating around to add myself to MAINTAINERS f=
or the New
> World and Old World machines, but I think it got lost when trying to set =
up a
> sub-maintainer queue with David. I'm happy to look after these
> machines for now.

Yeah, it did.  Still need to sort that out...

>=20
> >  F: hw/ppc/mac_newworld.c
> >  F: hw/pci-host/uninorth.c
> >  F: hw/pci-bridge/dec.[hc]
> > @@ -823,9 +822,9 @@ F: include/hw/misc/mos6522.h
> >  F: include/hw/ppc/mac_dbdma.h
> > =20
> >  Old World
> > -M: Alexander Graf <agraf@suse.de>
> > +M: David Gibson <david@gibson.dropbear.id.au>
> >  L: qemu-ppc@nongnu.org
> > -S: Maintained
> > +S: Odd Fixes
> >  F: hw/ppc/mac_oldworld.c
> >  F: hw/pci-host/grackle.c
> >  F: hw/misc/macio/
> > @@ -850,7 +849,6 @@ F: pc-bios/ppc_rom.bin
> > =20
> >  sPAPR
> >  M: David Gibson <david@gibson.dropbear.id.au>
> > -M: Alexander Graf <agraf@suse.de>
> >  L: qemu-ppc@nongnu.org
> >  S: Supported
> >  F: hw/*/spapr*
> > @@ -1117,7 +1115,7 @@ F: tests/bios-tables-test.c
> >  F: tests/acpi-utils.[hc]
> > =20
> >  ppc4xx
> > -M: Alexander Graf <agraf@suse.de>
> > +M: David Gibson <david@gibson.dropbear.id.au>
> >  L: qemu-ppc@nongnu.org
> >  S: Odd Fixes
> >  F: hw/ppc/ppc4*.c
> > @@ -1126,9 +1124,9 @@ F: include/hw/ppc/ppc4xx.h
> >  F: include/hw/i2c/ppc4xx_i2c.h
> > =20
> >  ppce500
> > -M: Alexander Graf <agraf@suse.de>
> > +M: David Gibson <david@gibson.dropbear.id.au>
> >  L: qemu-ppc@nongnu.org
> > -S: Supported
> > +S: Odd Fixes
> >  F: hw/ppc/e500*
> >  F: hw/pci-host/ppce500.c
> >  F: hw/net/fsl_etsec/
>=20
>=20
> ATB,
>=20
> Mark.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlviaTAACgkQbDjKyiDZ
s5IZQA//atU1lTJM/c8IlQE1IC5/UUuZe1cOoTIt1tMP2TScGOT9ylfOFCe6sMaU
kVLx2ixZexFFSPmj0Y+aTqaTDlwq+KqwhDKLUYU3puhVdD7kj865+qKg92owv74k
30Qv+0L1hiooQXG6zztPD+9whchfAFEyEOC7zCVMYm+ltZehCS+i4NQVZDjIz+ZU
SMRUhoqMyOJ7OlXNN+Kot9MXVqAPCd9/vpDwQna64RYBrUhbuAPXaPB2hbQqGl5D
CMkhhYOJz8qReXS/G0fc0fIKOE5uzVn6kBST8jvM1f4S9j/Y0ru0/nTh3YDj9X6c
OHU3CvW9WpZ2gyEF1pYBRInOox6hx0GvgaN7KrXlVxthcCEXlnSXUXmWdhurcGAJ
XtQwWhcKos7YBO/3Kb6DLeOq/WHT0d7vYw/AYfk9ay8kgb1rj7Rj26X5rhJi1FQk
VR2yILEXRLGy9MxW4WLJZS9wdGzCS6IKUIlM92LiESmWMEeLs2IZPE4deQogafcg
kSedhbe53zr5DOMvqNycNZPab5+8kx86dhv0Ts/yZZF+d+JSIEiBaitAn11iXnM+
L0M0i4EAoqJW6/tB4cNcdKleIeD6K/T6wwK5W61Zp+yBJO/dSPe1KH+0Si81Fobu
TgY8euqkBQt7Mu/62NPWQvWWbgfNIGZZ2ueOXHnXsin9wxWiuHg=
=dM7M
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--
