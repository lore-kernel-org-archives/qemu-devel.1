Received: from eggs.gnu.org ([2001:4830:134:3::10]:50615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fZtow-0002xs-PU
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 04:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fZtov-0001Dm-RB
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 04:04:26 -0400
Date: Mon, 2 Jul 2018 10:04:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180702080411.GA4299@localhost.localdomain>
References: <20180615142108.27814-1-kwolf@redhat.com>
	<20180615142108.27814-26-kwolf@redhat.com>
	<7a310b92-f8cb-b68b-d882-9b2959794347@de.ibm.com>
	<20180622125502.GF4366@localhost.localdomain>
	<ea6a2d92-8f69-d02e-e62b-0e71ed5e25f2@de.ibm.com>
	<20180622142513.GH4366@localhost.localdomain>
	<20180622143146.GQ23296@redhat.com>
	<20180625095322.GC18580@redhat.com>
	<20180625114106.GJ5024@localhost.localdomain>
	<20180625114528.GL16514@angien.pipo.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <20180625114528.GL16514@angien.pipo.sk>
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 25.06.2018 um 13:45 hat Peter Krempa geschrieben:
> On Mon, Jun 25, 2018 at 13:41:06 +0200, Kevin Wolf wrote:
> > Am 25.06.2018 um 11:53 hat Daniel P. Berrang=E9 geschrieben:
> > > On Fri, Jun 22, 2018 at 03:31:46PM +0100, Daniel P. Berrang=E9 wrote:
> > > > On Fri, Jun 22, 2018 at 04:25:13PM +0200, Kevin Wolf wrote:
> > > > > Am 22.06.2018 um 15:36 hat Christian Borntraeger geschrieben:
>=20
> [...]
>=20
> >=20
> > Thanks!
> >=20
> > I'll look into werror/rerror support for usb-storage. It shouldn't be
> > too hard, though it's strictly speaking a separate problem related to
> > using -blockdev rather than option deprecation.
> >=20
> > If Peter wants to wait for QEMU support before converting werror/rerror
>=20
> Definitely. I don't want to keep around yet another hack that will
> satisfy one specific case and then add another capability for it. We
> should then gate the moving of the feature based on the presence of
> werror for usb-storage.
>=20
> > to -device, maybe it would make sense to split your patch for v2 so that
> > geometry and serial can get fixed right away?
>=20
> Yes this can be done right away.

Has serial/gemoetry been fixed meanwhile and will it make it into the
next release?

Kevin

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbOdx7AAoJEH8JsnLIjy/WoMwP/0LBF4t2iB1+8wK9uco62pc7
o3znnAaoJhi2ihIzFaxx325lZVYVzIhF3ak73fJTksPQ8O9eOj6/SmoWNSwO3GYD
RNEfpEtfAlyF1tAFAoMMsO0KKrFANTjOuSIMvNxMW7AnvsxbqJi/MdsOqH2XCkLy
QU0sZ/bBY8kI2GhjOR68/9UcYWnv9EVPTUqy+HjcF2Xg3o38awaX/lOJhHM3qxbB
83Ji1ZvP2Sn7+Q9ou5mJ9lk2inuA7vGZmsWa20gKgMOAHrjWV1PePui2nDZk8Hbg
/UMbMsT4WMjOAJ0SnxVOzcaHubbrlHD4l930t19efFwaCQ6qYA+yXw2EqwREPulO
KJzqxiQbr0tJHhcTefLg/4pBP3tIyEn+V/BnMoREaS1OERSmrO2yqpZuBVYla8H0
4qWH18HC9Has6p1qg2inke7lwmgNqjsVg1uZVykbIgBKUG+Zj/mUlnjH8bLrBJIQ
O431XBdSOVeNexCtVhyHNaNVCSd2e04hSpse+XDLiol+U2s6bEkmfGg0UTbdjT3n
/QgzbXLEJwRqCDRzHqf5DZ0ZZASLCWoVhHFoVnbESpq5aMDNfD5fzf03EWiZ5VO6
qiNm51/VuFFHFySsYPAf5a+nNL3mUCwR1xoAzuNNSMnjj4gdPvevNzw3OYCxXBxS
Bk9yLS0mJhpbLVXLaLGT
=Uhx4
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
