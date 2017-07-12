Received: from eggs.gnu.org ([2001:4830:134:3::10]:39953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVJ1U-0002pY-AQ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVJ1T-0004rn-In
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:53:52 -0400
References: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
	<1499864249-26305-2-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fd430eb3-6998-3d88-58e9-11237e1afa82@redhat.com>
Date: Wed, 12 Jul 2017 09:53:40 -0500
MIME-Version: 1.0
In-Reply-To: <1499864249-26305-2-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="j6HMlFO6krFLtmkeCiP0mTAoJ5AEvqPJJ"
Subject: Re: [Qemu-devel] [PATCH 1/9] block: Make blk_get_attached_dev_id()
 public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j6HMlFO6krFLtmkeCiP0mTAoJ5AEvqPJJ
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org
Message-ID: <fd430eb3-6998-3d88-58e9-11237e1afa82@redhat.com>
Subject: Re: [PATCH 1/9] block: Make blk_get_attached_dev_id() public
References: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
 <1499864249-26305-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499864249-26305-2-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/12/2017 07:57 AM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/block-backend.c          | 3 +--
>  include/sysemu/block-backend.h | 1 +
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--j6HMlFO6krFLtmkeCiP0mTAoJ5AEvqPJJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZjf0AAoJEKeha0olJ0Nq7VAH/0BgQ24D/NlcJ6bahWW1Dxm1
GahWgUUCnjROWF77EYrb8Xo2xjjVRUhddtiGFim0cXHzEviiDhfqd5rDX/E+URwg
X37rrf9iN5SgYA1SRDewAm4Wlhifly78yyMbkN5B7cwa6VFS24ONOp5vkCu/bMJy
2GBhC9fDlumRBTYTi5M82qp+tba8RrtEH9mD/v5dKpTbGYmlJ7gx0c1sid1Wc2Cn
1EL0R/yfUxtwR0ui8XE6mxZfOEPniekjMDdaB7zTbcBqVs+g51ornwcLc41eQ/ZF
C0eM+GSla5JtnGYV34sXapdeL8dCdBqPZHp6M3lnDUKivZXbdo7bipMImTTEzSg=
=+tzP
-----END PGP SIGNATURE-----

--j6HMlFO6krFLtmkeCiP0mTAoJ5AEvqPJJ--
