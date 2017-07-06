Received: from eggs.gnu.org ([2001:4830:134:3::10]:56062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dT3Ne-0007yv-Gd
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dT3Na-0007oJ-M9
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:47:26 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dT3Na-0007o6-FQ
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:47:22 -0400
Received: by mail-wr0-x231.google.com with SMTP id k67so21163759wrc.2
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 02:47:22 -0700 (PDT)
Date: Thu, 6 Jul 2017 10:47:19 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170706094719.GF30447@stefanha-x1.localdomain>
References: <CAGKXQyf=BbwbcbN62f1ZC0QYzmbPixtsjTNctpa6_bwsDMKETw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Content-Disposition: inline
In-Reply-To: <CAGKXQyf=BbwbcbN62f1ZC0QYzmbPixtsjTNctpa6_bwsDMKETw@mail.gmail.com>
Subject: Re: [Qemu-devel] Page Block word
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ali saeedi <ali.saeedi56@gmail.com>
Cc: qemu-devel@nongnu.org


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 30, 2017 at 04:31:30PM +0430, ali saeedi wrote:
> what is the difference between word, page and block in qemu?

The meaning of these terms depends on the context.

It's not possible to answer since you didn't give any context.  It's
like asking, "What is the meaning of 'element' in QEMU?".  There are
many meanings, it depends which area you are looking at.

Stefan

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZXgcnAAoJEJykq7OBq3PIL+sH/3MF9QG6Bs+ozIpPHWrrGJVq
0Du0M6oIs+yeoZsC0zxSJXQMOzLz4nRfJey/gv1QwDZJnhYeSSdl+Bow4GxGOKva
8PsZ5MTrXSWm+2qqU7vYv3d3okoRwkKQNS9mxvD/6q4188/zdRMH+mI1faILW+hM
OpAOeqEsMZuHFsUk4CaAMD3izo7JoUNotRG2Q/twahw8VPmR1uE0jzwfVu/GX46C
JBIfu32KdpixhuJ5ieo/oTsVXXMV8VHeuX1NTjVc8YCfRuXGd7lLN95b23dZS/Vb
hrOEewWGKcMiqCEHpUS8MJWLRJbZB5L7ZOpoIOXynMMSgLkTD91KG9j/cRDM5dc=
=qwew
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--
