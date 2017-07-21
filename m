Received: from eggs.gnu.org ([2001:4830:134:3::10]:59199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYXWZ-0006DQ-CO
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYXWU-0003Hf-IY
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:59:19 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dYXWU-0003HM-Ba
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:59:14 -0400
Received: by mail-wm0-x244.google.com with SMTP id m75so579650wmb.2
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 05:59:14 -0700 (PDT)
Date: Fri, 21 Jul 2017 13:59:11 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170721125911.GF18014@stefanha-x1.localdomain>
References: <20170717101632.23247-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y/WcH0a6A93yCHGr"
Content-Disposition: inline
In-Reply-To: <20170717101632.23247-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] add scripts/git.orderfile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org


--Y/WcH0a6A93yCHGr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2017 at 12:16:32PM +0200, Gerd Hoffmann wrote:
> Based on a old patch by Laszlo.
> Time to get this in ...
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  scripts/git.orderfile | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 scripts/git.orderfile

I've been using a local copy of this... :)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Y/WcH0a6A93yCHGr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZcfqfAAoJEJykq7OBq3PI6D4H/2t5DIcB3kgGEvTqkDFMfA3x
z3XycZYnx4XQpY+a4udROZFUG8aJ6ZQlfQtG+RbwKjEPS5uiX6Y4BxJbYr1IfP4M
WctezApPqvDNd+nZEKblzubohzQ8ofNZl65qLrSKkcVhpX5uoDo9f1I3dTIiGVZx
eL1fWaFmxyXyYYK5UeLyHLY3OzEaf4ZDSbvHPKUdM2J3SGLBu7XrtDD8QEmj3ni2
ViXFdnB00FdllScxZldeBcNAUAM2jxU1Uj07W5oTUPnsikvt3EFcFQOq5wrA883c
lX1yzjFUsQo3Wz7ibCy1ZrXYRt+3uKkYIcoZUzub2w0YHXFcYY2Rlc1S5ZDKmJ8=
=iN5n
-----END PGP SIGNATURE-----

--Y/WcH0a6A93yCHGr--
