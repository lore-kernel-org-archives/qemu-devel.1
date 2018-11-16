Received: from eggs.gnu.org ([2001:4830:134:3::10]:39952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gNiik-0003eM-KQ
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 13:19:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gNiih-0001oy-HR
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 13:19:58 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gNiih-0001my-8s
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 13:19:55 -0500
Received: by mail-wr1-x444.google.com with SMTP id 96so8934458wrb.2
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 10:19:55 -0800 (PST)
Date: Fri, 16 Nov 2018 18:19:52 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181116181952.GB24933@stefanha-x1.localdomain>
References: <20181112214224.31560-1-contrib@steffen-goertz.de>
	<20181112214224.31560-14-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <20181112214224.31560-14-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [PATCH v5 13/14] tests/microbit-test: Add Tests
 for nRF51 Timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 12, 2018 at 04:42:23PM -0500, Steffen G=F6rtz wrote:
> Basic tests for nRF51 Timer Peripheral.
>=20
> Signed-off-by: Steffen G=F6rtz <contrib@steffen-goertz.de>
> ---
>  tests/microbit-test.c | 101 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb7wpIAAoJEJykq7OBq3PIujoH/jIg1gRkPHWIraIpMNiUR+9V
WQZidwz7PSSJvLc2bqIQprHkmtOua4twpehzmBjBXe/Ianv72UOd3gO5uUVSqKJZ
61SMOZY04hCOHyOyA65/0Ts/JCNrTWsbPyJcC2xQhQhCm2MKAOkoSjU4FyhxxNym
OFHnvc36jqd6Hj0lbE2h0xGVApsbjIKQioQBh8IDVUgGcPwGu5MSsX1P12KVLv+D
5vCKb/+5saLcRrJBPEetHejLcK3gV8o+0vC3ZW/65RP2AuJNYTOFybiaJ4na+QDZ
Wd0DWLuyLeUBSKerkR2tQU4r9rF4aLymxYix8pvJ7x9+YMXIy7yYhcMKSN7V68s=
=r1TC
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
