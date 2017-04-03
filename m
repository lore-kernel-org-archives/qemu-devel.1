Received: from eggs.gnu.org ([2001:4830:134:3::10]:37379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cv7mj-0002Wb-DY
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cv7mi-0008OE-GQ
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:37:05 -0400
References: <20170403175150.15253-1-mreitz@redhat.com>
	<20170403175150.15253-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f8de8ac5-845d-90de-1ed1-7ad8ee11fa0c@redhat.com>
Date: Mon, 3 Apr 2017 14:36:55 -0500
MIME-Version: 1.0
In-Reply-To: <20170403175150.15253-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="G0ckjOGJ5mi81krQtQJXh0jGenFjpnw1P"
Subject: Re: [Qemu-devel] [PATCH for-2.9 2/2] iotests: Add mirror tests for
 orphaned source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G0ckjOGJ5mi81krQtQJXh0jGenFjpnw1P
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <f8de8ac5-845d-90de-1ed1-7ad8ee11fa0c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 2/2] iotests: Add mirror tests for
 orphaned source
References: <20170403175150.15253-1-mreitz@redhat.com>
 <20170403175150.15253-3-mreitz@redhat.com>
In-Reply-To: <20170403175150.15253-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/03/2017 12:51 PM, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/041        | 46 +++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/041.out    |  4 ++--
>  tests/qemu-iotests/iotests.py | 15 ++++++++++++++
>  3 files changed, 63 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--G0ckjOGJ5mi81krQtQJXh0jGenFjpnw1P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY4qRYAAoJEKeha0olJ0NqSfkH+wSVrn0n5IamljBzQm6vzk86
3kkSDpO6wdeqfoOw1JqTlyqqZ5ErKilvlTOSxhqDQlKiBN83txWrYtPVbJf3vH4A
fyNniFsv7j3ewhPdCkTSKMBpQ7Pif7cXuBoSQJNbXQt7dDXGXc9ZcFK4CKoCtnOE
VUHRZOODeScGTHqzYgY0waaw5okBjDRsAfQuJei8v3gsNFgJZgtNeEP0wfBvKVXS
S+UAZ5bZDX9IvBX2aaMAT5TOyo/MdCMQveb1kJql8lBo9Fj4PfE0Cltq9f8K2Gyp
0IhMtNdRcXayY1nOI/BSnuYEPVaTsAgUcrEhbTw6rxYan6DuJeuxEN15hAuUi6g=
=baOL
-----END PGP SIGNATURE-----

--G0ckjOGJ5mi81krQtQJXh0jGenFjpnw1P--
