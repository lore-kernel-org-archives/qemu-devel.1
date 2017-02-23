Received: from eggs.gnu.org ([2001:4830:134:3::10]:56574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cgnl4-0007jM-7m
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 02:24:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cgnkz-0000SL-CU
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 02:24:10 -0500
Received: from 17.mo6.mail-out.ovh.net ([46.105.36.150]:59306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cgnkz-0000S9-5t
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 02:24:05 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 46473B3AEE
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 08:24:02 +0100 (CET)
Date: Thu, 23 Feb 2017 08:23:50 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170223082350.4c118d7e@bahia.lan>
In-Reply-To: <20170223021152.GR12577@umbus.fritz.box>
References: <20170105054618.GA12106@umbus.fritz.box>
	<20170106125758.4643fb35@bahia.lan>
	<20170112035219.GK14026@umbus.fritz.box>
	<0bfaa82a-d5f5-eb0f-14a9-f7d13239cee5@ozlabs.ru>
	<20170112100823.2a906117@bahia.lan>
	<20170113044831.GP13656@umbus.fritz.box>
	<20170113095828.302b77f2@bahia.lan>
	<20170222120825.0253f2d6@bahia.lan>
	<20170223021152.GR12577@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/7SV1eatl.pthXeG5qav4v7I";
	protocol="application/pgp-signature"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org, abologna@redhat.com, mdroth@linux.vnet.ibm.com, libvir-list@redhat.com, qemu-ppc@nongnu.org, marcel@redhat.com

--Sig_/7SV1eatl.pthXeG5qav4v7I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Feb 2017 13:11:52 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Feb 22, 2017 at 12:08:25PM +0100, Greg Kurz wrote:
> > David,
> >=20
> > I don't see the "spapr_pci: Allow PCI-Express devices" patch in your
> > ppc-for-2.9 tree. Do you still consider merging it ? =20
>=20
> No.  After discussions with Marcel Apfelbaum and others I'm looking at
> a different approach for PCIe support.
>=20

Oh, I had missed that... Is it the following thread ?

https://lists.gnu.org/archive/html/qemu-ppc/2017-02/msg00203.html

--Sig_/7SV1eatl.pthXeG5qav4v7I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAliujgYACgkQAvw66wEB28LesgCghBoh4T5W2hx74FxXvxRUgnI7
7NsAnRkCt5Sfa4pNMXfLGrlVrvUTRtYm
=n0Wa
-----END PGP SIGNATURE-----

--Sig_/7SV1eatl.pthXeG5qav4v7I--
