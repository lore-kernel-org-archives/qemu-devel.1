Received: from eggs.gnu.org ([2001:4830:134:3::10]:51235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dedYX-0003wc-Cg
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dedYT-0005NF-H1
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:38:33 -0400
Date: Mon, 7 Aug 2017 09:38:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170807083825.GB3191@stefanha-x1.localdomain>
References: <20170804152655.31510-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline
In-Reply-To: <20170804152655.31510-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: drop bdrv_set_key from
 BlockDriver
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


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2017 at 05:26:55PM +0200, Paolo Bonzini wrote:
> This is not used anymore since c01c214b69 ("block: remove all encryption
> handling APIs", 2017-07-11).
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/block/block_int.h | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZiCcBAAoJEJykq7OBq3PIFjgH/jh166H8fWXzQFMVMHsN+bwb
3b95bFh5sWlRAgahew4y0kWWFPD1+3NB1XHiduu35U9z/XmktakG0omBSOtgQQiD
R2hlhYEYEzhnqpmpkVgH6HyW/ye6h+43L0UyAGvCscn18et/EBn0llOFEyq4NObp
k3Vxn8uk+G3Lab0e1/M7kYEzdodd/eK9PxL7w+YJNZk0pt86YRJKsgJ1ButCxYR0
B4OrFhyfCIrv7JnmNwnkfHKy/5K1MvamouUzQwA7zjGlHBo62/7izjp1wtSouSsA
tI3lEW55pz1LS/kU+xRz/Oj5JLZl3L1OW7kCOxCrSV0XXuZndDnm8FzkIBkiq44=
=fjN4
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
