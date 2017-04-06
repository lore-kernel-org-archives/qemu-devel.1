Received: from eggs.gnu.org ([2001:4830:134:3::10]:48816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw76S-0003Se-Ao
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw76R-0005ju-Fu
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:05:32 -0400
Date: Thu, 6 Apr 2017 14:05:19 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170406130519.GL21895@stefanha-x1.localdomain>
References: <20170403160936.28293-1-mreitz@redhat.com>
	<20170403160936.28293-15-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CqfQkoYPE/jGoa5Q"
Content-Disposition: inline
In-Reply-To: <20170403160936.28293-15-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 for-2.10 14/16]
 block/qcow2: falloc/full preallocating growth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--CqfQkoYPE/jGoa5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2017 at 06:09:34PM +0200, Max Reitz wrote:
> Implement the preallocation modes falloc and full for growing qcow2
> images.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--CqfQkoYPE/jGoa5Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY5j0PAAoJEJykq7OBq3PI2ikH/0MUyjEcnrvd+bt9Jl1yg9kZ
u7SNf4NmBjUwboSzEks+SbyFLLwftev1aXJZpuEFnm39Oqp2WuL35WeUvVwKJ9Bj
vCoOGWrjM1RCg/kZB+ip9Y23AMXigkrCGGSLzigKMoGzjEYszJOw2NRjsDnotjXF
HCLqOqajUf9CCyQbgx7uLgN2lZKKaymiGk/LGpGjKIFL1RVTHqRvJJ5Md9c/ZqQD
pyQwwHwTQfPwzQsPW7LD6ETjWWHdKvqdTIfnszqxDEQympmLdqHQuIK/AcS5epvo
x0+eBmSqckyWMpq3mxQl6sxOUbK7neC9wJvIj0jrlGq7q1kgJvdAVHat+eMtqa8=
=zC8A
-----END PGP SIGNATURE-----

--CqfQkoYPE/jGoa5Q--
