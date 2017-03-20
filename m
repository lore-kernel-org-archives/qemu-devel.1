Received: from eggs.gnu.org ([2001:4830:134:3::10]:58712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpxZL-00023B-15
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:41:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpxZK-0005Mm-8Z
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:41:55 -0400
Date: Mon, 20 Mar 2017 13:41:45 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320134145.GT17887@stefanha-x1.localdomain>
References: <1489507437-32301-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0WGqsT62A4RTsSXf"
Content-Disposition: inline
In-Reply-To: <1489507437-32301-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] file-posix: Remove
 unnecessary includes
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


--0WGqsT62A4RTsSXf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 14, 2017 at 05:03:57PM +0100, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/file-posix.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--0WGqsT62A4RTsSXf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz9wZAAoJEJykq7OBq3PIEGsH/1UqN8QUvGSLyTVavUvwOWYS
PDE/a3niyiItDqqNZ8PtCorsG+PBaRH8m9J6SbjFkNxNgKgUKLYp5HKWVaXusbg1
RGexxgyehKKwbcDpR+Dd1146/E93D0Fa6l/zD5mUVxvrP6dc6O5B3BTGJJaLJhPW
Eg4/jsA2vmGV/sY7M+zgeRFv0Iz6b/dnePAsSbN0cHXXVDIkWUXiPu6qXnqGhF9h
txuCViwIwSC43z/mV2kxw8W4Wqev89LSh1aFqylfo2UAv/P7lFbrMxkZqI8ANT74
4HRFOWCvKvbYJNj9PFe6EWkLCOh6vmHmNLUsPk8bGxZ361zWTcdfcED9D1n4KwE=
=+dsp
-----END PGP SIGNATURE-----

--0WGqsT62A4RTsSXf--
