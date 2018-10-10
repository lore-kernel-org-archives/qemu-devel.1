Received: from eggs.gnu.org ([2001:4830:134:3::10]:46713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gAF9U-0006FP-Qz
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gAF9R-0002Ay-0M
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:07:52 -0400
Date: Wed, 10 Oct 2018 15:07:38 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181010140738.GC13076@stefanha-x1.localdomain>
References: <1538964972-3223-1-git-send-email-liq3ea@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Content-Disposition: inline
In-Reply-To: <1538964972-3223-1-git-send-email-liq3ea@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] util: aio-posix: fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: famz@redhat.com, qemu-devel@nongnu.org, qemu-trivial@nongnu.org


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 07, 2018 at 07:16:12PM -0700, Li Qiang wrote:
> Cc: qemu-trivial@nongnu.org
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  util/aio-posix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbvgeqAAoJEJykq7OBq3PIJUcIAMlhO1E0I3+IfafC+WI11Ynu
ZmsCTxfEfPxtDNZ62E60XRzOuo3XiOASwQdcYCxBGNYL0z/KHyc6I33n8Z4W4qLm
Mbw63+NvWbIisIyzQMfqTtjyVB5BITdyQnnfYHp7n6CYUIzX647oRCTH+/zIJfOt
6ILKzXusSIyIaVe9gn5QFgzIRVlFOf1f0AkOG5crND3KpAjAlErmjbvFHLM4BM1Y
qINuFGdm/E7YsQBmH1e6XXMlG1EmDxpqo+yb6hSCG+3TGeF01smtdC0ywMnbC+oO
3lQAi4ji8y0r71gx5sSYICs2rPu9IRB7f5mcmOAF/CKAV0Ina2jWS0w1xgG+lPs=
=w8zO
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
