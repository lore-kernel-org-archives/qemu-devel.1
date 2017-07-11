Received: from eggs.gnu.org ([2001:4830:134:3::10]:45413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dV0Ii-00051G-0N
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dV0Ie-00010O-VS
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:54:24 -0400
Date: Tue, 11 Jul 2017 19:53:15 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170711185315.GJ31231@stefanha-x1.localdomain>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-16-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6THr7QwYWIbrk6Kt"
Content-Disposition: inline
In-Reply-To: <20170704220346.29244-16-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 15/35] backup: mark
 coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "open list:Block Jobs" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>


--6THr7QwYWIbrk6Kt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 12:03:26AM +0200, Marc-Andr=E9 Lureau wrote:
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/block/block_backup.h | 4 ++--
>  block/backup.c               | 9 ++++++---
>  2 files changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6THr7QwYWIbrk6Kt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZR6bAAoJEJykq7OBq3PIeXgIAJuIYZsuJAeaPWNupFKoQx+3
FfKBymS3KLIcVJVYPJ92yAEhY1GQiF+lJV7T5ykg7sLJToLrtfarummePDh2fLkm
E04SCdnmqWPkWI84l3AkD136z49sPgNPFUIn+M0U3RRFPKGMiqCLVFfYzq1HOeKZ
tbXf3k7nSBLoG9LYhH4HJ62RN4OZLWhLHViciWtqOr/MLpYJjalCetu2WcUH6ScU
9+pXWWTg3iD+r7fI41ssyfSmiidAjWxwMYUX/m79HY7kQPl9dMWDEc2wsJ2OAp/R
VZLIbU74x4DaZswY1t7JUHQatK+WA/4VjEdVl91QqVDWHQF8d4C1dQy2a7Usp6E=
=/zf3
-----END PGP SIGNATURE-----

--6THr7QwYWIbrk6Kt--
