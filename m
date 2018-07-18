Received: from eggs.gnu.org ([2001:4830:134:3::10]:51335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ffoTm-00063W-Pc
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ffoTm-0004vc-51
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:35:02 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:52066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ffoTl-0004sn-Ui
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:35:02 -0400
Received: by mail-wm0-x230.google.com with SMTP id h3-v6so2813987wmb.1
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 08:35:01 -0700 (PDT)
Date: Wed, 18 Jul 2018 15:19:45 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180718141945.GL21825@stefanha-x1.localdomain>
References: <20180712101219.32707-1-contrib@steffen-goertz.de>
	<20180712101219.32707-3-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PpocKf6TCvdC9BKE"
Content-Disposition: inline
In-Reply-To: <20180712101219.32707-3-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [RFC v3 2/2] tests: Add bbc:microbit / nRF51 test
 suite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>


--PpocKf6TCvdC9BKE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 12, 2018 at 12:12:19PM +0200, Steffen G=F6rtz wrote:
> diff --git a/tests/microbit-test.c b/tests/microbit-test.c
> new file mode 100644
> index 0000000000..c502ee3976
> --- /dev/null
> +++ b/tests/microbit-test.c
> @@ -0,0 +1,118 @@
> + /*
> + * QTest testcase for Microbit board using the Nordic Semiconductor nRF5=
1 SoC.
> + *
> + *
> + * Copyright (c) 2018 Steffen G=F6rtz <contrib@steffen-goertz.de>

Please add a license.

--PpocKf6TCvdC9BKE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbT0yBAAoJEJykq7OBq3PIX+kIAKlu6DY0xpCThzQw3cAL2X5K
7YU5V4MGWds8Z6WIRnfBLvjH7TM4SkLZAXxFWdOXmjnvkC0aF8trfClQXS8YOhNO
q/a71eZqV5aKUKon0Bpyyu74ayJxUFzdxRrLj0rHs72BN7ea+CF/TP/ai4N0chVD
L8ARp2QuZy1e0y3qlBmHtcYSFXy0vlmFfPrkeGCR9gmwnWzlpduFGZQr33slVp7P
1UCSPkLhd3UOl0+iTZcGJsfkskkVOsDcDuMSiJa10jUGGkT/YxtSJ64AurLX1ikP
oluwi/ZC5alZs89aaJ2AJpDIUYXkFIQqEn6xBNN5d67iMwPpm+sjorse0iT6OYE=
=3npW
-----END PGP SIGNATURE-----

--PpocKf6TCvdC9BKE--
