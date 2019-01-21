Received: from eggs.gnu.org ([209.51.188.92]:37036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1glWj1-00047a-BQ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:22:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1glWj0-0006pL-Hm
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:22:39 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:37472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1glWj0-0006mu-7q
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:22:38 -0500
Received: by mail-wm1-x32e.google.com with SMTP id g67so10154785wmd.2
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 02:22:35 -0800 (PST)
Date: Mon, 21 Jan 2019 10:22:32 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190121102232.GC30536@stefanha-x1.localdomain>
References: <CAFEAcA__E99yuOGXubFsCe55aOzKHa89xA1uNsjadsJff+ka0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
In-Reply-To: <CAFEAcA__E99yuOGXubFsCe55aOzKHa89xA1uNsjadsJff+ka0w@mail.gmail.com>
Subject: Re: [Qemu-devel] Proposed schedule for QEMU 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2019 at 03:06:43PM +0000, Peter Maydell wrote:
> Here's my stab at a schedule for the 4.0 release:
>=20
> 2019-03-12: soft freeze
> 2019-03-19: hard freeze, tag rc0
> 2019-03-26: tag rc1
> 2019-04-02: tag rc2
> 2019-04-09: tag rc3
> 2019-04-16: release, or rc4 if needed
> 2019-04-23: tag rc4
>=20
> Any opinions, objections, suggestions for dates to avoid?
> (Easter in the UK is the weekend of the 19th-22nd but I'm
> not sure it's worth trying to avoid.)

Looks good to me.

Stefan

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcRZ1oAAoJEJykq7OBq3PIQEcH/2/QV+HKjp92jqt/w3dDTU9Z
98U5YLOTTHE4zRwBvYy28XHB/vt1kwwLz688SNGjRZxfbPab2D3J0DlfrlFzH+4v
mgUzrXixbykkJn3+OwXXxKYILi4pMIhE5bJmIwYKroSr3VLsXpc43lujJSDe32TH
6n4+WmmtabCYOpIz2J/UO4ubLbAHuYuKMaujFqet9f2nGkxyhC/J2ykSa5Vqf18z
UZBZiRrysh34vgxorptpisfJssjmHHtm7l92QB2ujWlLMu3BzGnyB385GHlGD5Qp
TCX1Q9giRQJVpL+Y+ooiVbPZ9qa3ghtbPH5hMHhVZVf+L7MA0MvgSKyybtkHsnA=
=7XXQ
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
