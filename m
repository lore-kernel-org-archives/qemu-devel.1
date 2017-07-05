Received: from eggs.gnu.org ([2001:4830:134:3::10]:59540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dSjto-0006tv-HO
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dSjtn-0003n9-Q5
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:59:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dSjtn-0003ms-Jp
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:59:19 -0400
Date: Wed, 5 Jul 2017 13:59:14 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170705125914.GC29910@stefanha-x1.localdomain>
References: <20170614153557.3319-1-stefanha@redhat.com>
	<e32fe960-bb2f-7c9c-dc2a-0ed46af154b1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <e32fe960-bb2f-7c9c-dc2a-0ed46af154b1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 0/9] qemu-img: add measure sub-command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Alberto Garcia <berto@igalia.com>


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 30, 2017 at 03:55:24PM +0200, Max Reitz wrote:
> The series looks good to me, but the output_fmt is a bit too weird to
> take it. A follow-up patch would work, too, though.

Thanks for the review, I have sent v9 with fixes for the issues you
raised.

Stefan

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZXOKiAAoJEJykq7OBq3PIuhwH/2AjztCa7Pn8sehMZjY6cWg+
Wxg9MgCt2vJLitGco+GjVVFnuLG3xfi1Vf8eu6ukUMG+wSYuOPbSVz225kSuWUdz
MO07oYGb3L2o4MFopIQfPAWClMuFodd9QaQ3lEX7XlVGiIE0XPdzpEpNpOwqmhHS
he6LSghgflypWHWUDX6R9KJ3yOlTuNF8bYv3LJoF7ECdxL/VHfMoIiY3dpibndu/
Bi5Zqsvnqxz8K4n1oTwR3kDrtVzqvOPYjhJGpvLdB72NnlFlNRQp6R3azMBh3F8v
KVAJXNKX1xEDWtspBlYbRPHDPvB/osAYfZEPULuk0Q70Cpl8SZ4eyqKLrbQUDNQ=
=hXwY
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
