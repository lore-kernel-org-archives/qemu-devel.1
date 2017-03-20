Received: from eggs.gnu.org ([2001:4830:134:3::10]:58710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpxZK-00023A-V9
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:41:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpxZK-0005Mh-74
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:41:54 -0400
Date: Mon, 20 Mar 2017 13:41:49 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320134149.GU17887@stefanha-x1.localdomain>
References: <1489507451-32356-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DFFMAMYvrfM3lt66"
Content-Disposition: inline
In-Reply-To: <1489507451-32356-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] file-win32: Remove
 unnecessary include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org


--DFFMAMYvrfM3lt66
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 14, 2017 at 05:04:11PM +0100, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/file-win32.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--DFFMAMYvrfM3lt66
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz9wdAAoJEJykq7OBq3PIKekH/R8KQ5zxU902ZRqK52rIKVfu
2FDiCgHFABlpDT4iMWsTqnx/BVSHS941Lpi+md30Ztlh85BIFZ/mrFOJ4J+y03dS
S+m5R2szl6aFv7+O2I99gTthos6+qOfU/60ciLyf1qmS+f52tlop4UBs3+WOsr2V
hZsySHWxs9DYa4NIP3qDLoKnUvkMMCPzYoOJp5Pu6TMOMCorvvJGZwu9IDF2+fmx
tZx8wHasWQl1fKx+zhX3/MTKCVBF9d8fBpLt/FwJLkNfInSVF0/0GU8a3xP+d1Is
Shh/xR1s60AxhUG4JJvt5izmzkZoUGy7YTT1D9h7Uppe68jyQmumRHSEFLmM41w=
=+vUQ
-----END PGP SIGNATURE-----

--DFFMAMYvrfM3lt66--
