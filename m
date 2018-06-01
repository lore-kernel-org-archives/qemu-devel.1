Received: from eggs.gnu.org ([2001:4830:134:3::10]:52193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOiNV-0000zT-PH
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOiNS-0000nJ-LI
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:37:53 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:52449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fOiNS-0000mk-EY
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:37:50 -0400
Received: by mail-wm0-x230.google.com with SMTP id 18-v6so2444317wml.2
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 04:37:50 -0700 (PDT)
Date: Fri, 1 Jun 2018 12:37:47 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180601113747.GH8687@stefanha-x1.localdomain>
References: <CAFEAcA9a-xrtibHYb4+-xu3QVmW3tJ1v9X0s_X_PMhQGFSJgdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17/8oYur5Y32USnW"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9a-xrtibHYb4+-xu3QVmW3tJ1v9X0s_X_PMhQGFSJgdg@mail.gmail.com>
Subject: Re: [Qemu-devel] QEMU 3.0 proposed release schedule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>


--17/8oYur5Y32USnW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 22, 2018 at 04:24:37PM +0100, Peter Maydell wrote:
> I've put up a draft release schedule at:
> https://wiki.qemu.org/Planning/3.0
>=20
> 2018-04-24      Beginning of development phase
> 2018-07-03      Soft feature freeze.
> 2018-07-10      Hard feature freeze. Tag rc0
> 2018-07-17      Tag rc1
> 2018-07-24      Tag rc2
> 2018-07-31      Tag rc3
> 2018-08-07      Release, or if necessary, tag rc4
> 2018-08-14      Release, if we needed rc4
>=20
> It's a touch earlier than last year, so we're definitely
> finished before the end of August.
>=20
> Does this work for people?

Sounds good to me.

Stefan

--17/8oYur5Y32USnW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbETALAAoJEJykq7OBq3PILN8H/jKq8jT22FSeFMQ1r4WLpIhu
6K1KUvh+2JCiW7L4XsQPGN6f7qYHgISLXbGy4MY2pHx8LojhcBF+NVV2FrLH/OLX
zp3xCQtpdx6kMKThkYzYlWmLDSdubH+0cmCghd49gjEwufjmVA0EOzAd5nGvLm+G
XzF+utT6+7uhOJ027CnPh9efYWqwS0mjHi5sy5exX6fEzfxZZkWAvsVarNtdb5KL
1+WyzExOUCYNi7T0yW9p6HC0MxOG1cHy0Vdz3kqUsQ+0CPI4c9Dt+As1SC88FSjC
BofXIQhWBXY7ALsJ7wVwiWNbWZx5y2YO8qoTXCCuVDl0Yd7sAIWjrX9MaJjc94Y=
=ibXJ
-----END PGP SIGNATURE-----

--17/8oYur5Y32USnW--
