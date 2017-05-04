Received: from eggs.gnu.org ([2001:4830:134:3::10]:35842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6GBl-0005nF-Sm
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6GBh-00048n-0d
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:48:57 -0400
Date: Thu, 4 May 2017 13:48:49 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170504124849.GL32376@stefanha-x1.localdomain>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xtmLDbP6TiKhntQb"
Content-Disposition: inline
In-Reply-To: <20170420120058.28404-7-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 06/17] block: access
 io_plugged with atomic ops
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


--xtmLDbP6TiKhntQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 20, 2017 at 02:00:47PM +0200, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/io.c                | 4 ++--
>  include/block/block_int.h | 8 +++++---
>  2 files changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--xtmLDbP6TiKhntQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCyMxAAoJEJykq7OBq3PIHHUH/RwhHtPt/3ag4B6powQfO2UK
l6tJ9tpYNIHg7Jsg3bwQlo+JkFrvKUfyFL2d1gkQD+36p1eNJy3FBQPNiXiEgkXn
n52KNOmyF5fmSIKMb9LcWSiKXGhFTuZxjHy3FodQQvMXVBMKZ1PZERJvXQDd7m+X
Q2ZpkmWluzVf9qULp6rcRtWkNOb/SetzRHOMUyovey2tZuevG08LXwV65DFtVYeH
rsJmNIbfFeXWsAUIrGy91FD2jl1k2w3f6UeZ3SsUMhQKJcSNZ06jMtGBBBODXTEP
/HPWQ6THmnSHlFnl7RXtI93Sfsx0pFVfC2xjXyEjtUi6Qm7oIEO+nasJwLPVJkc=
=WeQJ
-----END PGP SIGNATURE-----

--xtmLDbP6TiKhntQb--
