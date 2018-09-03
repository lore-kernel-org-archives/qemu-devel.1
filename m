Received: from eggs.gnu.org ([2001:4830:134:3::10]:42471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fwlFu-0007Ek-Gb
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fwlFj-000057-Gg
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:34:46 -0400
References: <20180831222907.16257-1-jsnow@redhat.com>
	<20180831222907.16257-8-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0ad92fd3-525d-646f-09a7-b6a1c4e5e468@redhat.com>
Date: Mon, 3 Sep 2018 11:33:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180831222907.16257-8-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uIWPDU3Tk4s8hSfDs78fv3rArkeYkVkmr"
Subject: Re: [Qemu-devel] [PATCH v3 07/15] block/commit: refactor stream to
 use job callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jtc@redhat.com, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uIWPDU3Tk4s8hSfDs78fv3rArkeYkVkmr
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jtc@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>
Message-ID: <0ad92fd3-525d-646f-09a7-b6a1c4e5e468@redhat.com>
Subject: Re: [PATCH v3 07/15] block/commit: refactor stream to use job
 callbacks
References: <20180831222907.16257-1-jsnow@redhat.com>
 <20180831222907.16257-8-jsnow@redhat.com>
In-Reply-To: <20180831222907.16257-8-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-09-01 00:28, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/stream.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)

You forgot to fix the commit title. ;-)

Max


--uIWPDU3Tk4s8hSfDs78fv3rArkeYkVkmr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluM/94ACgkQ9AfbAGHV
z0ADPwf/a9AoyeOCZ+/sHz1/SNp5ThicASOkZksYItSelPRdxBoc9K3QxSi80934
PO7jB3AJXS0RZDXmESw5HwnzPuj0kE351651SVZyqyGMuZNJmqLI6XgMPI8ALowN
lv87UYZGvpuBWEKO0zmepuhl67LFyihtJFOim/UeW99H3zaN9SVnmnw2V6/9Hym/
7wkCWaJghkpTrSJqQkeX/kv9qXN0SDFnbFtG9R2YLO04jJYkqUoPnXwT9VBpPKcw
mrZS7zPO1SQfNNejvx5qad9DGLURz8iQF03M3bHrUkIkpSwDjrtsgFEtF0rUvTCK
+JW2RsFSPqe+MDRRSssT/hioZfd6MQ==
=MBoW
-----END PGP SIGNATURE-----

--uIWPDU3Tk4s8hSfDs78fv3rArkeYkVkmr--
