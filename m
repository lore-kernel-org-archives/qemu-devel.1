Received: from eggs.gnu.org ([2001:4830:134:3::10]:41334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d0UJK-0000TJ-D3
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d0UJJ-0002OH-Ny
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:40:54 -0400
Date: Tue, 18 Apr 2017 15:40:35 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170418144035.GI21261@stefanha-x1.localdomain>
References: <20170412091819.GB4955@noname.str.redhat.com>
	<CAOGPPbfkZ5qJC-YkeBs+LLdn88VTvij_Xk8_FEpaNmg_pyXVVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6lCXDTVICvIQMz0h"
Content-Disposition: inline
In-Reply-To: <CAOGPPbfkZ5qJC-YkeBs+LLdn88VTvij_Xk8_FEpaNmg_pyXVVA@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block]  migrate -b problems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 858585 jemmy <jemmy858585@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--6lCXDTVICvIQMz0h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 12, 2017 at 05:51:23PM +0800, 858585 jemmy wrote:
> it this bug?
> https://bugs.launchpad.net/qemu/+bug/1681688

Yes.  This discussion is about the long-term fix instead of a short-term
hack for QEMU 2.9.

Stefan

--6lCXDTVICvIQMz0h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY9iVjAAoJEJykq7OBq3PI4qwIAJyUreKP9nDIBlyLV6yrFR6j
StsrwDJDlJcRW76mEZXpLix3/gu8SO/bhalm+0FDMATwsBnXqW365nV/TPXPklUc
bzYSgWfGyOz4QNIT0vuPyXN+1k0+vn3Id5ZEPY8TAmt+nbLhmm3OGmlxpL4Acrqg
W7YhhtESvvHUnYZhNfpViHcFOHKCtlGBM9TRaQb/i84HUKjvNK2UAxem1a6niMpc
BHp2Oy23PiYekAsJbH0OONBVOFUeXF5lMPz65uSf3kBYW2w0p1+mjef9+NFgurVB
1lXm+Dzbl7KDoK/zOvZs+TuOqA01Kzh/6KEwkGH+skdNQAx7aknDTukPN9t/XuE=
=Pahi
-----END PGP SIGNATURE-----

--6lCXDTVICvIQMz0h--
