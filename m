Received: from eggs.gnu.org ([2001:4830:134:3::10]:32895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fO07k-0005e8-7R
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fO07j-0005AA-IJ
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:22:40 -0400
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
	<20180426161958.2872-8-rkagan@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6c8cf8e1-71da-f7e6-f74a-5f14dc604b4b@redhat.com>
Date: Wed, 30 May 2018 14:22:29 +0200
MIME-Version: 1.0
In-Reply-To: <20180426161958.2872-8-rkagan@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YJOt2M2TIy7zZ0TgraLGX8TIUWV7REyNu"
Subject: Re: [Qemu-devel] [PATCH 07/17] iotest 055: require blkdebug
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
--YJOt2M2TIy7zZ0TgraLGX8TIUWV7REyNu
From: Max Reitz <mreitz@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <6c8cf8e1-71da-f7e6-f74a-5f14dc604b4b@redhat.com>
Subject: Re: [PATCH 07/17] iotest 055: require blkdebug
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
 <20180426161958.2872-8-rkagan@virtuozzo.com>
In-Reply-To: <20180426161958.2872-8-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-26 18:19, Roman Kagan wrote:
> This test uses blkdebug extensively so notrun it if blkdebug is
> disabled in QEMU.
>=20
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> ---
>  tests/qemu-iotests/055 | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--YJOt2M2TIy7zZ0TgraLGX8TIUWV7REyNu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsOl4UACgkQ9AfbAGHV
z0Dn3gf/dI4Yj3b4KgD6iqk4wRCUkb/0ut80qAjPqIsDKILL62aMFJO1YujWj178
+NUopv9HbtzSzPdznPDQRNcYUuusZpXx0ecldD7RxhzzKpqAodw15/eEV+lPGtLt
9bg3YO/PgEAmFveqvKAMi+jeslcPDQs/YHx6ZQ1T5+CB6rZEGJObS8h3dMOKkDnC
kZjIaCL2L7RVKBg+qj0YVzMQt8Q8B/WZ2P0C6QB+d9OIutUfqXr+5vbZXkTfdV7Z
mmcNDTJcljVo597XEz3DP2XUg7BFYrBIw67NoE33UFwsGck93roXD+sJ2bY9g4Ia
8Y6gTYsQFjVFLAl4AG2cNsvWgYjPOg==
=5gus
-----END PGP SIGNATURE-----

--YJOt2M2TIy7zZ0TgraLGX8TIUWV7REyNu--
