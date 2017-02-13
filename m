Received: from eggs.gnu.org ([2001:4830:134:3::10]:50777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdHBO-0000aX-Jm
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:00:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdHBK-0005Xc-9Z
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:00:46 -0500
Date: Mon, 13 Feb 2017 14:00:38 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170213140038.GE10361@stefanha-x1.localdomain>
References: <1486144722-6021-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Content-Disposition: inline
In-Reply-To: <1486144722-6021-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] CODING_STYLE: Mention preferred comment
 form
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>, patches@linaro.org


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 03, 2017 at 05:58:42PM +0000, Peter Maydell wrote:
> Our defacto coding style strongly prefers /* */ style comments
> over the single-line // style, and checkpatch enforces this,
> but we don't actually document this. Mention it in CODING_STYLE.
>=20
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  CODING_STYLE | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYobwGAAoJEJykq7OBq3PItDoH/3U2NhnSQv9ne1ot4r3p3V8M
1L5nHpFK4fcl116pOXUXJbncaOYFxHpiFLgpaQBA1btBOI+gW9vUIh1tqbtn+Xak
JiwPjn4rOMPH0ILDNXhOI9WjYWy6quANiZ+o8DcUamOTwcUziHroQJmZqOrXihZe
8LcSh9EtUIOq/4WzYJLpwrvYG9rc3urRMJR68xpghXu3jEGNwlG7F9IhEzsXtf1/
IO6FimI8i2/O/f7UGR+9ZDZ0uz2CHNZ5L24HSqPIaE3nfcUqgI5F1fAHzaU9zLsM
2p1XxC1NDaF+0uGznp4z5hp+6VStKAYjcsqzXmoH7TlXM3e8zwEgE0WXnsFnpog=
=/x9J
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--
