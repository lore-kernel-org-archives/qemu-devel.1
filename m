Received: from eggs.gnu.org ([2001:4830:134:3::10]:34497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuI7s-0004Uw-F2
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuI7o-00048R-LQ
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:04:14 -0400
References: <20180823222249.13518-1-jsnow@redhat.com>
	<20180823222249.13518-14-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5e231134-be0a-fb6d-b61d-59bf42635ce9@redhat.com>
Date: Mon, 27 Aug 2018 16:03:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180823222249.13518-14-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="i5CUkCp9v276gbZan47xNLf5gvURJoHnF"
Subject: Re: [Qemu-devel] [PATCH v2 13/13] block/backup: qapi documentation
 fixup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i5CUkCp9v276gbZan47xNLf5gvURJoHnF
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com,
 Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <5e231134-be0a-fb6d-b61d-59bf42635ce9@redhat.com>
Subject: Re: [PATCH v2 13/13] block/backup: qapi documentation fixup
References: <20180823222249.13518-1-jsnow@redhat.com>
 <20180823222249.13518-14-jsnow@redhat.com>
In-Reply-To: <20180823222249.13518-14-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-24 00:22, John Snow wrote:
> Fix documentation to match the other jobs amended for 3.1.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/block-core.json | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--i5CUkCp9v276gbZan47xNLf5gvURJoHnF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluEBMoACgkQ9AfbAGHV
z0CioggAjqLO9Uzbq7IkM1PWZLb1y6IoVPmAvLnzxWf1B1sz23rLdWXJWWF1rOUt
mdKgtQepqw5uJkE0XTSkfdm3sBJwYRICK40tg4iGkHbWsduevQZn/ikowRoVXayb
HGfsyzYa0toUKvxB5ZbbI6iqLGXKd6+5DrqaTcnRe2CPBOaA7omtlp/pYK76kC++
FJd6Wbuc2Tcu75o9+KzNfQ4BAP0shQGJ1zuqJogm5MpqkulMhwiN/ZwR/758urno
1dBBWVJ0ArHEyPHvraa8KCd/JU6pVgTi94oLxprxY+fG37ZEYSQehpMP5RrROWAO
DNw45EUK2SsvJh2dxaQWwg20FBbfBA==
=Vdd/
-----END PGP SIGNATURE-----

--i5CUkCp9v276gbZan47xNLf5gvURJoHnF--
