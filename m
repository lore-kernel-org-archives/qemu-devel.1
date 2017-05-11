Received: from eggs.gnu.org ([2001:4830:134:3::10]:41992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8tqV-000805-NC
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8tqQ-0005ip-QK
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:33:55 -0400
Date: Thu, 11 May 2017 15:33:47 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170511193347.GF24584@stefanha-x1.localdomain>
References: <20170419094356.19826-1-famz@redhat.com>
	<20170419094356.19826-4-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9ADF8FXzFeE7X4jE"
Content-Disposition: inline
In-Reply-To: <20170419094356.19826-4-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/16] blockjob: Add
 BLK_PERM_AIO_CONTEXT_CHANGE shared perm on bs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--9ADF8FXzFeE7X4jE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 19, 2017 at 05:43:43PM +0800, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  blockjob.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--9ADF8FXzFeE7X4jE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZFLybAAoJEJykq7OBq3PIr/wH/18etQRpjDB7Vn9xcNgXWqzW
Dt6aBUkQNOIw6e1WHx/881MR3DvLp968FvQNp6zxGKYI4CQNgmbxRPAs8ngUy7m9
bNL/gkyAfYSUWIuTgGgg/ryr0qBS55jPcPV9Y2d9qJ5hXMYT7lLZWTSqJl/qZaSL
3Md6IVQ8f46aY64QTDBc6gKaeCntNBB/+RkjGm8ksYhp5HDEASzjVarbrj+t6Nam
grZ/cv1gr22XhcVTCtnli0K9YgHynFrCDmyYC/PrGcwBhZ4OL1HbogUpEvCn7N0I
u6LL3GmkeI35y+zX1fKWHKf4NZorjDYcUaJjtltGytbHwSr9cmMPqxyN2qHJsYY=
=rzjK
-----END PGP SIGNATURE-----

--9ADF8FXzFeE7X4jE--
