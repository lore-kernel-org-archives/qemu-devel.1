Received: from eggs.gnu.org ([2001:4830:134:3::10]:33368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dSk0C-0004Kx-OJ
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dSk09-00073X-G1
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:05:56 -0400
Date: Wed, 5 Jul 2017 14:05:49 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170705130549.GC1280@stefanha-x1.localdomain>
References: <20170622121713.27601-1-stefanha@redhat.com>
	<1e102164-43ce-126f-29f3-228c407391a6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
In-Reply-To: <1e102164-43ce-126f-29f3-228c407391a6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] docs: add qemu-block-drivers(7) man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, el13635@mail.ntua.gr


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 27, 2017 at 10:20:10AM -0500, Eric Blake wrote:
> Then again, much of your patch is just code motion, rather than new
> documentation.  So my comments are probably worth separate patches.

Yes, they sound like good improvements to me but beyond the scope of
this patch, which moves the existing documentation.

Stefan

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZXOQtAAoJEJykq7OBq3PI4TYIAKa93aFwc68+iQVCZsChki6Q
pySkKMzBg0znXhqXHvbqvrkevDrbkSLDFvKiuerUUvNfA7FUnsSYTQjE7lRihYcz
N3ddvwJ6bOdCXH6/0UpoHg6RHFjH6Qb0MiOMbVHzs/DuvMdZZZWzrmJFJO+1Hr5V
R/TnqogZg3RYpZtbmOSHwrvP05hWeSWKSXGyyynLTc9CvEP3ismF2C4plbOy8Lfy
mlHre3tg/pc0KtnVP674Jt+i5Pvq5IV7FcvQQEjmuRfT6aBEPo5cIrHYtXbs3u0W
d6FWax+2iVvfPo4dAv9DW2LWOX6YkYSISdTGUsJziyHIYQoNLGdP+Pg1X0FNHD0=
=7b9V
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
