Received: from eggs.gnu.org ([2001:4830:134:3::10]:59303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccknJ-0006u3-Jx
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 22:25:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccknI-0004oj-HC
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 22:25:45 -0500
References: <20170203094018.15493-1-vsementsov@virtuozzo.com>
	<20170203094018.15493-24-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1537930b-216c-831f-7daf-239806bb4f22@redhat.com>
Date: Sun, 12 Feb 2017 04:25:34 +0100
MIME-Version: 1.0
In-Reply-To: <20170203094018.15493-24-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5h7xEIvVL3FpkRACRBHdQxHf9euJV6Xon"
Subject: Re: [Qemu-devel] [PATCH 23/24] qcow2: add
 .bdrv_remove_persistent_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5h7xEIvVL3FpkRACRBHdQxHf9euJV6Xon
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <1537930b-216c-831f-7daf-239806bb4f22@redhat.com>
Subject: Re: [PATCH 23/24] qcow2: add .bdrv_remove_persistent_dirty_bitmap
References: <20170203094018.15493-1-vsementsov@virtuozzo.com>
 <20170203094018.15493-24-vsementsov@virtuozzo.com>
In-Reply-To: <20170203094018.15493-24-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.02.2017 10:40, Vladimir Sementsov-Ogievskiy wrote:
> Realize .bdrv_remove_persistent_dirty_bitmap interface.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-bitmap.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  block/qcow2.c        |  1 +
>  block/qcow2.h        |  3 +++
>  3 files changed, 45 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--5h7xEIvVL3FpkRACRBHdQxHf9euJV6Xon
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlif1a4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Aam4H/isGDvmrqfoBIMVmDdA2L7tdiX7MfV30
y5gcP64niA5iAr889kAUhrxlGBYTNW1LTnllkJLk4impeiYVQuc0i2hv7WIdEUGU
H3+BFkC+S93AzQc8JTdpsZB4cXNCJ0rHcJ37q6ckW5FYP55UAfgM6D2BZ3SuccXK
4Tr2KB4yLOh4We1433DD21noD72t+/SEa1u58WZy3EP1mLbzyYp0hoRHRoLmITcT
u+nRlJGq14NmJr36M2wiiS7ZQh+CJhEVb9roXzEHNAsYhmM4/tAL5jWRtPH7HlZF
edBa0y1jgKe+VDw4fvnRdpAzZQkGgQC0tr/WHm2brihyPNRWk9T5Zg4=
=0wWA
-----END PGP SIGNATURE-----

--5h7xEIvVL3FpkRACRBHdQxHf9euJV6Xon--
