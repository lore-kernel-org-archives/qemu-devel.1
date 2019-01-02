Received: from eggs.gnu.org ([208.118.235.92]:35366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gef24-0005GN-Br
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:49:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gef23-0000qa-Np
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:49:56 -0500
Date: Wed, 2 Jan 2019 11:49:48 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190102114948.GK24009@stefanha-x1.localdomain>
References: <20181223025939.15775-1-npes87184@gmail.com>
	<20181223025939.15775-3-npes87184@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opg8F0UgoHELSI+9"
Content-Disposition: inline
In-Reply-To: <20181223025939.15775-3-npes87184@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] dmg: use enumeration type instead
 of hard coding number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuchenlin <npes87184@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org


--opg8F0UgoHELSI+9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 23, 2018 at 10:59:38AM +0800, yuchenlin wrote:
> Signed-off-by: yuchenlin <npes87184@gmail.com>
> ---
>  block/dmg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--opg8F0UgoHELSI+9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcLKVcAAoJEJykq7OBq3PIX2gH/3euWI8s1KlZEC0+zeN9gB3V
qf9LpO1ygdbY1WhBQ8QQt8mA8VGToEBGTMAAFxxRQkDxlXDD/r3evkjP1KXD505N
uPkep2nUZcIGgFZMKpR0FIDWW1YRHHqMeoR59Av/a0Ja4q/7kelw4y2D0ugop/Qp
GTy+csvbggyZZMBnEfEhdRJYGM82Qap5jtDGTbDyT3R7CIS7sQQNTCkhj+0xvnI7
2skKYeLfCG3II0ceE6/UP2mla4781o3O0A5IhEixP3kmNsIAvGvvYMGIM9L2BY/+
2oOddaUHksVq11FD6+hgCZ5dXgUQCe7R98MHbt80kVqiWINgJYyjwxnYfED5O9I=
=v2li
-----END PGP SIGNATURE-----

--opg8F0UgoHELSI+9--
