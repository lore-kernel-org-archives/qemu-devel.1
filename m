Received: from eggs.gnu.org ([2001:4830:134:3::10]:44749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9RUb-0004Ch-Jz
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9RUY-0000vd-Hh
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:34:05 -0400
Date: Fri, 20 Apr 2018 16:33:55 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180420083355.GN15181@stefanha-x1.localdomain>
References: <20180416165849.28864-1-mreitz@redhat.com>
	<20180416165849.28864-5-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kUBUi7JBpjcBtem/"
Content-Disposition: inline
In-Reply-To: <20180416165849.28864-5-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 4/9] block: Set
 BDRV_REQ_WRITE_UNCHANGED for COR writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--kUBUi7JBpjcBtem/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 16, 2018 at 06:58:44PM +0200, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/io.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--kUBUi7JBpjcBtem/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa2aXzAAoJEJykq7OBq3PIMRYH/3pfMRUk0yHdN7nPMic84gzY
IV8laRTnWmNAOsVJvnLxJGaJklbi64ptukgIUpG7u60gcv8WHGKw+VocDcr0IlyS
6hX53cK9F2SXFb9E4jBLv8xj0KKyXc6sXd20aDOYWEYrrqjz9Q63OBm4aoqsnZiQ
CFXxYE/BKG/JHyzWvGXuaVHl9j4zUHhofXS1bt0H5oa2REvM4myqz1xxNzbfmjSF
x8jjx6N/AoDWdMnRZm+IE9Gc5GKv/VrwrATOWxhavNhdAQFqnX0xCUhN8kHCZjS0
etABpkh7VVFmP5SEHmJQCr0JhOA4M/nbnbOudwayqkBzWi1T2r9y+UhcryTgYMI=
=4TH5
-----END PGP SIGNATURE-----

--kUBUi7JBpjcBtem/--
