Received: from eggs.gnu.org ([2001:4830:134:3::10]:33511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6G2N-0008Ue-BX
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6G2K-0000E9-95
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:39:15 -0400
Date: Thu, 4 May 2017 13:39:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170504123908.GJ32376@stefanha-x1.localdomain>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1y6imfT/xHuCvpN0"
Content-Disposition: inline
In-Reply-To: <20170420120058.28404-5-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 04/17] block: access
 serialising_in_flight with atomic ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org


--1y6imfT/xHuCvpN0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 20, 2017 at 02:00:45PM +0200, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/io.c                |  6 +++---
>  include/block/block_int.h | 10 ++++++----
>  2 files changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--1y6imfT/xHuCvpN0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCyDsAAoJEJykq7OBq3PIzpQIALKYr51ffgz9YeMoEa63ExYj
+HtAgi1F3mDjUxi4PIoYSqG7wquszW5J9LV6x9VNJROcVHEsgkBMpnCX91fOnjsk
wFh0rq2DnALT/LCjLWK0/PVdwqaekGt+VF3hOnjX636twgH9AwyCsb7Sa4m2wZ0j
b+HQffypbm7zJ703LKP3S1Lvf9NvvfMHTSKQWYF7ZmbyppvqQP5Rs82zP0U3QUiB
CilmMRZ2L+FedrtAJQepipozCO8aDowBiRfFgiA4C5G1gtdZpDd1b1bjFt/MpUBg
xgX8sBi6TbZreOoVH1RZhEm4Bu8IUr9VJjrnvEqiD941RwhOa7OJWtxTM29EPBk=
=ExFI
-----END PGP SIGNATURE-----

--1y6imfT/xHuCvpN0--
