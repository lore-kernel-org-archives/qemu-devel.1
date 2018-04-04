Received: from eggs.gnu.org ([2001:4830:134:3::10]:49432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3fnP-0002Jt-6m
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3fnM-0007aF-2X
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:37:39 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:34443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f3fnL-0007ZT-R9
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:37:35 -0400
Received: by mail-wr0-x229.google.com with SMTP id d17so6417739wre.1
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 03:37:35 -0700 (PDT)
Date: Wed, 4 Apr 2018 11:37:33 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180404103733.GN4467@stefanha-x1.localdomain>
References: <20180328173238.507470-1-vsementsov@virtuozzo.com>
	<20180328173238.507470-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dZihrQ6eCIduWT38"
Content-Disposition: inline
In-Reply-To: <20180328173238.507470-3-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] scripts/qemugdb: improve "qemu
 coroutine" command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com, den@openvz.org


--dZihrQ6eCIduWT38
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 28, 2018 at 08:32:36PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
>  - print regs
>  - catch exception for coredump debugging
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  scripts/qemugdb/coroutine.py | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--dZihrQ6eCIduWT38
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaxKrtAAoJEJykq7OBq3PIZ3AIALE1z25A8IJ6JPVdcEAovTm4
WNdWmf9Q3XLvHS9UAK16GDavpVy3IgLxlft2/weGB4G09MZaOaTKBqihzfnJPSDp
tj/llgMkQhW1ktH2SNKHDLd4vDOyooj9n6EIZRk2pcj/42JTJW101gM10+ub3TDG
52qcM+0sfnLzd9WQCrVcHaAJtTns3/CJJaHit89QJduLOaC3GF9KjAVwcOWGI66F
k10pa1ZS6QbL22y+znCQgFkaYXinG38rad6XybuJFvTpBKnCqE///PmEtVvxtCmr
IvOsIAQluRC4s5NYPmD8BM2oWpxSWcY1Rr63nfgg8GDLy3lw6tMbU7SmZnfVF/U=
=5dDd
-----END PGP SIGNATURE-----

--dZihrQ6eCIduWT38--
