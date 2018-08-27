Received: from eggs.gnu.org ([2001:4830:134:3::10]:33426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuI63-0002Yl-AR
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuI1I-0007bJ-VJ
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 09:57:29 -0400
References: <20180823222249.13518-1-jsnow@redhat.com>
	<20180823222249.13518-11-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c98682eb-1b2a-b2a0-721c-9f9d95a8373c@redhat.com>
Date: Mon, 27 Aug 2018 15:57:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180823222249.13518-11-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="C3v9QOy8dYuTGwEatMHYwPYO7VQPWHDHN"
Subject: Re: [Qemu-devel] [PATCH v2 10/13] qapi/block-commit: expose new job
 properties
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
--C3v9QOy8dYuTGwEatMHYwPYO7VQPWHDHN
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com,
 Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <c98682eb-1b2a-b2a0-721c-9f9d95a8373c@redhat.com>
Subject: Re: [PATCH v2 10/13] qapi/block-commit: expose new job properties
References: <20180823222249.13518-1-jsnow@redhat.com>
 <20180823222249.13518-11-jsnow@redhat.com>
In-Reply-To: <20180823222249.13518-11-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-24 00:22, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  blockdev.c           |  8 ++++++++
>  qapi/block-core.json | 16 +++++++++++++++-
>  2 files changed, 23 insertions(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--C3v9QOy8dYuTGwEatMHYwPYO7VQPWHDHN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluEAzsACgkQ9AfbAGHV
z0BRoAf/TgzjszLp0fn0YeORr9YbrBBxwQ7UoCVJIQ8Ufp6OnWwE7UimNpJ9jqgr
ikiNipfJZT+NuX0I6chrARr1sGXOfCt4dbub1WKlrSca0aDxDB+uiK0QWSC+9eYD
tmKNeMHbs5oz27IR/X03Dyae3yoO9NJ/KMRLphKId5CR1CFYx//Cj/7ioo4A4GrQ
w/5G8i+DL2cQVCwDIOdnMFnnYg4Pw8euvS+Oc10sP/ZNDVaEKpUHLzcUl/Hc0puh
my2/4u6VxcHuigFI4TfybWkIiC4Ust387IBOYsrylSSEryR8P/q6/5GD76kayXlf
8fvF4HIWRbpe/PQ8O6q59cNpjk9bCg==
=0w+j
-----END PGP SIGNATURE-----

--C3v9QOy8dYuTGwEatMHYwPYO7VQPWHDHN--
