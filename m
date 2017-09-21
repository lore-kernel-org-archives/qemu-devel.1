Received: from eggs.gnu.org ([2001:4830:134:3::10]:35981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dv3P6-0005V3-6I
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dv3P5-0004h5-EX
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:28:40 -0400
References: <20170920135833.20472-1-pbutsykin@virtuozzo.com>
	<20170920135833.20472-2-pbutsykin@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fae814ca-002b-fd3f-88ec-49f4729ca37f@redhat.com>
Date: Thu, 21 Sep 2017 17:28:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170920135833.20472-2-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="COWTdeMRSbTOKVl4pSnJv6NiM2CKWn5rJ"
Subject: Re: [Qemu-devel] [PATCH 1/2] qcow2: fix return error code in
 qcow2_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--COWTdeMRSbTOKVl4pSnJv6NiM2CKWn5rJ
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, den@openvz.org
Message-ID: <fae814ca-002b-fd3f-88ec-49f4729ca37f@redhat.com>
Subject: Re: [PATCH 1/2] qcow2: fix return error code in qcow2_truncate()
References: <20170920135833.20472-1-pbutsykin@virtuozzo.com>
 <20170920135833.20472-2-pbutsykin@virtuozzo.com>
In-Reply-To: <20170920135833.20472-2-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-20 15:58, Pavel Butsykin wrote:
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> ---
>  block/qcow2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--COWTdeMRSbTOKVl4pSnJv6NiM2CKWn5rJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnD2p4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A9L0H/0oVAWF3ITEa+XzK/PT+2m0ZrheCajXa
JcFwBgj1RXZY6CWglhpN4r5lACj5Ie2d/qH3ex0GohEfCbH3rru4c+6Q0s5YHNhQ
63tvgC8Z64E4FjcXP0bIaXTdtVw017uNlKOm0O5SQG3dktARApD6lnuPAFf24Gbs
R0gjx1BQaIZvVZEPYazg0B0XVuG9MI7OfWWVvt94DpqNBVD0LQpARUEVUVBI9WuQ
ap8OzV+6h71PVVDBpRtBB5A/Nc3wp4dEZvtNHT+o+QeB7SN/qBGfsOx6oA58mv9h
zHL47QLkCeHuSmLMa/nEUuYx4r4Z/dj8SOxVp0N3mUQoNjZe8VPb6do=
=lNpl
-----END PGP SIGNATURE-----

--COWTdeMRSbTOKVl4pSnJv6NiM2CKWn5rJ--
