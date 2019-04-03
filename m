Received: from eggs.gnu.org ([209.51.188.92]:60166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hBeaY-0006QT-Mt
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hBeaX-000108-Lc
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:01:54 -0400
Date: Wed, 3 Apr 2019 13:01:43 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190403120143.GA32425@stefanha-x1.localdomain>
References: <20190330112142.14082-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20190330112142.14082-1-jbi.octave@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] util/readline: Add braces to fix
 checkpatch errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jules Irenge <jbi.octave@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 30, 2019 at 11:21:42AM +0000, Jules Irenge wrote:
> Add braces to fix errors issued by checkpatch.pl tool
> "ERROR: braces {} are necessary for all arms of this statement"
> Within "util/readline.c" file
> ---
>  util/readline.c | 50 ++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 17 deletions(-)

This file is unmaintained, I'll take this patch through my tree.

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcpKCnAAoJEJykq7OBq3PIpRoH/2/nrzeVuPzcFDyYiYlPG00F
Y/veZ3CJb7az8QK0f5q4eqsLpXDR1UsBR2HHvOB09TwbMh/3ZkD62zZrU0bQnMJZ
mH/mzQE4zowTZuYRR4v96ALRoOyD8fYihG06FNN+wBZ1sJgg2fWIyVuIrUwxw8zZ
p7dwu0b/yfv1HkqnY34Ssrm4imlpgQdKHQnO9tt1p+7X1k4Umts18QVBWKPd3S9q
RaNy2BXVkPS9BXPNCOKh3c163zx74vnSKftbiZwdY3UcyGjsRlGf2Xc3jUbXEb4w
DoPDz04SyLorwsM5fSBGveqGrfxcXdHgHRF57tc8EWJo2ueuIJOvo8cELZrNztg=
=zwh/
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
