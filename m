Received: from eggs.gnu.org ([2001:4830:134:3::10]:49117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egF1x-0004Rx-Uj
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egF1x-0004i6-5I
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:23:49 -0500
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-3-git-send-email-anton.nefedov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d7571ffa-1f55-c560-fd2c-c1fdb796835b@redhat.com>
Date: Mon, 29 Jan 2018 20:23:41 +0100
MIME-Version: 1.0
In-Reply-To: <1516297747-107232-3-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qviljc3QoXCqizLLGW0a5i1MIluJvd3WU"
Subject: Re: [Qemu-devel] [PATCH v7 2/9] blkverify: set supported write/zero
 flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qviljc3QoXCqizLLGW0a5i1MIluJvd3WU
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 den@virtuozzo.com, berto@igalia.com
Message-ID: <d7571ffa-1f55-c560-fd2c-c1fdb796835b@redhat.com>
Subject: Re: [PATCH v7 2/9] blkverify: set supported write/zero flags
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1516297747-107232-3-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1516297747-107232-3-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-18 18:49, Anton Nefedov wrote:
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/blkverify.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--qviljc3QoXCqizLLGW0a5i1MIluJvd3WU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpvdL0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AyEUH/j8y7cnil+X6N/8Kz+v2bYEi+QxUGJVr
yqOlwkMfddRuUYZas/jrq9/SOkCERfUeKqAFikiMjT+fOuOIyGfTjGzVTH5/h7yQ
iSefzk7RB8jQD87t63ciBHdMiCQlA2pjkPjsMrjCBj8CxevD7u41Q34grfHpc8om
He75eYkeV3mUMm0b1BqogVpitbHxEHdJ0TxVXK0IzXrLBMsYg3eT69u1Xogn7u25
mL8SF6Kmfufc86DWyOW/klNy5n5Icfb+W7mcdljab6gmfeh1DwTfneQYEORDsFLH
Tmg2q4mLB4ccmodC/o3kRb48ZPtsG3iXVK8C1JIfXxGLgFOWm1Cl788=
=WrgG
-----END PGP SIGNATURE-----

--qviljc3QoXCqizLLGW0a5i1MIluJvd3WU--
