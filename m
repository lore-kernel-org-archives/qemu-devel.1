Received: from eggs.gnu.org ([2001:4830:134:3::10]:40403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8tjh-0001Bg-1L
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:26:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8tjd-0002Td-Sr
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:26:53 -0400
Date: Thu, 11 May 2017 15:26:46 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170511192646.GD24584@stefanha-x1.localdomain>
References: <20170419094356.19826-1-famz@redhat.com>
	<20170419094356.19826-2-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline
In-Reply-To: <20170419094356.19826-2-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 01/16] block: Define
 BLK_PERM_AIO_CONTEXT_CHANGE
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


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 19, 2017 at 05:43:41PM +0800, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block.c               | 2 ++
>  include/block/block.h | 7 ++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZFLr2AAoJEJykq7OBq3PIY7kH/RVMXZoivqTzJLcUHhEXAOyO
ybM2n302WexKMf+o0igYpwaPiBIieVat6WKeW+OF5FU4vcbkPS6KjIu6+CGbUNIf
yX9AMOtiKLj9kEsQ55nrQU8Wg0BH6qZRJ6zEdBVFaW93sqs+6InSazVTGDp8z53W
rZVWiYjOPQHJxkgT1UizCVFOVD/Xa17S0zNKQNrUqDQWLVveR9MGd4S7EhLXq7hF
JVqsTGtLUJFNrHVyPAy7OtkXUFarC42Kv9uSqtYsDn48MUvBOftYmpTaH/5u1vsb
PXbSQeVKuMZypufgmU8pRPA9hee5MrXov2La/VCfiJHuyLyi3Yb3Jd4q8Z8i6Bo=
=mtUN
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
