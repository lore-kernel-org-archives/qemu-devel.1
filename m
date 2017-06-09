Received: from eggs.gnu.org ([2001:4830:134:3::10]:34997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dJK7V-0003u9-4j
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dJK7U-00083Z-99
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:38:33 -0400
References: <20170602112158.232757-1-vsementsov@virtuozzo.com>
	<20170602112158.232757-15-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <69aeeb36-553c-9c6f-8515-f0f1bd229bb5@redhat.com>
Date: Fri, 9 Jun 2017 15:38:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170602112158.232757-15-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="c3ioXr7SRGDmt88X8el4uJlV6T1RbRScu"
Subject: Re: [Qemu-devel] [PATCH v20 14/30] qcow2: support
 .bdrv_reopen_bitmaps_rw
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
--c3ioXr7SRGDmt88X8el4uJlV6T1RbRScu
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <69aeeb36-553c-9c6f-8515-f0f1bd229bb5@redhat.com>
Subject: Re: [PATCH v20 14/30] qcow2: support .bdrv_reopen_bitmaps_rw
References: <20170602112158.232757-1-vsementsov@virtuozzo.com>
 <20170602112158.232757-15-vsementsov@virtuozzo.com>
In-Reply-To: <20170602112158.232757-15-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-02 13:21, Vladimir Sementsov-Ogievskiy wrote:
> Realize bdrv_reopen_bitmaps_rw interface.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-bitmap.c | 61 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/qcow2.c        |  2 ++
>  block/qcow2.h        |  1 +
>  3 files changed, 64 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--c3ioXr7SRGDmt88X8el4uJlV6T1RbRScu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZOqTEEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQH02
B/9iT7caYOOw24kgq4UT8as7H0oYzQdo9LSgcjEBHZ6/X/kx5HKkArCQrCg8L8l2
MTwKwPerXhHb/d+LYXFt9YLxiC3II1zcwLSoZHJPQULMRiDKdX0BeR58OVLj1rGa
e5wA32t73xSRVaQwKoNbrXe4sUAnGulBc4q7vQbJaTSaQ7oqQpIv0xqhZVvZVztO
wManSq5iXElJUN/NA1yEkF5BIsQ9zJFUXtggup++9/D4r1DLaq04BjaS2VCqLPtQ
GRioH6TKYIRTWwjEXBKDM3HfnklUNn7CAxp99fsCrk7GcPLqbzlwbuK9Q+g2SFLc
v6ZmfjFjCZp/VpqLQmyl/I3+
=uSW4
-----END PGP SIGNATURE-----

--c3ioXr7SRGDmt88X8el4uJlV6T1RbRScu--
