Received: from eggs.gnu.org ([2001:4830:134:3::10]:59474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cckoH-0007ZH-P8
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 22:26:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cckoG-0005DG-QO
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 22:26:45 -0500
References: <20170203094018.15493-1-vsementsov@virtuozzo.com>
	<20170203094018.15493-25-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ffe51e53-725e-fca6-8319-fb2d3ff09e56@redhat.com>
Date: Sun, 12 Feb 2017 04:26:35 +0100
MIME-Version: 1.0
In-Reply-To: <20170203094018.15493-25-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pjPgcDFNWEc3ubFI0Cdb9wkOpgx4RX1sk"
Subject: Re: [Qemu-devel] [PATCH 24/24] qmp: block-dirty-bitmap-remove:
 remove persistent
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
--pjPgcDFNWEc3ubFI0Cdb9wkOpgx4RX1sk
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <ffe51e53-725e-fca6-8319-fb2d3ff09e56@redhat.com>
Subject: Re: [PATCH 24/24] qmp: block-dirty-bitmap-remove: remove persistent
References: <20170203094018.15493-1-vsementsov@virtuozzo.com>
 <20170203094018.15493-25-vsementsov@virtuozzo.com>
In-Reply-To: <20170203094018.15493-25-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.02.2017 10:40, Vladimir Sementsov-Ogievskiy wrote:
> Remove persistent bitmap from the storage on block-dirty-bitmap-remove.=

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  blockdev.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--pjPgcDFNWEc3ubFI0Cdb9wkOpgx4RX1sk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlif1esSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AU3gH/3aBABqNU2uGpG53RW0C3UjmJRA5GFD5
T/5AIDPVFYzp19yL5olEhHj7LtTVYoWZ5ews8nonGYvYQjJmOddDjMTtYRqDWVku
jSHRjMbhWYxjZiNnOE6R7jkUppcWHpTm1MFMepHj4s9DUw2csgZVkF9QLB/myeef
rE+TvrEueTcn9avf61YsquitmovhJhNXTRhY0XuaeiymMVIX3tWlvatWelH9BI4N
8qLJjcJJVyGFKOyKSOEnc+p9NfBvfXq5HrHWOSYnRmkgflqNrYDS0pnSaU+HZ+Ym
MiXm/kPHJUF9zIK4IO6YssjxK1dofATwjSoBzSXZmDwjQGXZuY9e0OU=
=dTdT
-----END PGP SIGNATURE-----

--pjPgcDFNWEc3ubFI0Cdb9wkOpgx4RX1sk--
