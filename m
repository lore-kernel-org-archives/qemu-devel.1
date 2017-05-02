Received: from eggs.gnu.org ([2001:4830:134:3::10]:45418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d5Yf9-0005HD-LM
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:20:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d5Yf6-0001nt-GA
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:20:23 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:34774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d5Yf6-0001ne-9J
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:20:20 -0400
Received: by mail-wr0-x234.google.com with SMTP id l9so82043538wre.1
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 07:20:20 -0700 (PDT)
Date: Tue, 2 May 2017 15:20:17 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170502142017.GI22502@stefanha-x1.localdomain>
References: <cover.1493593744.git.shorne@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nO3oAMapP4dBpMZi"
Content-Disposition: inline
In-Reply-To: <cover.1493593744.git.shorne@gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/11] Fixes and features for OpenRISC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: peter.maydell@linaro.org, QEMU Development <qemu-devel@nongnu.org>


--nO3oAMapP4dBpMZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 01, 2017 at 08:14:14AM +0900, Stafford Horne wrote:
> This are the openrisc patches I have been circulating on the mailing list
> of the last few months.  We have had help from a few new people and added
> the following:
>  * Fixes for gdb memory debugging
>  * Added support for Shadow Registers, EVBAR, EPH
>  * Added support for idle state, no more 100% pegged cpu's
>  * Fixed VM state persisting
>=20
> Please consider for pull.

Hi Stafford,
I'm handling qemu.git pull requests while Peter Maydell is away in May.

Please take a look at the checkpatch.pl errors that the patchew
continuous integration system found (there is an email reply to this
thread).  Thanks!

Stefan

--nO3oAMapP4dBpMZi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCJWhAAoJEJykq7OBq3PIxWsH/jVctZ4981iNJ9yUo0XTr7p6
jZLT/V43vExQ0KbjP3q2sSyv7AYUMLzboc+E2ErO6U75GPIb6N6i64rK9FvSSvqZ
yaBewbS+rnbkk2yjNmUGU0FS5UWwym1IEhweGPfLv8YNIEcDsofFy+DOR52qACsf
Jm3flnQhcAjOp3fJBp0vB+YjGdY1Ode4Qtm1SasBKak4Sor+d8c/cKTXgeZBSNtq
d5QiQusEkLeOsZAN4EXwtJ5aQtKLIfwVSX9EZ/cO9DDfXhGS2aJQ8CA16EhO1VR1
A513VLYUlAnvJU1dEAyy7eafE6dhXvmsnIA1UKQz/mCpxFZwNLW9irvZp/W1saM=
=PJwM
-----END PGP SIGNATURE-----

--nO3oAMapP4dBpMZi--
