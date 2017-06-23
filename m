Received: from eggs.gnu.org ([2001:4830:134:3::10]:51284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dOLKB-00016q-Ka
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 05:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dOLKA-0002fb-NX
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 05:56:23 -0400
Date: Fri, 23 Jun 2017 10:56:12 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170623095612.GC12689@stefanha-x1.localdomain>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
	<20170622124204.19407-8-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline
In-Reply-To: <20170622124204.19407-8-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/31] dmg: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:dmg" <qemu-block@nongnu.org>


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2017 at 02:41:40PM +0200, Marc-Andr=E9 Lureau wrote:
> I used the clang-tidy qemu-round check to generate the fix:
> https://github.com/elmarco/clang-tools-extra
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  block/dmg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZTOW8AAoJEJykq7OBq3PIfD8IAKjE20MaDcAMJWe6UdtpI4A/
/XBnPlKDjDycg2T85kEtPSUCIZE1BIeQh6vX8+QefH6H1Q8UI5l5thgF6upbMLub
6KXXvdzIipleT7hrl6oDHHjsu3nYQgsMa3yYxH36IZEI5G0KByYpreL8WwNU7NzR
B6g/FCKCMoj1PUCB2qqMH4QBv9qsJ/bm5mMqXFy+fAs0qVjrtWSsq/nvas2crftU
WZpS8j2HnpE5vuQPpH5hhCYpHD3YjujTIDXOUvh/6nnk9z8XbfgSdtfdGSN+zJ0O
dgU/rMKASHQOqnHm8J9kjByVps5WIKdBgAw0y69XEHtLMVvviJ3392ehG3K/w2k=
=KJon
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
