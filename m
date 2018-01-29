Received: from eggs.gnu.org ([2001:4830:134:3::10]:56167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egFXT-0008Hd-Rb
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:56:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egFXT-0002uS-33
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:56:23 -0500
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-6-git-send-email-anton.nefedov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8e419ac3-1be6-890b-3b1e-b35944fe4975@redhat.com>
Date: Mon, 29 Jan 2018 20:56:10 +0100
MIME-Version: 1.0
In-Reply-To: <1516297747-107232-6-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2fdAXcEefgud9S23O0wyTq2JwXEWs5Ug0"
Subject: Re: [Qemu-devel] [PATCH v7 5/9] file-posix: support
 BDRV_REQ_ALLOCATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2fdAXcEefgud9S23O0wyTq2JwXEWs5Ug0
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 den@virtuozzo.com, berto@igalia.com
Message-ID: <8e419ac3-1be6-890b-3b1e-b35944fe4975@redhat.com>
Subject: Re: [PATCH v7 5/9] file-posix: support BDRV_REQ_ALLOCATE
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1516297747-107232-6-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1516297747-107232-6-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-18 18:49, Anton Nefedov wrote:
> Current write_zeroes implementation is good enough to satisfy this flag=
 too
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/file-posix.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--2fdAXcEefgud9S23O0wyTq2JwXEWs5Ug0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpvfFoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ApHwH/3nWDYL5oTw4L5sr2xS+JwSN7jkiPZ0u
TpVHZsXLOPNpekcwyGUwQ3K5ci9s15YIDWhvpj5cTq3evFfTqZ3FzFiiNY9ggVWx
YavyINc+Jv1lhhdb7+FLif+ZWfEl+bcZAEUjUXpjNAMo5aypcCItmORJa41J/lTV
k4BKftwwC9t0/SKwdmEiGoBPDtqVZPbKqpki74i4JC8zuAh7TzLhpH2SDIntuHg6
XIjXR57wuYD9ns6/vJTHf2piOeBXWlrry3Eq4Neavti5rPCs4Qapz8tla7/bD5Ac
n6hZxRYIi3s9GfBmWLcU29SSOJ50j9h5UdIJaQb1etxcOF9939MafAQ=
=/E9y
-----END PGP SIGNATURE-----

--2fdAXcEefgud9S23O0wyTq2JwXEWs5Ug0--
