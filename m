Received: from eggs.gnu.org ([2001:4830:134:3::10]:46677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1essPA-0005jt-46
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:52:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1essP9-0003cg-E9
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:52:00 -0500
References: <20171225025107.23985-1-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4bd55f52-5737-f9a8-4ef7-a9b30d00f93a@redhat.com>
Date: Mon, 5 Mar 2018 16:51:42 +0100
MIME-Version: 1.0
In-Reply-To: <20171225025107.23985-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ALkLnbDCaF7WJBOWbVXiNceccgiOVbiyq"
Subject: Re: [Qemu-devel] [PATCH v2] iotests: Test creating overlay when
 guest running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ALkLnbDCaF7WJBOWbVXiNceccgiOVbiyq
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <4bd55f52-5737-f9a8-4ef7-a9b30d00f93a@redhat.com>
Subject: Re: [PATCH v2] iotests: Test creating overlay when guest running
References: <20171225025107.23985-1-famz@redhat.com>
In-Reply-To: <20171225025107.23985-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-25 03:51, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
>=20
> ---
>=20
> v2: Actually test the thing. [Kevin]
> ---
>  tests/qemu-iotests/153     | 8 +++++---
>  tests/qemu-iotests/153.out | 7 ++++---
>  2 files changed, 9 insertions(+), 6 deletions(-)

Thanks, applied to my block tree:

https://github.com/XanClic/qemu/commits/block

Max


--ALkLnbDCaF7WJBOWbVXiNceccgiOVbiyq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqdZ44SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A78MIAKUJl9LD4Ik755aujWozCyRxA3Xas693
hbcJRRL/e2+2UWciJsXCUm40H5aC0J1GGZVXqkD5O8i+2fAE09ui0xv7sa9YGEN9
a6NL2+qkWoLpqHEqhzqXaqZjN2QZ1d7X6+pCrYsmHnW5V/XDbggmXxfXP1Da324Q
npPLi2HgJx0MMaIULoJ0mr4LMyZqtSHlMwjohDRsXrkro4ZR0fph8tnbdyoqTQ9X
e6UacZBezLt6YwibTDfgNnbp9KRGAn1RpplR+iGjA68HIjAV1P72NrXB4YSoXpWG
21YtY9xVDMxByxl3KnIPMV0FpQ0hNxpvXap+i9UItx+6m60sALbmnmU=
=r/aZ
-----END PGP SIGNATURE-----

--ALkLnbDCaF7WJBOWbVXiNceccgiOVbiyq--
