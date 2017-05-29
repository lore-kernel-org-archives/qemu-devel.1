Received: from eggs.gnu.org ([2001:4830:134:3::10]:46752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFOW4-0003Ne-PC
	for qemu-devel@nongnu.org; Mon, 29 May 2017 13:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFOW3-0000rW-W2
	for qemu-devel@nongnu.org; Mon, 29 May 2017 13:31:40 -0400
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
	<20170503122539.282182-22-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <def656a8-e0dc-3f72-7152-b12bce9475bb@redhat.com>
Date: Mon, 29 May 2017 19:31:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170503122539.282182-22-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BjVB5dGUhJEbU2MA2Qwt7TgTsiG3o8kgC"
Subject: Re: [Qemu-devel] [PATCH 21/25] iotests: test qcow2 persistent dirty
 bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BjVB5dGUhJEbU2MA2Qwt7TgTsiG3o8kgC
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <def656a8-e0dc-3f72-7152-b12bce9475bb@redhat.com>
Subject: Re: [PATCH 21/25] iotests: test qcow2 persistent dirty bitmap
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
 <20170503122539.282182-22-vsementsov@virtuozzo.com>
In-Reply-To: <20170503122539.282182-22-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-03 14:25, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/165     | 105 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/165.out |   5 +++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 111 insertions(+)
>  create mode 100755 tests/qemu-iotests/165
>  create mode 100644 tests/qemu-iotests/165.out

Reviewed-by: Max Reitz <mreitz@redhat.com>


--BjVB5dGUhJEbU2MA2Qwt7TgTsiG3o8kgC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLFrqEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQLTg
CACdi5P0BDZFDoPdUOY/iVFcXCMtI4FtcbYiJU7kP64WPshulKQYBUfOVSCOZc+U
ucJFDKL0GNZ/Aai3teMqV6Mui8cJe2InH1Iuhin/uZEDLq5ga4PFpkdkGShjjJiS
mixi4OJU/DJ59alC6Q3OBrLnEWGzUYT5fFH2Gdqbs7kNLBAdgLUHOML6+uLIdpn3
4wpHjbHgvrOWQongH7FbHC3E3Dbex5R4WU7P0viDZ5lGCHmOWC6y60DW/I9JtQwY
S03NVlbp34TiOnxroC9mNek8XqPc+U7yZ1x6TxGVUeyk2UIUax5618DCEFve+pPz
kUQa5JFW2i3umsJf+zk+pfvv
=mGC7
-----END PGP SIGNATURE-----

--BjVB5dGUhJEbU2MA2Qwt7TgTsiG3o8kgC--
