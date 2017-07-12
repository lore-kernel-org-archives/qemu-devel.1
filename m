Received: from eggs.gnu.org ([2001:4830:134:3::10]:56050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVEz7-0003nd-No
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVEz7-0008OQ-3M
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:35:09 -0400
Date: Wed, 12 Jul 2017 11:35:00 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170712103500.GE6923@stefanha-x1.localdomain>
References: <20170711163748.17817-1-el13635@mail.ntua.gr>
	<20170711163748.17817-3-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G6nVm6DDWH/FONJq"
Content-Disposition: inline
In-Reply-To: <20170711163748.17817-3-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v4 2/4] block: remove bdrv_media_changed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, qemu-block <qemu-block@nongnu.org>


--G6nVm6DDWH/FONJq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2017 at 07:37:46PM +0300, Manos Pitsidianakis wrote:
> This function is not used anywhere, so remove it.
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block.c                   | 14 --------------
>  block/raw-format.c        |  6 ------
>  include/block/block.h     |  1 -
>  include/block/block_int.h |  1 -
>  4 files changed, 22 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--G6nVm6DDWH/FONJq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZftUAAoJEJykq7OBq3PI6SIH/2sSacvFZ3XeGUvscD4zZUZU
WJw4NsznsgKYfaFKoiblvSeoXrF6ZKIhlYUK6fS4ec+gEaS/kWUG+7Rgp7579ZGG
nLFY3vL+Ve+usN1JgKOBysUWsgR4LfNL/2yxbBI58pIUDlbG05LHZFRW0wvS+jay
deeHFbXWKadzaTz+znxuy83kBhYyfDVaYjmgh1DvYwfW06Gh0RsAphLpnt/5MxZD
OFqrUH34JjWcvcP7CBvr6M2J+XQVH5+xqEhoUZVf5SGUrKDayaOy3DGRJCi93lDv
R+Z3Y3mloWXkyRoGC9+R6pivZNU7I0aX7UOmGihtKvobJ/fVp3xG404dTJzlP1M=
=ZeUR
-----END PGP SIGNATURE-----

--G6nVm6DDWH/FONJq--
