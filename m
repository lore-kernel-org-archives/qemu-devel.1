Received: from eggs.gnu.org ([2001:4830:134:3::10]:45760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dXr7h-0003FQ-1S
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dXr7g-0000fj-9m
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:42:49 -0400
Date: Wed, 19 Jul 2017 16:34:45 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170719153445.GA25920@stefanha-x1.localdomain>
References: <20170627154120.20346-1-stefanha@redhat.com>
	<e711b03d-4543-be7d-24ef-c8eb7817cc41@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <e711b03d-4543-be7d-24ef-c8eb7817cc41@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] docs: add
 qemu-block-drivers(7) man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2017 at 02:37:49PM -0400, John Snow wrote:
> On 06/27/2017 11:41 AM, Stefan Hajnoczi wrote:
> > Block driver documentation is available in qemu-doc.html.  It would be
> > convenient to have documentation for formats, protocols, and filter
> > drivers in a man page.
> >=20
> > Extract the relevant part of qemu-doc.html into a new file called
> > docs/qemu-block-drivers.texi.  This file can also be built as a
> > stand-alone document (man, html, etc).
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: John Snow <jsnow@redhat.com>
> > ---
>=20
> Ping for 2.10, or no?

This is not urgent, it can go into 2.11.

Stefan

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZb3wVAAoJEJykq7OBq3PIS2sIAIx4uA6sNPa8X0EU0PNg7S1k
Xz0Zw5udNihTaKIxW1LzahesoiPCAC6SbLASh2ivycFGlSHJtxSd+eVPTM0nS+PI
XlmMNuTRGn7K/mxbhT8if8AxKrTrU7c87I5XyLnI1w+V1ir+XrUtvHwEaLeDxszB
fwb+n79MHzgpcFAwtUQjeJVpprGqFoe8ZAc9qJ59NWBARaxpnmNDy/9uQdb99FMc
yuVTqTvKoLVkYaCkEI4VwihJVgRtNrjjlY18as8eJMglgKvI2t/c+vjShNAixjLW
id6xx3hC4NQky3vUQ48db4aKoOBjjtaF3EiBGNBzdhx2xS97F6F8KgqxhD5XfR8=
=AziZ
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
