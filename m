Received: from eggs.gnu.org ([2001:4830:134:3::10]:43899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gOjCB-0005Hd-5V
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gOjC1-0006r7-Tx
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:02:31 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gOjC1-0006qd-NE
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:02:21 -0500
Received: by mail-wm1-x342.google.com with SMTP id t15-v6so5189872wmt.0
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 05:02:21 -0800 (PST)
Date: Mon, 19 Nov 2018 13:02:18 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181119130218.GA6443@stefanha-x1.localdomain>
References: <20181112214224.31560-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20181112214224.31560-1-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [PATCH v5 00/14] arm: nRF51 Devices and Microbit
 Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 12, 2018 at 04:42:10PM -0500, Steffen G=F6rtz wrote:
> This series contains additional peripheral devices for the nRF51822
> microcontroller.=20

Hi Steffen,
I have finished reviewing this revision, please feel free to send the
next revision addressing comments.  It's getting very close and I expect
to post my Reviewed-by for the remaining patches then.

Stefan

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb8rRaAAoJEJykq7OBq3PI6ZYIAKM4cTLUG2sWICiRbEyO7qGz
bLGzY2hjL8YVaK+CqxbgZZNq7wA9WBPv6so73IchaUBY7ADQaPeolSnZidE72rH2
83rJ2VIKQ619MniXmqy8/sG97OmsdHAFsz3QqesIFAHsroTF0lJcMnDBVioTnp5p
37572K3T/KvOg+qNTPXisQrZ+7xPjGYKewMmjqv9SMW3g09jHkQdiaA9H1kUkF0b
Dk8pTZ2xjb+LAugzdTl7bE9GfzFvRD5Ij3gZN51eFP2l/b+saHzMN+ptOZC24G97
C+LMZGJMC2Bv1SeCpHmF5dtaSG2FZTGIXuTdzp3+7JcjwUlRwVRr5HJJ3VXovoQ=
=+Ehk
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
