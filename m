Received: from eggs.gnu.org ([2001:4830:134:3::10]:47429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ek968-0002RZ-QO
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ek965-0005NE-Om
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:52:16 -0500
Date: Fri, 9 Feb 2018 10:16:30 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180209101630.GB30827@stefanha-x1.localdomain>
References: <20180208162447.10851-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Content-Disposition: inline
In-Reply-To: <20180208162447.10851-1-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] misc: fix spelling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2018 at 05:24:47PM +0100, Marc-Andr=E9 Lureau wrote:
> s/pupulate/populate
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  util/qemu-coroutine-lock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJafXT+AAoJEJykq7OBq3PIIocH/jkdS/XpdqTzQaQFgaW0MBET
wIMLchHdZAWbia50ZAZK6O/s+OqxE24tKG05jQJwPZocARM9aF63ODPbzaMSEE+p
1FfRcv03Xe5HwUL0kNrgO7UxZ8zwzEBu+nRIAbcUBnq3F6BNJyW0lH29/9DkTt5v
vwKDklqlWuptTHVLmQnMYcC4KE2EOrNsP1dpFipfIo7jSGHFSrYw7LJNjLHscnjd
8s+G6wC/8i93D3uk2z5kmdmVwz3KRcKxYR2w/eTP7BE1TheaELUCj4di2/TsFRL9
eVBpwFO7e5FSdxHKj/ZVsfoMPaPBtzPRxJumQDTonq7U3Q99a7j4ppzEYP8w1f8=
=z0qL
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
