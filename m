Received: from eggs.gnu.org ([2001:4830:134:3::10]:40719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG08D-0000p6-9z
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG088-00010f-FK
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:41:33 -0400
Date: Wed, 31 May 2017 10:41:24 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531094124.GB15666@stefanha-x1.localdomain>
References: <20170524025235.32190-1-famz@redhat.com>
	<20170524025235.32190-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
In-Reply-To: <20170524025235.32190-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 02/16] block-backend: Add
 blk_request_perm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2017 at 10:52:21AM +0800, Fam Zheng wrote:
> This function tries to request, if not granted yet, for the given
> permissions.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/block-backend.c          | 12 ++++++++++++
>  include/sysemu/block-backend.h |  1 +
>  2 files changed, 13 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLo/EAAoJEJykq7OBq3PIO5EIAK7WEwo8xYjMf4n2w08XdwW6
JH86jWnvLAgDaRdTtGcEsK1dTcWGNJcoLYm7ITf8Zv2REg2Nc6u2aO/W7eum1Yw5
xZmNvLnkj+3AK0/WnDYUSflk/GKdvzqb+LQxSrP2spT6sIjc2yqUEg1m/mz3tyVh
b8+8KC/r/VKgCmMUfbsvGNOMJ68mIAOdXtKzFGFKw1rboelu95VdhKpGIXNNqeoF
LRZ00kN0zy5xNmGbFhFUU8G02yKvvW+q9c68ab3utd/j687Sdjyct8/WDWsnN8Wt
lIJ4ataDgJdHFA+nTCPtrmwaX9D05USkunG7pxqZ6mGKbjU05+uyzt9tBNvoUGQ=
=IkjI
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
