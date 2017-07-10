Received: from eggs.gnu.org ([2001:4830:134:3::10]:36091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUb4M-0006AD-Hh
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUb4L-0001WH-Ka
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:57:54 -0400
Date: Mon, 10 Jul 2017 16:57:44 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170710155744.GP14195@stefanha-x1.localdomain>
References: <20170706163828.24082-1-pbonzini@redhat.com>
	<20170706163828.24082-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/6IVfYouxg+lu1D"
Content-Disposition: inline
In-Reply-To: <20170706163828.24082-7-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/11] block: add a few more notes on
 locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--5/6IVfYouxg+lu1D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 06, 2017 at 06:38:23PM +0200, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/block/block_int.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--5/6IVfYouxg+lu1D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZY6P4AAoJEJykq7OBq3PIBVEH/0bVaP6SpF9JMjC/prWODkI6
ZqHGFGwSpxkldOV1VH3icT7kOJgL2uiDtNoMdgkboWSBMkp/mCJk4vLjE5rx1ZJE
1gA5gYFwVxjAGcCeP7Xx0GNjR0hjovjgagScqhNYx/dC5vpD32FJ+d6aJaflbMlq
SykP45du7ynOpYX8W1QzwVN2hk74+T6tKo2snJ2mDczNAkyTShiPPhh9bzCQmWpZ
P3UY7hGxcqthsu9wQOj2iJqgY1o+N8r2SUrWFm9TWiTmbuAdGSuwiDdVn7LTkpcy
Ct/79owTIs4FlbMV+1mvcvsTaDxvALNn0GXmRpsvom+oyRaCXQKnRwDCmzuxp58=
=G/OO
-----END PGP SIGNATURE-----

--5/6IVfYouxg+lu1D--
