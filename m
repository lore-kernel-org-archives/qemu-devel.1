Received: from eggs.gnu.org ([2001:4830:134:3::10]:51090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdF9s-0008Ob-9s
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdF9r-0005Mr-HS
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:27:52 -0400
Date: Wed, 11 Jul 2018 14:27:48 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180711132748.GJ31228@stefanha-x1.localdomain>
References: <20180711012227.31600-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mFHiwr52TKrxpkjc"
Content-Disposition: inline
In-Reply-To: <20180711012227.31600-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-img: Document copy
 offloading implications with -S and -c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--mFHiwr52TKrxpkjc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 11, 2018 at 09:22:27AM +0800, Fam Zheng wrote:
> Explicitly enabling zero detection or compression suppresses copy
> offloading during convert. Document it.
>=20
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  qemu-img.texi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--mFHiwr52TKrxpkjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbRgXUAAoJEJykq7OBq3PIBzkH/RErh+Y+nNT6tEfA/4b7a0Kv
W70iqjg8HU3pnyzo1DjTtcBvDOHhDjByebeY2sfiiSP4M5qKnAGDo3jfKEUji6Gs
mmB/MLdJSf4Bjr6BMwe5WXftbXWsclQBehVvd3Z3DmvvESUH/TT+111v8GGZIWDj
fuClqGYUdyNKQ61DImtxR2dB0nTXG3o9o1PNSsgoD0K9e9Cf3w0R5jv09SYXEMMh
qfpGC1AQq5asWINTYTlGiCMQ35tQ8JEmCy/bXLzV1gkuuU00fR8fQrfZhe2tcYuq
+Dlaw0u/t2TVVZYFjBUyuoAIxXyFHNWkBhKwbHstSgt2vRtq0lmogZNE/1AbmIA=
=v+bo
-----END PGP SIGNATURE-----

--mFHiwr52TKrxpkjc--
