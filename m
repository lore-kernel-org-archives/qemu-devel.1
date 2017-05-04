Received: from eggs.gnu.org ([2001:4830:134:3::10]:60071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6FwU-0002SG-RC
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:33:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6FwR-0005MK-DA
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:33:10 -0400
Date: Thu, 4 May 2017 13:33:03 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170504123303.GH32376@stefanha-x1.localdomain>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wj9ZLJVQDRFjGSdK"
Content-Disposition: inline
In-Reply-To: <20170420120058.28404-3-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 02/17] block: access
 quiesce_counter with atomic ops
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


--wj9ZLJVQDRFjGSdK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 20, 2017 at 02:00:43PM +0200, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/io.c                | 4 ++--
>  include/block/block_int.h | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--wj9ZLJVQDRFjGSdK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCx9iAAoJEJykq7OBq3PIQjgH/3h9/tev4d6mor0VLLOpwSuK
mbj3aG4DNgcBlzKJpabO8FGWZeEx6Xs7Bt2BUFbrnkwFnHw7ERRn51a8M61XecbB
mpZWeMl0pFE7pKMtj8yYFeRgY94y6je5vr+xdoRMiXK0TCP38VP8dhrZFfhdHCo+
Jxy0aYcDWL+lt8zFRMihla503eRZTo9OxcwukBMgIX8rsj/S3N8UVuJ7oeTMnX89
rgGjiRhuGmIMJS+NWhkB9wVGJqMe/GnfBasyOpibVV/Akgbcl25Eu/c4nTcxA1ZV
MFxlGBGcQkYyhwrYNiWyVkFGMyuMKtGz6wPnnSYg6yF5ddksqZEZ4Rrm/Q/C7hs=
=aHm1
-----END PGP SIGNATURE-----

--wj9ZLJVQDRFjGSdK--
