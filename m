Received: from eggs.gnu.org ([2001:4830:134:3::10]:50109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2cP-00062N-Om
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2cP-0004Z5-4X
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:20:53 -0400
Date: Wed, 31 May 2017 13:20:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531122044.GE16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-5-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tVmo9FyGdCe4F4YN"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-5-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 04/29] qed: Remove callback
 from qed_read_l2_table()
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


--tVmo9FyGdCe4F4YN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 26, 2017 at 10:21:45PM +0200, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed-cluster.c | 94 ++++++++++++++++++-----------------------------------
>  block/qed-table.c   | 15 +++------
>  block/qed.h         |  3 +-
>  3 files changed, 36 insertions(+), 76 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--tVmo9FyGdCe4F4YN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLrUcAAoJEJykq7OBq3PIh1sH/jFX3Uc1k2cNRMG1sLPRslsQ
wyfaYCXPsMjsdCu0EGC23CRCbxjlH/PGIinNWxxgI0Him7fhbNnz/nLUz3zlM+L6
2+wK/lFbdQ5USuDrCbNWBbSzM6rMORl/Q2tpp3SOn2SrlfFEvR1P2w40RTjDMYzj
vyBtn3JzLH9m207d15+KgC9C1YiCrnFQ5gs5ZLyHvmvc04Ck1t27KF2P0gbGc2y1
zDhQDCo/ZKFZtPCYVo4o2FpYRTcQZ4a5Gz3UZdMy8P2Fkm1U9N+AyMrk3rrgf0JZ
Zzfu+QTq99CbamalKOhO6Ft+c+A4MDGDINbvxLvrbw45fzbJMN6YFeUwAeE23Y4=
=fueC
-----END PGP SIGNATURE-----

--tVmo9FyGdCe4F4YN--
