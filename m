Received: from eggs.gnu.org ([2001:4830:134:3::10]:55066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMMqw-0006ew-Th
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 18:42:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMMqv-0003p1-MW
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 18:42:18 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:60733)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eMMqu-0003o5-Ux
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 18:42:17 -0500
Date: Wed, 6 Dec 2017 10:14:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171205231427.GO3057@umbus.fritz.box>
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<151194617493.816.13426298875361921541@bafd83ae6430>
	<20171129091847.GC12220@lemon>
	<20171205064753-mutt-send-email-mst@kernel.org>
	<20171205050558.GA31705@lemon>
	<20171205051151.GF3057@umbus.fritz.box>
	<20171205064635.GB31705@lemon>
	<20171205130636.GN3057@umbus.fritz.box>
	<20171205134207.GD31705@lemon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2/+Vq7w28QOSGzSM"
Content-Disposition: inline
In-Reply-To: <20171205134207.GD31705@lemon>
Subject: Re: [Qemu-devel] [for-2.12 0/7] PCI cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, marcel@redhat.com, imammedo@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com


--2/+Vq7w28QOSGzSM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 09:42:07PM +0800, Fam Zheng wrote:
> On Wed, 12/06 00:06, David Gibson wrote:
> > > > Another approach would be to have a "known good" build that runs ev=
ery
> > > > so often.  If the known good build fails, the bot disables itself (=
and
> > > > tells you to investigate).  Obviously there are ways that could not
> > > > work as well, but it should catch a fair range of spurious failures.
> > >=20
> > > Interesting idea, yes. A slightly simplified way is to test the "base=
" of the
> > > series and only report errors if the base can pass.
> >=20
> > Right.  I think that would catch even more cases, but means doing the
> > "base" build every time, which might slow things down significantly.
>=20
> Every time when a test on topic branch failed, but not necessarily when it
> passed, which is not that bad.

True.  Sounds promising.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2/+Vq7w28QOSGzSM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlonKFMACgkQbDjKyiDZ
s5IeZg//dkHnIdbClC088TupTVC5VU1troQGF8QKtzUmSW9qJt4m1zEICwYomZE+
2UIkHYSgTNoZviaVgcCADuIh/NJT04OKFSY77yx+GeEV6qPmFt9ONx3IriOxTMvu
u7sZmSBJnpnVk1J8cM4OxrLJJ/zNtYk2P+IN9ffckY18bp/MJQ8Qbo3xgRC0iSZU
7F+MZp5ir8t2z312Elbg9Yc6ggz2V3bYb7EO/B6s/siUg7Rl2MvfTguYOxQdvWoG
Qf9Hsl3EfU1h3JyUyAL/ajYHVhrk2J7wrmHnKkKjvCEfYt/BViWe0PBQCM5irZrr
RFABWRVgGW0uK4KknnmQ6WMZfSM0sy747g9q12/DRvnD/N3oyMu+wO5VSo5OFn59
TLxCrNNIX2vDgyMUHOa+Tsjdp3MJZNXdt7XF3Y15RLAVN8075gXFbVwVN1nvf6Qw
cl2PN2pWcx/L51p8ANTa7u7I4KWMbk0EFPtoS6c55BSxuUmmyLNeYplSDEerB8zE
ALAbHwErPutEdn2P2ZZpbmb0vo3INKcAY314CsbVXmWPtIdp+YfOBg1HC/KcR1Bd
dB+ztgafaHMLrJS43ejZ+HC3XcMuOQ0w5bL6g2cI5LcrEXj52f3ISNGElpZVC+/P
e+gqu9azs3rcfvxqgC3URQ0Jx68plQOgXNtxJ3wfgYEHYJkrSo0=
=FTWk
-----END PGP SIGNATURE-----

--2/+Vq7w28QOSGzSM--
