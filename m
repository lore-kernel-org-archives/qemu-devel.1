Received: from eggs.gnu.org ([2001:4830:134:3::10]:43413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elILk-0005WM-MS
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elILi-0003FO-LK
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:57:08 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-28-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1cddfaec-b493-087c-477e-023c9d5fa8a8@redhat.com>
Date: Mon, 12 Feb 2018 18:56:40 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-28-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9LoBZevgw2qbiEC4HbhMTuh2IpWmVh28o"
Subject: Re: [Qemu-devel] [PATCH 27/27] qemu-iotests: Test ssh image
 creation over QMP
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
--9LoBZevgw2qbiEC4HbhMTuh2IpWmVh28o
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <1cddfaec-b493-087c-477e-023c9d5fa8a8@redhat.com>
Subject: Re: [PATCH 27/27] qemu-iotests: Test ssh image creation over QMP
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-28-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-28-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/207     | 261 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/207.out |  75 +++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 337 insertions(+)
>  create mode 100755 tests/qemu-iotests/207
>  create mode 100644 tests/qemu-iotests/207.out

Reviewed-by: Max Reitz <mreitz@redhat.com>


--9LoBZevgw2qbiEC4HbhMTuh2IpWmVh28o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqB1VgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AIHEH/jyjWgsNYqb95lth0buMGefkN9e97DC8
6jjfpFnTQGKHa+C+M54X6NKCkexHIGTqrX5Ext1U0qIryFQMuh9cjGGgsEZP60cM
v0pjIWKybXASAX5jr9MvLIJ4QPhcQpq3ZZP21DM8vz9Dou8Jtr69uZJpQ+w4YbyC
h3NdHqizFw8RtOAfXZnB57t4MV4/fUyn26YmgEJf3IOK6bS3idwrYgZmucOrFP1i
0+5iqgnULf0WRtlTeIONVP3A7Rr+sA23YfdJZX0JN3ismj/yRBkhsgU9eod8UtCx
/MStCQ1GywD4TWx4kfwNIZ5QwItrQjbj2X2gdZm64k7jN0Jz73fqOr4=
=I0hj
-----END PGP SIGNATURE-----

--9LoBZevgw2qbiEC4HbhMTuh2IpWmVh28o--
