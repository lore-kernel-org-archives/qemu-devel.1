Received: from eggs.gnu.org ([2001:4830:134:3::10]:40974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1egA9F-0006yD-VO
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1egA9A-00036L-DI
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:11:01 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:55937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1egA9A-00036A-6o
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:10:56 -0500
Received: by mail-wm0-x22b.google.com with SMTP id 143so14509343wma.5
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 06:10:56 -0800 (PST)
Date: Mon, 29 Jan 2018 14:10:53 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180129141053.GK20446@stefanha-x1.localdomain>
References: <3f97e5fca675d8561f2291e6fbd673b6@cse.iitb.ac.in>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GmiNL4+5WUWrod5m"
Content-Disposition: inline
In-Reply-To: <3f97e5fca675d8561f2291e6fbd673b6@cse.iitb.ac.in>
Subject: Re: [Qemu-devel] Help regarding configuring qemu with
 '--enable-ptnetmap' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sagart <sagart@cse.iitb.ac.in>
Cc: qemu-devel@nongnu.org


--GmiNL4+5WUWrod5m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 16, 2018 at 02:47:41PM +0530, sagart wrote:
> Hello,
>  I am trying to configure qemu with ptnet. But it seems like, now there is
> no 'ptnet' branch to checkout,
> so I am unable to configure using '--enable-ptnetmap' option.
> please help in this regard.

Please ask the author of the feature.  The QEMU mailing list
cannot help with features that are not in mainline qemu.git.

Stefan

--GmiNL4+5WUWrod5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJabyttAAoJEJykq7OBq3PIod8H/2Qvg7+slx1F89uXUOEIXstZ
ZWbK3hmT137tEfK2mRrlBmfPVqeoe48QJ9uDWeNk9YW/BZRUGlaKboC5FiEsZgNW
DzlzcTHvnmtjbve/kWQI/jiL9lbys2AgiL9PA+J+ZzCB/UxUQrgnXCOameqrwSXY
WsYxrVPkwY6GT6V4BG0Z9DxLuG+5OlIoKNMJZGbQIiOkh2yG9nSwrV5FBxwPWnqd
+IK0vWW2qMF0mtuhKShIKpWnGpnx8mPfUxp5fH74J+RdxZCzNYPhmbRoXrZ/eRaS
uuv04mUudf+pUoPDDxKTJP6vPUecpcKJCoc0A0lW43GnX1221TDWzQwQYGjT/xg=
=5RrK
-----END PGP SIGNATURE-----

--GmiNL4+5WUWrod5m--
