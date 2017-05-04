Received: from eggs.gnu.org ([2001:4830:134:3::10]:57812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6HMp-00040g-F0
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6HMl-0000T9-Ls
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:04:27 -0400
Date: Thu, 4 May 2017 15:04:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170504140420.GP32376@stefanha-x1.localdomain>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e2bLSPRkEYxxSNev"
Content-Disposition: inline
In-Reply-To: <20170420120058.28404-12-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 11/17] block: access write_gen
 with atomics
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


--e2bLSPRkEYxxSNev
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 20, 2017 at 02:00:52PM +0200, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block.c                   | 2 +-
>  block/io.c                | 6 +++---
>  include/block/block_int.h | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--e2bLSPRkEYxxSNev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCzTkAAoJEJykq7OBq3PIVKIIALzFewgvN7vhaBuLoVEVrSUA
SI2cGMETGKeQvk7nI0scuIFBEiWrrdPEQCxsWqCgf3xLdGCNiUmUrBlXcPJRKm5B
KBJEQ3E4FGmo5i9DGPb3gD75Wsg8EQZvgq0VhiJGqN7M2/gWMQ9lNq4NH02dCE/j
Jt4YpweqzA0d00a1crxeGEJ9ROiKdOstx3PANezpB+nJ65Kr4mgTjCftnaZX+wtW
kcULQjm+i8+iFcM51gXfgmbFo6rFcyx2fb/fcwcLIqmJa7H3ZrOblCDWIiFiaPOB
W3RwY9PYKXTM9ExFogGnoSYZwUTYvqNZ5ZCEmrMxVWY2LUOwEflJrSA9I/7CewQ=
=iUQY
-----END PGP SIGNATURE-----

--e2bLSPRkEYxxSNev--
