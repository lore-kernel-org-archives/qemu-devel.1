Received: from eggs.gnu.org ([2001:4830:134:3::10]:46098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eozKT-00082S-LQ
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:27:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eozKS-0000cs-UA
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:27:05 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-11-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e8c6621c-08e8-0967-b9a8-f2c979249e77@redhat.com>
Date: Thu, 22 Feb 2018 23:26:42 +0100
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-11-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QR1KmfhAAEFxwxTKLAl3tfPNvNayxEQYJ"
Subject: Re: [Qemu-devel] [PATCH v2 10/36] test-qemu-opts: Test
 qemu_opts_to_qdict_filtered()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QR1KmfhAAEFxwxTKLAl3tfPNvNayxEQYJ
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <e8c6621c-08e8-0967-b9a8-f2c979249e77@redhat.com>
Subject: Re: [PATCH v2 10/36] test-qemu-opts: Test
 qemu_opts_to_qdict_filtered()
References: <20180221135404.27598-1-kwolf@redhat.com>
 <20180221135404.27598-11-kwolf@redhat.com>
In-Reply-To: <20180221135404.27598-11-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-21 14:53, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/test-qemu-opts.c | 125 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 125 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--QR1KmfhAAEFxwxTKLAl3tfPNvNayxEQYJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqPQ6ISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AJ8cH90glYpVZO/MqPPA/1Ab9jjEKKIajeDCd
7EG2/Kv8pD1FxuQRoqIQA2AaoAKkfBMb6Qzr4+zVPG25/qPThJXm0goqegxJ9gh5
oIwkw4gDh2Saaw3Vxv1Pg5vbnV3dG8VlLGHnmvHM/7E+DqCp6P9QWWgyFmyI2Nkp
2Cr5AwkE8aveDApHw/mCqQF50d/YdVqtYCJdbXhtiz7OjpD6IPOlDchUULkayrWt
fToJqsWGs9w743C+za3mfu8bJLnTzFkyT6JFQ28m3mGYxnRYNV9Jb/cSYeJZoUat
69nVxv2yVkyOiSLefwbQiFifJgMIDm9BNeV8r9ZqAzgRv9aF8mSPwQ==
=BkOk
-----END PGP SIGNATURE-----

--QR1KmfhAAEFxwxTKLAl3tfPNvNayxEQYJ--
