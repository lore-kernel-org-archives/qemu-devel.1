Received: from eggs.gnu.org ([2001:4830:134:3::10]:33660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQcJZ-0006FM-J8
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:29:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQcJV-0000M3-8g
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:29:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dQcJU-0000Ls-VZ
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:29:05 -0400
References: <20170629010300.2848-1-f4bug@amsat.org>
	<20170629010300.2848-6-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9403a3d0-41f6-add2-04fd-12034fe7699a@redhat.com>
Date: Thu, 29 Jun 2017 11:29:01 -0500
MIME-Version: 1.0
In-Reply-To: <20170629010300.2848-6-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="v2GRowvqSjmALPFTfJIQoT0MsXEv3qotG"
Subject: Re: [Qemu-devel] [PATCH RESEND 5/8] tcg/tci: enable bswap16_i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v2GRowvqSjmALPFTfJIQoT0MsXEv3qotG
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>,
 Stefan Weil <sw@weilnetz.de>
Message-ID: <9403a3d0-41f6-add2-04fd-12034fe7699a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RESEND 5/8] tcg/tci: enable bswap16_i64
References: <20170629010300.2848-1-f4bug@amsat.org>
 <20170629010300.2848-6-f4bug@amsat.org>
In-Reply-To: <20170629010300.2848-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/28/2017 08:02 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> remove some copy/paste leftover, code seems sane.
>=20

>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Double-sob seems odd.

> ---
>  tcg/tci.c | 1 -
>  1 file changed, 1 deletion(-)
>=20

Otherwise,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--v2GRowvqSjmALPFTfJIQoT0MsXEv3qotG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVSrOAAoJEKeha0olJ0NqYgwH/0YkS7iPOCugd0qqbHbzSEit
z4mmyvC5ZoNCf4IFT8LPwCjDZ/7ChN+18/MoSXrLUcl4jW7hCA62/9k70Dw3yBBh
MxcTwDMz2yVktUQ6KhwG0BW621LslihpVIOoc+OJLTzEvo8O4pdAsjq9kXFz+JpC
eontoEOaf6MtfUCfBzIoIOpzdfY9uBSwgfsdC/jTUO3LlLil/UEfjNorezPq7fG5
hcYWiGcBOOg1Y4+rWls2eSnBlyc2MuHBvGlwNFbP7ohAhpSXgn8LL7JqeL9sIvKQ
nz5oMLqnGfkRqxaMNEfCUwxy77mSUI+9X4g7a+xn9nMV0Ck1yYPpHUfnI8FLcd8=
=C+s/
-----END PGP SIGNATURE-----

--v2GRowvqSjmALPFTfJIQoT0MsXEv3qotG--
