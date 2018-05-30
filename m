Received: from eggs.gnu.org ([2001:4830:134:3::10]:45708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNxzv-0004Yu-RP
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNxzv-0005cT-1e
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:06:27 -0400
References: <20180529203910.7615-1-kwolf@redhat.com>
	<20180529203910.7615-10-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <886d1fbe-6d8b-300f-8598-264ef5ebd51f@redhat.com>
Date: Wed, 30 May 2018 12:06:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180529203910.7615-10-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6WULQhGGjY2xyOX8qxzUJxXvF7nAFe4Cr"
Subject: Re: [Qemu-devel] [PATCH v2 09/16] qemu-iotests: iotests.py helper
 for non-file protocols
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
--6WULQhGGjY2xyOX8qxzUJxXvF7nAFe4Cr
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, eblake@redhat.com,
 pkrempa@redhat.com, qemu-devel@nongnu.org
Message-ID: <886d1fbe-6d8b-300f-8598-264ef5ebd51f@redhat.com>
Subject: Re: [PATCH v2 09/16] qemu-iotests: iotests.py helper for non-file
 protocols
References: <20180529203910.7615-1-kwolf@redhat.com>
 <20180529203910.7615-10-kwolf@redhat.com>
In-Reply-To: <20180529203910.7615-10-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-29 22:39, Kevin Wolf wrote:
> This adds two helper functions that are useful for test cases that make=

> use of a non-file protocol (specifically ssh).
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--6WULQhGGjY2xyOX8qxzUJxXvF7nAFe4Cr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsOd5YACgkQ9AfbAGHV
z0AY3Af/fMIyQugBa4BaMwedMADbmQr4QHAOkvva8JWKq3hCxoun5uShMsDPViq6
Zaboq9bh+g3B0lC/UZWNiDOHQOfi4wjBjZcEF1T5LQ2oP8fsTw3UeL6r7PABwXlc
hZHdPwAqHwZZ3HkpBFxcE/pd4tMKPd/BzVhn8+1BD/CamO/vosnnXHvQj/FHUcPn
h166l145ypnZcM86gfSsYFzwXbACA55KQ0eJB+J2VE91+pYP32NSZguH6VSzstBF
01pfPpOqxRIU8IwsHuGpxYoNJCeGAteB03jqZkQGEO7nXbSt6/fNnZUKvT6J36Hv
VTwMvvBugEHkoFD6Echtq+7liBNrZQ==
=U7Ur
-----END PGP SIGNATURE-----

--6WULQhGGjY2xyOX8qxzUJxXvF7nAFe4Cr--
