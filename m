Received: from eggs.gnu.org ([2001:4830:134:3::10]:56891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2rf-0006Ec-HV
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2re-0002PJ-HK
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:36:39 -0400
Date: Wed, 31 May 2017 13:36:33 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531123633.GN16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-14-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aIbcA3MSwnGacr4f"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-14-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 13/29] qed: Remove callback
 from qed_write_table()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com


--aIbcA3MSwnGacr4f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 26, 2017 at 10:21:54PM +0200, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed-table.c | 47 ++++++++++++-----------------------------------
>  block/qed.c       | 12 +++++++-----
>  block/qed.h       |  8 +++-----
>  3 files changed, 22 insertions(+), 45 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--aIbcA3MSwnGacr4f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLrjRAAoJEJykq7OBq3PIVXMH/1fEKWBdaJcMzjUKTPSeYIdT
CAd2rvg3lBLHuQhGJ4AI/NPzXZYfPnpHOHQwv2d4eG4KZWxisFWDlHEm+Eh+ee72
EQdcE5zn2oDQWt6oCpbKAneh9jRznJBOD5xojkc8VSgLK4GyYCwB2JilTGbLBaCi
+0FqgBNvKvc3uPu99iHA78r4WD3d1Qz7VnstqgQUYaLYnIZWRckITCeUG2xMEcwy
52YO1huBwZ4Pe0qKHhEUhEjZNOYA/BCaqzdIwvFGcOANvy4qdHKN3LdCDK1J9hZV
nFrQiEPZxQAG0f99HQ/ecRQ9WQxh7wO62ZZqG0B22st2v9XPr1GQR54l00FIB/I=
=LAk9
-----END PGP SIGNATURE-----

--aIbcA3MSwnGacr4f--
