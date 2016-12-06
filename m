Received: from eggs.gnu.org ([2001:4830:134:3::10]:49352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEM0C-0001AU-MM
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:06:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEM09-00062n-IS
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:06:12 -0500
Date: Tue, 6 Dec 2016 20:05:05 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161206200505.GA2521@stefanha-x1.localdomain>
References: <1478494765-13233-1-git-send-email-xiecl.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <1478494765-13233-1-git-send-email-xiecl.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH] tests/.gitignore: Ignore test-char
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changlong Xie <xiecl.fnst@cn.fujitsu.com>
Cc: qemu devel <qemu-devel@nongnu.org>, qemu trival <qemu-trivial@nongnu.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 07, 2016 at 12:59:25PM +0800, Changlong Xie wrote:
> Signed-off-by: Changlong Xie <xiecl.fnst@cn.fujitsu.com>
> ---
>  tests/.gitignore | 1 +
>  1 file changed, 1 insertion(+)

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYRxnxAAoJEJykq7OBq3PIyBEH/R+gpqH0jDddj9K+LdnlQCkD
9HZF/L3shwF7YvaBQidDai7Qa8Z/XEyK9rMGVz0aBfqjgsoOLRRcP/A7ZhxCSqEC
NlFM801xQb5+q3TuXomIbNbhj+/z4OsXOGy8dZgSfSWzEQgP39/brrjYDYA2bueD
7bOAofABdTc+Sf81ho+LLtNmtJdVkRG01+ZlJDDRYipujEmcpzPzn68rtoBD9jMO
8jPbhKXGKXFnmmnPU4fOwgaiRjzNyIbKFhgNzzqBBKEeo3iO4eSSgwpNrO+FPa0G
V5X4FtYe37Nv4iAJfvUIPctY5FIotzKCKvBaJZiVEqIuo9AwRNcHK2bsXNQ4I4A=
=Xkrw
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
