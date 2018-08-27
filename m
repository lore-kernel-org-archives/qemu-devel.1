Received: from eggs.gnu.org ([2001:4830:134:3::10]:42680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuFav-00035F-J1
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuFau-00089t-Pn
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:22:05 -0400
References: <20180823222249.13518-1-jsnow@redhat.com>
	<20180823222249.13518-2-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <89e4371c-15cf-0ac0-eec9-c3b8e3dc8934@redhat.com>
Date: Mon, 27 Aug 2018 13:21:46 +0200
MIME-Version: 1.0
In-Reply-To: <20180823222249.13518-2-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zqintyr7vlBw17laTa6UnlnOt1K4dwx2N"
Subject: Re: [Qemu-devel] [PATCH v2 01/13] block/commit: add block job
 creation flags
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
--zqintyr7vlBw17laTa6UnlnOt1K4dwx2N
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com,
 Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <89e4371c-15cf-0ac0-eec9-c3b8e3dc8934@redhat.com>
Subject: Re: [PATCH v2 01/13] block/commit: add block job creation flags
References: <20180823222249.13518-1-jsnow@redhat.com>
 <20180823222249.13518-2-jsnow@redhat.com>
In-Reply-To: <20180823222249.13518-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-24 00:22, John Snow wrote:
> Add support for taking and passing forward job creation flags.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/commit.c            | 5 +++--
>  blockdev.c                | 7 ++++---
>  include/block/block_int.h | 5 ++++-
>  3 files changed, 11 insertions(+), 6 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--zqintyr7vlBw17laTa6UnlnOt1K4dwx2N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluD3soACgkQ9AfbAGHV
z0DGggf/RGbnRhcrOMyldJ6OXE5aFY7DLZH/3Tt+vvMPblDe7F6ClM5ykwZntYDy
39hBnLhSRSv/t00CIpomyHYLbIRwM3UcX7B0GwO0f7l176tA2eSSi1RfLVB4It4I
MyovxGMjZaH9kJKE7d0KVDMDUj2ci+r6J2aMlBqzFihvI9rSQ0nciVq7J7YLjN3/
/o+0fcCpZge9pCKkoZfxkJgNb/dhdSFcu+EoDMjVHM3JG/OPjZeicjaqyWFut5/X
RCivF1ABuHeqTDqvJjVfnIw7vcOn0Ky7pmEHf1ifcX9giVMzXNy7TLEAcxd7e1b8
x+b6wyg3fu9UyUL03p2/sWzuI96KIQ==
=72dg
-----END PGP SIGNATURE-----

--zqintyr7vlBw17laTa6UnlnOt1K4dwx2N--
