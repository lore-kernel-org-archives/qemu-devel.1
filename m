Received: from eggs.gnu.org ([2001:4830:134:3::10]:34174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBk52-0002IX-Gi
	for qemu-devel@nongnu.org; Fri, 19 May 2017 11:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBk4y-00022b-Ar
	for qemu-devel@nongnu.org; Fri, 19 May 2017 11:44:40 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dBk4y-00022N-4n
	for qemu-devel@nongnu.org; Fri, 19 May 2017 11:44:36 -0400
Received: by mail-wm0-x244.google.com with SMTP id b84so3187384wmh.0
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 08:44:35 -0700 (PDT)
Date: Fri, 19 May 2017 16:44:33 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170519154433.GC30573@stefanha-x1.localdomain>
References: <20170519084830.2674-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Content-Disposition: inline
In-Reply-To: <20170519084830.2674-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/1] ui: egl-headless requires dmabuf support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2017 at 10:48:29AM +0200, Gerd Hoffmann wrote:
>   Hi,
>=20
> Little single-patch pull request to fix a build issue.
>=20
> please pull,
>   Gerd
>=20
> The following changes since commit 56821559f0ba682fe6b367815572e6f974d329=
ab:
>=20
>   Merge remote-tracking branch 'dgilbert/tags/pull-hmp-20170517' into sta=
ging (2017-05-18 13:36:15 +0100)
>=20
> are available in the git repository at:
>=20
>   git://git.kraxel.org/qemu tags/pull-ui-20170519-1
>=20
> for you to fetch changes up to 371ec54e9f8415cd74af45acdcf67b413f50cce5:
>=20
>   ui: egl-headless requires dmabuf support (2017-05-19 10:46:00 +0200)
>=20
> ----------------------------------------------------------------
> ui: egl-headless requires dmabuf support
>=20
> ----------------------------------------------------------------
> Gerd Hoffmann (1):
>       ui: egl-headless requires dmabuf support
>=20
>  vl.c             | 4 ++--
>  ui/Makefile.objs | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZHxLhAAoJEJykq7OBq3PIyy4IALocP1xM7x6DMbuhKr5u08PU
ePFUDT83mekZC/VzbJeFKn9lbpFF1imLPuD+oa6ui9etGCm0YdBM0uoVQ8/W7UWc
9f6kjrbOlyOZOnyVgqHcxx8uPc2JOunV7k3Ry2aXB9jm9drUYGcWQDc49xvwzohX
s+ZPHii10FsXAEfysuPx/Lir5xDxEjy6dy6v+Y4TfWNFqphAjMfnv1VAGB/E9zbh
/Fg1q5FwJZewf8GGzzOjuJwPEA1zsG9cvYVd2mZ7kEpFa7Yu6lFOjq8xwKqCzZGX
RFm7u+mcWCp4BLme86hYgevOUaU/igJVW7WGAum2sRVpdC3FjHvcmkLbY9SFF38=
=fplC
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--
