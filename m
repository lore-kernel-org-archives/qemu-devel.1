Received: from eggs.gnu.org ([2001:4830:134:3::10]:44956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eozDs-0006an-SW
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eozDs-0005xL-36
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:20:16 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-10-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d9934c0e-5959-bb2c-175d-722da3bce4e3@redhat.com>
Date: Thu, 22 Feb 2018 23:19:53 +0100
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-10-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NwpjYBxnWDnblM8zVct7dOudwQiX4EUIF"
Subject: Re: [Qemu-devel] [PATCH v2 09/36] test-qemu-opts: Test
 qemu_opts_append()
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
--NwpjYBxnWDnblM8zVct7dOudwQiX4EUIF
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <d9934c0e-5959-bb2c-175d-722da3bce4e3@redhat.com>
Subject: Re: [PATCH v2 09/36] test-qemu-opts: Test qemu_opts_append()
References: <20180221135404.27598-1-kwolf@redhat.com>
 <20180221135404.27598-10-kwolf@redhat.com>
In-Reply-To: <20180221135404.27598-10-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-21 14:53, Kevin Wolf wrote:
> Basic test for merging two QemuOptsLists.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/test-qemu-opts.c | 128 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 128 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--NwpjYBxnWDnblM8zVct7dOudwQiX4EUIF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqPQgkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AGIkH/R//Pi4gOCpjbsN69t2/8vKxbNfNTnvG
mAj+FaW09uMoVsipv5OB47uYTMCVvSVHnotZLE+Qrqn8VLL070X2SwQ1TgbXWwC6
OlwbVtCZiqq1F5Jszi3xZxP71XWOKU14cm0SQ3J6seT0uaF4qneI+Zb/qPYxDEaX
HF2haGwwAviQ7vKUTGV/Hg3+M4bCzxgXYWj57RmkKxZoOH38zteVk7F47mH5Djou
dE+md+3hlAK6M55n23YZkQizOHHH35tSlnVCy4hzOesOyzPXf1wDeNl1QRxIEulq
S+V1fBpWP6wMzZnyQfiUdmgIJTqJyPiMW5EA4xf8dwoE9lByO5t0v0g=
=XrU5
-----END PGP SIGNATURE-----

--NwpjYBxnWDnblM8zVct7dOudwQiX4EUIF--
