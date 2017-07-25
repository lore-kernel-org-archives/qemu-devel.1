Received: from eggs.gnu.org ([2001:4830:134:3::10]:48659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da1fn-0002Ga-HH
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da1fk-00034Z-Cb
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:22:59 -0400
Date: Tue, 25 Jul 2017 16:22:52 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170725152252.GQ23343@stefanha-x1.localdomain>
References: <20170721093416.17816-1-stefanha@redhat.com>
	<20170724091128.GB4630@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H2kTGx6mr3R59oXC"
Content-Disposition: inline
In-Reply-To: <20170724091128.GB4630@noname.str.redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-iotests: add a "how to"
 to ./README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>, qemu-devel@nongnu.org, qemu-block@nongnu.org


--H2kTGx6mr3R59oXC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 11:11:28AM +0200, Kevin Wolf wrote:
> Am 21.07.2017 um 11:34 hat Stefan Hajnoczi geschrieben:
> > +5. Generate the golden master file
> > +
> > +Run your test with "./check <test-number>".  You may need to pass addi=
tional
> > +options to use an image format or protocol.
>=20
> ./check refuses to even run a test if the reference output is missing.
> So in practice you need a 'touch <test-number>.out' first.

Oops, will fix!

Stefan

--H2kTGx6mr3R59oXC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZd2JMAAoJEJykq7OBq3PIRu4H/1Yen8Q9rr9BjnDb1pxPteuO
GeyqzClCCf4o96YXBXPwPuwlesg4j5a0NPV0eyC1lrwZgkPqXB3DDLjBfhAZ5dRt
cvtZN8lKCxjiydCfVY0IOumQ99qOpkYva+8rZy74iHZtl40p2Zap/IjzD2O2sul9
RZLgUm3lRh5qh9o1K41B88wXSBmBfDVJFE2xejXm+W4EvWPJUPuM9sIpQDjQ+Vv+
SVUXjuc8QKllXo8HGXIjCpMZXFDh8YdpeJYjiE26qPIziP+1pbW+XyY8RawJpU5V
Vwf0e8bIsdkWVi6M4wbKuXqMisJV2sBYixqPoF2cCgG2D7weJMrovyMotpkYMLc=
=0jx2
-----END PGP SIGNATURE-----

--H2kTGx6mr3R59oXC--
