Received: from eggs.gnu.org ([209.51.188.92]:59877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gp3Es-0003LP-7y
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 22:42:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gp3Eq-0001jd-Ix
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 22:42:05 -0500
References: <20190131010136.12007-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <517c0577-320e-83fc-714a-19217b457a30@redhat.com>
Date: Wed, 30 Jan 2019 21:41:52 -0600
MIME-Version: 1.0
In-Reply-To: <20190131010136.12007-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1P5rASlVtU6OtTO68RXYUJvK2iD2dWtBJ"
Subject: Re: [Qemu-devel] [PATCH] block/dirty-bitmap: Documentation and
 Comment fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1P5rASlVtU6OtTO68RXYUJvK2iD2dWtBJ
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 vsementsov@virtuozzo.com, Fam Zheng <fam@euphon.net>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <517c0577-320e-83fc-714a-19217b457a30@redhat.com>
Subject: Re: [PATCH] block/dirty-bitmap: Documentation and Comment fixups
References: <20190131010136.12007-1-jsnow@redhat.com>
In-Reply-To: <20190131010136.12007-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/30/19 7:01 PM, John Snow wrote:
> The meaning of the states has changed subtly over time,
> this should bring the understanding more in-line with the
> current, actual usages.
>=20
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/dirty-bitmap.c | 19 +++++++++++++------
>  qapi/block-core.json | 17 ++++++++++++-----
>  2 files changed, 25 insertions(+), 11 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--1P5rASlVtU6OtTO68RXYUJvK2iD2dWtBJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxSboAACgkQp6FrSiUn
Q2p9nQgAhUQcZE4Qo9UQU7Y+a5q4vNKlalQGRFrmEcPB/3P4joOEylnAeymy/MX2
OKw0zAf3dMr178wE8YkoPyWKbZu6QIq9cRsgbhQfSQSNc0I80/GAC6yJ7vmhPM79
Ok/E3id3c09iHODsGzRbhwawmWiGYEccFWaXmU7hkWUy+z/xdfSsvXZvw0Xkk6iR
36x4ynLb+lZB7fF9izVroqncIWX79FBUxokBPc9Rygs4KtNZFY17ggH/a8bT85mf
PgFcy5x2Wuw6pJwmV236kZ3rBkyqr8NwhT70dbHqVF/rR2NxUtk4TJOwtbDnwDFh
Te/SfZgeayMgl8Ax8dcuAWlCM0CuJw==
=Jm+j
-----END PGP SIGNATURE-----

--1P5rASlVtU6OtTO68RXYUJvK2iD2dWtBJ--
