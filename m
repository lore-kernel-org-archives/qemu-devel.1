Received: from eggs.gnu.org ([2001:4830:134:3::10]:34115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cfmC0-0003Bj-V4
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:31:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cfmBw-0000qH-VN
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:31:44 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cfmBw-0000q1-Pe
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:31:40 -0500
Received: by mail-wm0-x241.google.com with SMTP id r18so13827503wmd.3
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 03:31:40 -0800 (PST)
Date: Mon, 20 Feb 2017 11:31:37 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170220113137.GH21255@stefanha-x1.localdomain>
References: <CAJSP0QWX0_stkyrkyL42QFFnnBTaqYD+XYmpMBO0gY2pWFD53g@mail.gmail.com>
	<20170216154707.GE19045@localhost.localdomain>
	<20170216170702.GG8801@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzX0AQGjRQPusK/O"
Content-Disposition: inline
In-Reply-To: <20170216170702.GG8801@localhost.localdomain>
Subject: Re: [Qemu-devel] Missing rewrite rule for qemu.org/images/ links
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com


--NzX0AQGjRQPusK/O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2017 at 12:07:02PM -0500, Jeff Cody wrote:
> On Thu, Feb 16, 2017 at 10:47:07AM -0500, Jeff Cody wrote:
> > On Thu, Feb 16, 2017 at 03:30:25PM +0000, Stefan Hajnoczi wrote:
> > > Hi Jeff,
> > > The old qemu.org/images/ links are not being rewritten to
> > > wiki.qemu-project.org/images/.
> > >=20
> > > For example, http://www.qemu-project.org/images/4/4e/Q35.pdf no longe=
r works:
> > > https://bugs.launchpad.net/qemu/+bug/1665344
> > >=20
> > > I do notice that qemu.org/Features/Q35 is working.  Is it possible to
> > > set up a rewrite rule or HTTP redirect so existing /images/ links keep
> > > working?
> > >=20
> > > Thanks,
> > > Stefan
> >=20
> > Thanks for noticing, and pointing that out.  I'll get right on that.
> >
>=20
> Fixed now.

Excellent, thanks for the quick fix!

Stefan

--NzX0AQGjRQPusK/O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYqtOZAAoJEJykq7OBq3PIhX8H/A1hnkxu/UBXAXslFttlp0JI
d9EWABERwdCOsyggtcCY6AITR1YgAM7TsCdmaSEEofjOkLLV7iG7im7cx1xxm7G/
WZh2e0GRQARmLjdhnRaGPz2fYL6SPwYV6Upl6WVaaWgqMIcQHSpzb/Z2jFE6djoO
yha36ZB6mxlMU14H1j053FUg3Hx7d27ln3aE21PrXGO1tOZh9qjjGEXqpbuEjKBP
8qFWRPR2rY65+79SuXdfIaWvl9ohSrs4592D1rG0yKcrP2YKx6VrWYM6tnqntLWz
CLnCL0wCHoFR1LUBvP7vuAn4DNhLOaZahqjG+tDd7iCwQ4CXKG4IppAmez/g0EI=
=dKNx
-----END PGP SIGNATURE-----

--NzX0AQGjRQPusK/O--
