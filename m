Received: from eggs.gnu.org ([209.51.188.92]:51365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3XX7-0006zS-8W
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 22:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3XX5-0003iy-UX
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 22:52:49 -0400
References: <20190311165017.32247-1-kwolf@redhat.com>
	<20190311165017.32247-3-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <81c61c09-2a8d-c5bb-7a9d-bdab04b77317@redhat.com>
Date: Mon, 11 Mar 2019 21:52:39 -0500
MIME-Version: 1.0
In-Reply-To: <20190311165017.32247-3-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="p5SQI68WGYwaFbUVVdRXVC6pgWfrEEHnH"
Subject: Re: [Qemu-devel] [PATCH v2 02/10] qemu-iotests: commit to backing
 file with auto-read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, berto@igalia.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p5SQI68WGYwaFbUVVdRXVC6pgWfrEEHnH
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, berto@igalia.com,
 qemu-devel@nongnu.org
Message-ID: <81c61c09-2a8d-c5bb-7a9d-bdab04b77317@redhat.com>
Subject: Re: [PATCH v2 02/10] qemu-iotests: commit to backing file with
 auto-read-only
References: <20190311165017.32247-1-kwolf@redhat.com>
 <20190311165017.32247-3-kwolf@redhat.com>
In-Reply-To: <20190311165017.32247-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/11/19 11:50 AM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/232     | 31 +++++++++++++++++++++++++++++++
>  tests/qemu-iotests/232.out | 20 ++++++++++++++++++++
>  2 files changed, 51 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--p5SQI68WGYwaFbUVVdRXVC6pgWfrEEHnH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyHHvcACgkQp6FrSiUn
Q2pQFgf8DcEvzNVgIVHaAFhqWFbjAzfowQqK6EU56Uok8l3ufp1uAcKEdEBxEuvC
U1e40HSbjgVbn6QxBqcnzGg11H+T6c2RjmZ1EFlnYHDaLdifvY+islYRVVM5E2R4
YybavrKbMD/YF7aLkP1or4EcxL7oryq6k7eddrUW1gdzi4R4lFBiDPgixMP4RMqN
BR/aiN6fmc+QxnNNvZO42KXr+Znjqa0u3V2eZiJ8l/t3fKH4irzQSxuIcLescRoU
k1/ENWKohnYe4yr2d281rzKK+QIoI4ExjiWawph7GFVP+cqetOhiiT8mC+8AMYL/
4trH05x1aytDQNed5t8L7KLU6lK+vw==
=bBRh
-----END PGP SIGNATURE-----

--p5SQI68WGYwaFbUVVdRXVC6pgWfrEEHnH--
