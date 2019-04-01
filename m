Received: from eggs.gnu.org ([209.51.188.92]:33849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hAuZt-0005MN-V1
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 06:54:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hAuZt-00043Z-0r
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 06:54:09 -0400
Date: Mon, 1 Apr 2019 10:09:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190401090940.GB643@stefanha-x1.localdomain>
References: <20190330112142.14082-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
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


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 30, 2019 at 11:21:42AM +0000, Jules Irenge wrote:
> Add braces to fix errors issued by checkpatch.pl tool
> "ERROR: braces {} are necessary for all arms of this statement"
> Within "util/readline.c" file
> ---
>  util/readline.c | 50 ++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 17 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcodVUAAoJEJykq7OBq3PIQs4IAL1KO/k5XCuPVkgft1Gx8yYF
W0OcaD0HVqUYnoxH9uaX8RIpZSN9GpKSVJ8RaWKmrzXS09HQf7XavjibOvig683t
rq5qsVu/wusAHX9ss3oXytyMYAuy/2EIlxB7YxSACCdB3Nbvnx1rHrjzSv/QfCV1
h77lsKQeqb2BSGgvC/hHH0ZCKE7BVtSdFmLcLxb58cN9rdWWaUsJYaCCqi0rX9aB
b9DlH3YGBc0BDHFP/p+fYQXJl2DTNmafTqUSrOn2S77o3PpiVy+s+djVdKFX4cNk
HriINteqygmCKJFKY0OXvRZdfBjDfKLhzuJBA2m0XZxaHYDgCuz2s7DKmyOhNSU=
=owFV
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
