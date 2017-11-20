Received: from eggs.gnu.org ([2001:4830:134:3::10]:44861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eGnS9-0000TP-5G
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:53:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eGnS4-0006Qw-BM
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:53:41 -0500
Date: Mon, 20 Nov 2017 14:53:33 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171120145333.GH4516@stefanha-x1.localdomain>
References: <1510851298-59922-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1510851298-59922-3-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YrlhzR9YrZtruaFS"
Content-Disposition: inline
In-Reply-To: <1510851298-59922-3-git-send-email-anton.nefedov@virtuozzo.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 2/4] block: support
 compressed write for copy-on-read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com


--YrlhzR9YrZtruaFS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 16, 2017 at 07:54:56PM +0300, Anton Nefedov wrote:
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/io.c         | 23 +++++++++++++++++------
>  block/trace-events |  2 +-
>  2 files changed, 18 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--YrlhzR9YrZtruaFS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaEuxtAAoJEJykq7OBq3PINyoIAJQ8NUYGJA3lMRCZw4UiiIYL
hc8yFpX2C6yyLNgS4ESLta7YGxfAQGSeVHZE4qzoojcKV6ncJHXO+uVcHPq6Ri+P
nzptSKqc+nkqGUQohn8qGfpfis8UtC01gNseXG+BDyFz7E6eBocTYy4QdIWSlUT7
aTQ42wPi8fePV3ujVMn1es5MthqJwgx3mRgrv6fRbQBOWmBGKADqzp1NZnHW37eF
bW5ZtIIis9Y26lzLYs905g4glR9XnIRsPFKiTjOOy1Ee6ZeiRfrgE3c+J3PWEOIJ
Sk5+3FbbKZQVJH2PXb9+BxWrFBX/OT56UmPDrDfJQ0irfZv6L2qmWkjjJO9HxSk=
=tQ5X
-----END PGP SIGNATURE-----

--YrlhzR9YrZtruaFS--
