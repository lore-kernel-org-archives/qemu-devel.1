Received: from eggs.gnu.org ([2001:4830:134:3::10]:52874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYZt1-00016V-GU
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:58:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYZt0-0005Dq-OY
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:58:23 -0500
Date: Tue, 31 Jan 2017 14:58:15 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170131145815.GR18804@stefanha-x1.localdomain>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-13-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r7tUYVWcdYzDJoZW"
Content-Disposition: inline
In-Reply-To: <1482503344-6424-13-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 12/21] iotests: add supported_cache_modes
 to main function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, pbonzini@redhat.com, jcody@redhat.com


--r7tUYVWcdYzDJoZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 23, 2016 at 05:28:55PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/iotests.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--r7tUYVWcdYzDJoZW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkKYHAAoJEJykq7OBq3PIOK0H/RhUvN5nKj+f6Zjxf6D2rSMj
R+Smx1Tf4upmoYBCOYxPj93EJbDET2cqpwuocvrpxKIF6irGRm1fDYLNgec+atck
xxiBzcpRQ4uCpI8MYqsnSRezpNKCEvRX3REcEyazDT3XpGh0zin4M7C2h7XwF2zH
LDWvamPf8LGVgMeDrw3DlzboWSywihw5uJgEDvShnId38l5RQuV8bVm7sEbSIGex
+TSzXB0YAb9CkwJ7/VEnytB7Lt2GK18ZMGZcwdeBM0TVqj9yGLGk6HCBrEYM2qyl
51zq75Fr0aCKn2KMHgLhxcbPHnZyFMwAboKrl2ZHcCQRzqO6Pg+BzjQ5P2qMG5U=
=CuC6
-----END PGP SIGNATURE-----

--r7tUYVWcdYzDJoZW--
