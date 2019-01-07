Received: from eggs.gnu.org ([209.51.188.92]:59594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ggZKw-0003K6-2L
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:09:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ggZKv-0003j6-1w
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:09:18 -0500
References: <20181221170909.25584-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <022ab924-5082-ffc7-9e1d-8633e1a8aa91@redhat.com>
Date: Mon, 7 Jan 2019 18:31:04 +0100
MIME-Version: 1.0
In-Reply-To: <20181221170909.25584-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7iTQoughzVuT7TKqiyfX2DNiaPZO69pGu"
Subject: Re: [Qemu-devel] [PATCH v6 0/3] block nodes graph visualization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, ehabkost@redhat.com, crosa@redhat.com, den@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7iTQoughzVuT7TKqiyfX2DNiaPZO69pGu
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com,
 ehabkost@redhat.com, crosa@redhat.com, den@virtuozzo.com
Message-ID: <022ab924-5082-ffc7-9e1d-8633e1a8aa91@redhat.com>
Subject: Re: [PATCH v6 0/3] block nodes graph visualization
References: <20181221170909.25584-1-vsementsov@virtuozzo.com>
In-Reply-To: <20181221170909.25584-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.12.18 18:09, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
>=20
> On the way of backup schemes development (and in general any complicate=
d
> developments in Qemu block layer) it would be good to have an ability t=
o print
> out graph of block nodes with their permissions.

Thanks, applied patches 1 and 2 to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--7iTQoughzVuT7TKqiyfX2DNiaPZO69pGu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlwzjNgACgkQ9AfbAGHV
z0BPkgf/XgIeieyDhmhnt2XBq3jEMkU9QjYRQixEJSQn+WmrXL4xkHrcKgQandRe
gGjYfobD0Uh8RxW9VGlLVYSD5DsKP/EuGSji5EAzd72SiSsRjlVirSJmOnVc45MS
Em/fAOOZx7h6AvEZLAKq2PVLBOHiUO+XdLdR7S6tZoF9yS3j8j2WWIGinIkNfe+P
TTgbHHB2bAs9ZR7JYUbmgDLcrqx+J12slE1MdmjW3RWcCuiND7plgg2cw0XWHx9U
ew5N525bKlSnMkZEIvQI36YtBIglQFgNFVa4iyHckS5BmLgjtWr62Ohqb2sQJ6ZQ
Bq1jm5q27WHx8wU35TL02RXKArkXcg==
=r1Jr
-----END PGP SIGNATURE-----

--7iTQoughzVuT7TKqiyfX2DNiaPZO69pGu--
