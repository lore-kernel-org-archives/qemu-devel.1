Received: from eggs.gnu.org ([2001:4830:134:3::10]:53578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ch2ix-0003dY-8i
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 18:23:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ch2iv-0005t2-W6
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 18:22:59 -0500
Date: Fri, 24 Feb 2017 09:57:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223225719.GF17615@umbus.fritz.box>
References: <20170105054618.GA12106@umbus.fritz.box>
	<20170106125758.4643fb35@bahia.lan>
	<20170112035219.GK14026@umbus.fritz.box>
	<0bfaa82a-d5f5-eb0f-14a9-f7d13239cee5@ozlabs.ru>
	<20170112100823.2a906117@bahia.lan>
	<20170113044831.GP13656@umbus.fritz.box>
	<20170113095828.302b77f2@bahia.lan>
	<20170222120825.0253f2d6@bahia.lan>
	<20170223021152.GR12577@umbus.fritz.box>
	<20170223082350.4c118d7e@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m1UC1K4AOz1Ywdkx"
Content-Disposition: inline
In-Reply-To: <20170223082350.4c118d7e@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] Proposal PCI/PCIe device placement on
 PAPR guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org, abologna@redhat.com, mdroth@linux.vnet.ibm.com, libvir-list@redhat.com, qemu-ppc@nongnu.org, marcel@redhat.com


--m1UC1K4AOz1Ywdkx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2017 at 08:23:50AM +0100, Greg Kurz wrote:
> On Thu, 23 Feb 2017 13:11:52 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Feb 22, 2017 at 12:08:25PM +0100, Greg Kurz wrote:
> > > David,
> > >=20
> > > I don't see the "spapr_pci: Allow PCI-Express devices" patch in your
> > > ppc-for-2.9 tree. Do you still consider merging it ? =20
> >=20
> > No.  After discussions with Marcel Apfelbaum and others I'm looking at
> > a different approach for PCIe support.
> >=20
>=20
> Oh, I had missed that... Is it the following thread ?
>=20
> https://lists.gnu.org/archive/html/qemu-ppc/2017-02/msg00203.html

That's the one.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--m1UC1K4AOz1Ywdkx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYr2jOAAoJEGw4ysog2bOSSagQAMWlnZ8mnNyTWXUD1Z9txmZN
EhNQNzQ9HuPfP+XjbVYPgAaPEPiDVkvChSa5kc+u0tTmY2i4kVPfbg1NXZ7FnqRd
tO//7anoZnwbC7BKC/Wo7B/I2Gf5eSlUTl+iXRyBIDXVcxC5KT/bLkVOxOT8Xnzn
Iy4GkEEVroObKVjToVuWs+ZpX49Okg0lhOSomPoV0x5BdN8YOHColXbWA6j1AfjL
25Hfs5Hx09toaZwXnrRK4PQkloFG6TbEJSSbO7wx727BXibbB0BA0fdPCNYMr1rV
WOvPFBn0bEsjs8d77clVp2sLsKxxIaqCwZEgjGOuyPzlaIadckKtIiLMEmPEGFFU
2k3ugTUSf2QgMXR6+Igu9J/N2O6w8+TLTnf2Hu8+B5sSNkFrgTCGLsTtLEcv0sjq
RE0gr2E+8SHsXCT503zAUfCF/KbRHlID88xxIwC0Z+xP58DPPojHTDcUqXyh5eyh
MoSRmB+g4zIPdnlvdgoWKTwekooIn3kn8vQ9iyjAyhtBORnqpfKX3vpK28yW2pMh
iD4nRuYZK/kAVhd1Ml57Mzc+UtzjfuGyGweGJ7t0xTQPAr7Q8CwLKCtQR1lIZ8oa
FPekU2SoD6h//xjdJueM/E1t2pmB2fmmPDrGQcZyfKq8uV1jRYAPn3paAkJxhVPD
ESL9zX5LPeS5K6pxcRtf
=0fcH
-----END PGP SIGNATURE-----

--m1UC1K4AOz1Ywdkx--
