Received: from eggs.gnu.org ([2001:4830:134:3::10]:43853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNxqz-0001P6-1o
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNxqy-0002gc-BU
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:57:13 -0400
References: <20180529203910.7615-1-kwolf@redhat.com>
	<20180529203910.7615-7-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d2d98db9-972c-8cb5-7bc3-38701bb9a7b0@redhat.com>
Date: Wed, 30 May 2018 11:57:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180529203910.7615-7-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aRax7GPEmqvVnYfVehyZ5r4BIFKj7Awov"
Subject: Re: [Qemu-devel] [PATCH v2 06/16] qemu-iotests: Add VM.qmp_log()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aRax7GPEmqvVnYfVehyZ5r4BIFKj7Awov
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, eblake@redhat.com,
 pkrempa@redhat.com, qemu-devel@nongnu.org
Message-ID: <d2d98db9-972c-8cb5-7bc3-38701bb9a7b0@redhat.com>
Subject: Re: [PATCH v2 06/16] qemu-iotests: Add VM.qmp_log()
References: <20180529203910.7615-1-kwolf@redhat.com>
 <20180529203910.7615-7-kwolf@redhat.com>
In-Reply-To: <20180529203910.7615-7-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-29 22:39, Kevin Wolf wrote:
> This adds a helper function that logs both the QMP request and the
> received response before returning it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Jeff Cody <jcody@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--aRax7GPEmqvVnYfVehyZ5r4BIFKj7Awov
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsOdW4ACgkQ9AfbAGHV
z0AUKQf8DQyQpp62e6529lWqp2zohL8ZhBYNT/llnK5Ko5XfUZaVLMtyjbDKMady
hly35ew8Ax80OZKNGSXxGGiq5O7i2545NH+t0+tPKGmBJYBKsMf65MJ7a9szxuE/
YJDlvStnOBBIK9yl42fFiuH4luqxcGOtibez5UDgysOycIa8LC9uKz9iugVuaBrS
UJKilVYXbOBvC2O73F6y0Q59A4tjGNjrw07zZe4YK+TTMBz9TqHIQhB8gT6E5e+r
ki0CI4PbVdS//GwbB5L344iQXBCKmtA4pTGIFen6cmqvIncy/COMaH7PT9dCJhXF
YANaRDXCSnCHdYQW81935r2kWgewlA==
=NLdp
-----END PGP SIGNATURE-----

--aRax7GPEmqvVnYfVehyZ5r4BIFKj7Awov--
