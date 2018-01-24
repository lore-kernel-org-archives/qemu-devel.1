Received: from eggs.gnu.org ([2001:4830:134:3::10]:50619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wzssyqa@gmail.com>) id 1eeKg7-0002wx-PW
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:01:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wzssyqa@gmail.com>) id 1eeKg1-0004z6-A7
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:01:23 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:46449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wzssyqa@gmail.com>) id 1eeKg1-0004xd-3x
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:01:17 -0500
Received: by mail-pg0-x244.google.com with SMTP id s9so2625931pgq.13
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 05:01:16 -0800 (PST)
From: Yunqiang Su <wzssyqa@gmail.com>
Message-Id: <47AAAB95-49AD-4A46-8D4A-30BA7C2483A4@gmail.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_AC93ED72-C9A1-4DE1-938D-6776B219C8E6";
	protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Date: Wed, 24 Jan 2018 21:00:59 +0800
In-Reply-To: <0871fe14-f1a5-b735-f7e0-b5f6e1c16dcc@linaro.org>
References: <20171219115041.6611-1-syq@debian.org>
	<0cf81c46-41c7-da9f-0a4b-0ac56a2fac6a@vivier.eu>
	<0871fe14-f1a5-b735-f7e0-b5f6e1c16dcc@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] linux-user: MIPS set cpu to r6 CPU if
 binary is R6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, qemu-devel <qemu-devel@nongnu.org>


--Apple-Mail=_AC93ED72-C9A1-4DE1-938D-6776B219C8E6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Signed-off-by: YunQiang Su <syq@debian.org>

On Tue, Jan 9, 2018 at 11:39 PM, Richard Henderson =
<richard.henderson@linaro.org> wrote:
> On 01/08/2018 03:34 PM, Laurent Vivier wrote:
>> Peter, Riku,
>>=20
>> what do you think of the idea of using the ELF header to select the =
CPU
>> to emulate?
>=20
> I think it's a good way to cut down on mistakes and reduce -- or at =
least not
> increase -- the number of binaries we build.
>=20
>=20
> r~


--Apple-Mail=_AC93ED72-C9A1-4DE1-938D-6776B219C8E6
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgWeQ/gp1Z34qbCLIFBNdJ3uI1+UFAlpog4wACgkQFBNdJ3uI
1+WNZBAAqFFagcKlxdkQiqB8e+JIZNuODifwPN4Xq9HTiyBPE+/kOhnyTzSSPwPL
M1BP+T/l3MvuGkOaOKZSH2SWIQu+GBTTPD4vYis1Ed0Uqon5Occq6l90fb63Urvk
sraKZDxDoH6T2O/QKxh9NSjwUoC+mCn8DLVFGq3ZxQjGZE5aDG6i+Dzm8Dv2HVTU
B5JAxBjFAsAwuqgN9MpIeLUihKMSlkc3ykmj8j61F1mX1IOxpqKsuVmANy+VGABy
EkWg2rN5z+STQvdWUpzVNivuvtwsKkZhySwqizPvo2CMrRZ/Tf/HjjAvntmiYPbA
31szx/rvsRKNCVNKv7cMQJY1XjiyH4FHDQWOnTMOLspymgKzNqvpBOyw+s15ZnBA
rGU1iy4ZxHpivXHxAZsrFU0JWmVWuDITffRFyIP6k9GUiDvWsi+wWyWlpNqFZzTB
hmrjSQIFqITnzoM4fw2jcSLXIm2UppwIBvrfJZW7F0QulXKmBgr1skj8UedX8cCa
FiTR04rlBrXw45bAKgT74vZ5ftfQGyRQ9yet2HmWLlU/R6KhuOkw99L0eZwbThYL
jPdPHX9eYZ7kJIZHr53jRn0UbAPAGcFg/pdxgxsmq6Kx5OdRM5dnUY6/nZiDiuE4
N9mya4Y8O2AAqXEy3U2QhXix8/W9+K4Xr0DRGNYyMJnrQxmVeIg=
=yrjp
-----END PGP SIGNATURE-----

--Apple-Mail=_AC93ED72-C9A1-4DE1-938D-6776B219C8E6--
