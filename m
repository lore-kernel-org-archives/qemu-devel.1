Received: from eggs.gnu.org ([2001:4830:134:3::10]:45564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dAJoG-0004pS-AH
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:29:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dAJoF-0003n2-El
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:29:28 -0400
References: <20170515103551.31313-1-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d5702e65-8c1b-35b3-6670-a2e344cdfb9c@redhat.com>
Date: Mon, 15 May 2017 19:29:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170515103551.31313-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="h6TbEOeuvijM8WUusDGLoogJX7XkkcUlB"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Fix documentation of convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h6TbEOeuvijM8WUusDGLoogJX7XkkcUlB
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <d5702e65-8c1b-35b3-6670-a2e344cdfb9c@redhat.com>
Subject: Re: [PATCH] qemu-img: Fix documentation of convert
References: <20170515103551.31313-1-famz@redhat.com>
In-Reply-To: <20170515103551.31313-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-15 12:35, Fam Zheng wrote:
> It got lost in commit a8d16f9ca "qemu-img: Update documentation for -U"=
=2E
>=20
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  qemu-img-cmds.hx | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks!

Applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--h6TbEOeuvijM8WUusDGLoogJX7XkkcUlB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZGeVlEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQKOw
B/9/Oq/jx0cq6iFjP2GkcsQWwu5OZZXEvVJ6KBaPpHMDKEpwVGDGq29oAh8Qrg8s
ZF5AdfSE2DLDcrojvUcpzG4tZtV+TwP62s1mdvwW1FFzhEhQuTTh5gzJ4T2AoB5B
EnQDmXDdj8TKH0l+OeQDxJIw+7yI3aK6Ji6EQeW/RzaepLDHt22DpJ/CJVL85MeA
Br3noKdF/CPY6HntcfaEZHgYLCCHARV+NHV+lOK5yiPM5rsWkMah6oCqE96yj1XN
0onq3ef30cOzBPIsCFfcgoTHnY7i4JCzpZZ/yhyIDHelbMtowh6GxBkiEaX+13qs
3PNekBhFaptaQtPminB2jtUU
=4IlJ
-----END PGP SIGNATURE-----

--h6TbEOeuvijM8WUusDGLoogJX7XkkcUlB--
