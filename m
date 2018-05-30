Received: from eggs.gnu.org ([2001:4830:134:3::10]:32787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fO07O-0005LQ-I0
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fO07N-00054Y-Pd
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:22:18 -0400
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
	<20180426161958.2872-7-rkagan@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ee5f042f-955d-7b71-28a8-4aa44aaa8127@redhat.com>
Date: Wed, 30 May 2018 14:22:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180426161958.2872-7-rkagan@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BhZVhf3XUimZwxzA8s9wX2wEVfdp4aH5K"
Subject: Re: [Qemu-devel] [PATCH 06/17] iotest 055: skip unsupported backup
 target formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BhZVhf3XUimZwxzA8s9wX2wEVfdp4aH5K
From: Max Reitz <mreitz@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <ee5f042f-955d-7b71-28a8-4aa44aaa8127@redhat.com>
Subject: Re: [PATCH 06/17] iotest 055: skip unsupported backup target formats
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
 <20180426161958.2872-7-rkagan@virtuozzo.com>
In-Reply-To: <20180426161958.2872-7-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-26 18:19, Roman Kagan wrote:
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> ---
>  tests/qemu-iotests/055 | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--BhZVhf3XUimZwxzA8s9wX2wEVfdp4aH5K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsOl3EACgkQ9AfbAGHV
z0D6lwgAvEQdS56mWTdL6FcniJn3+aEbrdi7R3NoikIyEdH76h2LvNVx/B3zzKAV
eGA5C442w1IFEPGXBE5QiSiLD6YRwb8R7200c0ZEgo5xtM7A+OYXB9xL8llt1yzq
t1osD1upb+kzj6c1YC+VW6zuCcdRuATNg2DTBV7onGLJZURMGuYgeV7CX1asDbg/
RVIBXO3JrwZJDhXDH4dtYwMGrL5L3Fw55XcHe7NKGB4q2VlBw0JiJOaAeeg9B55s
J6YWfs8GaqB500PPW65seCoqji6jSHidmthyVOwVhivrbXxqaw6Ly6/LDYelLq1D
pOToQzShaGKFodUY6CKamtqVPIVa5A==
=c/Ah
-----END PGP SIGNATURE-----

--BhZVhf3XUimZwxzA8s9wX2wEVfdp4aH5K--
