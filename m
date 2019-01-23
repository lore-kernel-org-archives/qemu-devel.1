Received: from eggs.gnu.org ([209.51.188.92]:48795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmMf3-0000vr-Ui
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:50:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmMf1-0008AR-Ut
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:50:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gmMez-00085t-Fh
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:49:58 -0500
Date: Wed, 23 Jan 2019 17:49:48 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190123174948.GE8724@stefanha-x1.localdomain>
References: <20190123120759.7162-1-jusual@mail.ru>
	<20190123120759.7162-4-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XuV1QlJbYrcVoo+x"
Content-Disposition: inline
In-Reply-To: <20190123120759.7162-4-jusual@mail.ru>
Subject: Re: [Qemu-devel] [PATCH v5 3/3] tests/microbit-test: Check nRF51
 UART functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>


--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 23, 2019 at 03:07:59PM +0300, Julia Suvorova wrote:
> Some functional tests for:
>     Basic reception/transmittion
>     Suspending
>     INTEN* registers
>=20
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  tests/microbit-test.c | 89 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--XuV1QlJbYrcVoo+x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcSKk8AAoJEJykq7OBq3PI5isH/1v+Twq8H6VynPSmjhziVzFb
ZXjucvFXvCyvai8CDPVfxjZRey0QNU8zYLEYATY2CJqamClonqbuCf07Pj+l8ZaQ
3LrR6NjrmwkklbUsGTaTujYWHDfh/pDQ4mhtVHw3OV8y3au5o4u58cMvzrJNpbNC
KkgeAXBGl75Kh+0AKVAECHiSZWeoNqxWPQwXc0dHm+loFbmK7awmwcVLrpPbMDTd
BPNPqhNtdpywUVR1ptvdG9j0qRtdJE8awbAxkZUTRLJri0DfiUMlTXLTuKP1qaO1
ZgikSPtbIhwPdDUNcZxGSC/96hM34JBV2QTWHq9h27wEioHzVlDVaHRAjPIgeJM=
=+9Lr
-----END PGP SIGNATURE-----

--XuV1QlJbYrcVoo+x--
