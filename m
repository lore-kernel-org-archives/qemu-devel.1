Received: from eggs.gnu.org ([2001:4830:134:3::10]:52459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUVMb-0002PF-C6
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUVMa-00015x-Nw
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:52:21 -0400
Date: Mon, 10 Jul 2017 10:52:11 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170710095211.GB14195@stefanha-x1.localdomain>
References: <20170622121713.27601-1-stefanha@redhat.com>
	<86920a79-2910-06d6-7833-54b4881dcc35@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
In-Reply-To: <86920a79-2910-06d6-7833-54b4881dcc35@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] docs: add qemu-block-drivers(7) man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 06:08:58PM +0200, Paolo Bonzini wrote:
> On 22/06/2017 14:17, Stefan Hajnoczi wrote:
> > +@c man begin SYNOPSIS
> > +QEMU block driver reference manual
> > +@c man end
> > +
>=20
> I think this should be wrapped with @ignore / @end ignore.  Otherwise
> looks like a great idea.

Why is @ignore needed here?  qemu-doc.texi doesn't use it around @c man
begin SYNOPSIS either.

I've checked both the qemu-doc and qemu-block-drivers output to confirm
that it appears correct in both man and txt formats.

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZY05LAAoJEJykq7OBq3PI8LcH+wTOXNdTLiXEGuHurd8P/xAq
oTIvwHxQlYsOSImiVthYFCJMC+IimM8rPUWWQ74/mgoR4B9RFy8ksONANhmJ+gt9
ymtietlhhxofSRnLEVgo4U5NqJDvhk5iHDSKNWKma8EFykUU101TK60xIzLhto8u
GveqArZq49xiM+kWDbnFT3HemIY8itVwqVBzRkXeJLPpupNDwyBT0VfeqKUexidU
BZq2MHJpIUOM7RCtnOLUVIK56opV1+QZrKdd4gmppTIYtvf85D4RjhuI6um6ZdrE
A9q43O7vveCfPDv/4NugZUzARWgJiYPIRaEIVQqu6T0gE1XLFTkuRwBWjy7VmLI=
=vvgl
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
