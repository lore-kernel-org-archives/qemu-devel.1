Received: from eggs.gnu.org ([2001:4830:134:3::10]:56522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2qd-0005Vy-NX
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:35:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2qd-00020Z-02
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:35:35 -0400
Date: Wed, 31 May 2017 13:35:26 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531123526.GM16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-13-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cqq5NadOW2RfLMJ/"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-13-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 12/29] qed: Remove GenericCB
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


--Cqq5NadOW2RfLMJ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:21:53PM +0200, Kevin Wolf wrote:
> The GenericCB infrastructure isn't used any more. Remove it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/Makefile.objs |  2 +-
>  block/qed-gencb.c   | 33 ---------------------------------
>  block/qed.h         | 11 -----------
>  3 files changed, 1 insertion(+), 45 deletions(-)
>  delete mode 100644 block/qed-gencb.c

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Cqq5NadOW2RfLMJ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLriOAAoJEJykq7OBq3PISSYH/ieqaukXGoehT7bWcTEcbpo6
d7/O5cHQnPLZDo4cOG5sDZ2lfhfnA/mvikDSUuUzix645Yc5yE3mWxZmplis4U6f
wvE+WN8CxoCe6pUd+NnLZQDkstp/VZTmA2vlvP6ROKItZt5Z2sCe9vbz9L4qHBgu
EY69zw0VdzFFs2chYmQBrQbS4k9b8vq+nPq5nah2WCY6MrIAL7JqTd53hq6LAalQ
9ZuI9mu/WJO6BNQG0FBqptf4zG38gfFDZCk3/z0UDSVeewGp4yZSfY0Fw6EKDHJM
uohXtiCQem0Ii44yFx2pTa26twaNcAPtzl0DvRHW+90RtupEx/SZWdsNFp3rMQI=
=W1lQ
-----END PGP SIGNATURE-----

--Cqq5NadOW2RfLMJ/--
