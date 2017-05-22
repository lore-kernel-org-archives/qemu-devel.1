Received: from eggs.gnu.org ([2001:4830:134:3::10]:48523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dCjX7-0003qV-W1
	for qemu-devel@nongnu.org; Mon, 22 May 2017 05:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dCjX4-0001Ik-Rk
	for qemu-devel@nongnu.org; Mon, 22 May 2017 05:21:45 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:35746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dCjX4-0001Ic-L9
	for qemu-devel@nongnu.org; Mon, 22 May 2017 05:21:42 -0400
Received: by mail-wm0-x22c.google.com with SMTP id b84so291970645wmh.0
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 02:21:42 -0700 (PDT)
Date: Mon, 22 May 2017 10:21:39 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170522092139.GB12205@stefanha-x1.localdomain>
References: <20170519161156.GB6895@kentang.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <20170519161156.GB6895@kentang.lan>
Subject: Re: [Qemu-devel] [PULL] Update OpenBIOS images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2017 at 05:11:56PM +0100, Mark Cave-Ayland wrote:
> Hi Stefan,
>=20
> This update contains the OpenBIOS VGA driver updates required to enable B=
en's QemuMacDrivers
> for Mac guests. Please pull.
>=20
>=20
> ATB,
>=20
> Mark.
>=20
>=20
> The following changes since commit 56821559f0ba682fe6b367815572e6f974d329=
ab:
>=20
>   Merge remote-tracking branch 'dgilbert/tags/pull-hmp-20170517' into sta=
ging (2017-05-18 13:36:15 +0100)
>=20
> are available in the git repository at:
>=20
>=20
>   https://github.com/mcayland/qemu.git tags/qemu-openbios-signed
>=20
> for you to fetch changes up to 415c3824836d3b65a5796a81b17fccd1ad575ff8:
>=20
>   Update OpenBIOS images to 3ebaaa2 built from submodule. (2017-05-19 16:=
52:40 +0100)
>=20
> ----------------------------------------------------------------
> Update OpenBIOS images
>=20
> ----------------------------------------------------------------
> Mark Cave-Ayland (1):
>       Update OpenBIOS images to 3ebaaa2 built from submodule.
>=20
>  pc-bios/openbios-ppc     |  Bin 750840 -> 750840 bytes
>  pc-bios/openbios-sparc32 |  Bin 382048 -> 382048 bytes
>  pc-bios/openbios-sparc64 |  Bin 1593408 -> 1593408 bytes
>  roms/openbios            |    2 +-
>  4 files changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZIq2jAAoJEJykq7OBq3PIQX4H/2AhMIkzuxNAfjyaAlUVElm0
HTmwtCWvwP4Ds7//5Tw98yLCMohqknMse1NwRFc8qqZzY575FMNgnlImhDptC395
x255Ioiqk8gLhUjwQQOF2x2zUwA/njeKNR2/9Z/4SXXn7zhiECl/urrW1ycKfyYa
ZmG/FNQIGxIz4X2nnv3jf/nzMYqq3F7a9YWAaRip0mufXK6futde+am/G8pwx8px
TyRgRidxTCUvozKeTiIYEIh7W+Uk8KdMUJEUFV/Tl7K6Prt7vWGO/jA82b6ml4Ld
H3slSEO58WL55nxoNSXZ7OPynd26KjAspY5g9ncu3kMaWHM1pFE0jjqyNs8l8sg=
=JmjF
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
