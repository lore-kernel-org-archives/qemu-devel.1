Received: from eggs.gnu.org ([2001:4830:134:3::10]:58262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1edcZO-00062K-6v
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 08:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1edcZM-00065R-Mf
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 08:55:29 -0500
Date: Mon, 22 Jan 2018 13:55:19 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180122135519.GF31621@stefanha-x1.localdomain>
References: <20180112090122.1702-1-klim.kireev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w3uUfsyyY1Pqa/ej"
Content-Disposition: inline
In-Reply-To: <20180112090122.1702-1-klim.kireev@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 0/5 v3] preparation for Parallels Disk xml
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Klim Kireev <klim.kireev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@openvz.org, qemu-block@nongnu.org, mreitz@redhat.com


--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2018 at 12:01:17PM +0300, Klim Kireev wrote:
> Parallels Desktop and Parallels Cloud Server uses images glued with the
> bundle description in XML format. This series contains very basic
> description of this XML files and makes preparations for actual
> implementation to be followed.
>=20
> Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
> Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
>=20
> Changelog:
>=20
> v2:
> PATCH 1/5: Fix some places noticed by Stefan Hajnoczi <stefanha@redhat.co=
m>
> PATCH 2/5: Rebase to upstream
> PATCH 3/5: Fix includes
>=20
> v3:
> PATCH 1/5: Fix the place about GUID, add emails of the authors

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--w3uUfsyyY1Pqa/ej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaZe1HAAoJEJykq7OBq3PIAV8H/iD5rJGUurjXsZ6Ghe2wmB3Z
oAKEcu0/w/xh1gVj7eJKBf5KKIMTAAoFwBTMdBDPasqe/h9zNvB86Eyo9CIwpT8Z
CbxsuzmFPZZEI7uEMoAxYNBQZfmJejtPmgKyaXnuTl0s0VPkmbt+5BkfPHXbE2Z8
/gYHDFuE11eWvwt+7jQF+hi27v1NxTSkKchH4ZRoe45Y/41uju9Bw1MxqRw0wujZ
8K9bkVSjVqOEgXgPGIuCBZ52zKU4p5eVe3km5EAUMs+n1huzho78XNKSPf48shSO
QNo6qrbGGYmmP2gMfkShlalAUG3OiJdoMY3dXePpv1lnXsZFV5BVDdnb5guMH9U=
=9k28
-----END PGP SIGNATURE-----

--w3uUfsyyY1Pqa/ej--
