Received: from eggs.gnu.org ([2001:4830:134:3::10]:45377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dPoB8-00036C-A7
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 06:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dPoB7-0008Tl-AW
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 06:57:06 -0400
Date: Tue, 27 Jun 2017 11:56:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170627105654.GA5364@stefanha-x1.localdomain>
References: <20170622121713.27601-1-stefanha@redhat.com>
	<f274e0eb-ec19-346d-2c64-07ee6b30ca69@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <f274e0eb-ec19-346d-2c64-07ee6b30ca69@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] docs: add
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


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2017 at 04:40:58PM -0400, John Snow wrote:
>=20
>=20
> On 06/22/2017 08:17 AM, Stefan Hajnoczi wrote:
> > Block driver documentation is available in qemu-doc.html.  It would be
> > convenient to have documentation for formats, protocols, and filter
> > drivers in a man page.
> >=20
> > Extract the relevant part of qemu-doc.html into a new file called
> > docs/qemu-block-drivers.texi.  This file can also be built as a
> > stand-alone document (man, html, etc).
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Thanks, this is really useful information to have. Looks good to me, but
> Paolo's changes prevent it from applying now.
>=20
> So, as of last week:
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>

Thanks for the reminder.  Will rebase and resend.

Stefan

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZUjn2AAoJEJykq7OBq3PIpQYH/2hby8gR8eZawGIZ3fvqEZIj
8ulYWa8oL0fPXh5DoX2I+10UuZSwfguwncPOz3M/qrp2demTgrnNxNfr7Ds75h0U
tQ/9mgjxh20OCWl7kei6hGIjztAd9rQfAseAe9XUyM8zQuhVgzVeuLSQeq/QIoAW
wyXQXlxAhGg/FiuKmNVBdsQ1yyTU02k5h+ZGXvO2+7ejkH+Z/h6sBCKv0+OF3mgW
bw7NqmmESq1AJgP8+4XmQ85h5H74eIIGtN/yLOrDpQ+rwFyQNhKfiaet6Vj4WuWb
a1Kk22KVCJYDwGQCA+OGAdvVxd4bT9sw+VBrO+BhnNl2fNnDGSh6zuF6aWZaCcE=
=8TcP
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
