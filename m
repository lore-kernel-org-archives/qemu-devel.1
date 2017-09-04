Received: from eggs.gnu.org ([2001:4830:134:3::10]:43722)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1doz2S-0000ip-Vn
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 17:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1doz2O-0006A9-B9
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 17:36:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:61857)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1doz2N-000697-VF
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 17:36:08 -0400
References: <20170904164659.26915-1-n54@gmx.com>
	<20170904173226.25252-1-n54@gmx.com>
	<1a66a487-b906-3f9f-6f4c-15e04c409903@vivier.eu>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <d110585e-b1a8-fb2f-dfe1-99a9cef6bdcd@gmx.com>
Date: Mon, 4 Sep 2017 23:38:23 +0200
MIME-Version: 1.0
In-Reply-To: <1a66a487-b906-3f9f-6f4c-15e04c409903@vivier.eu>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ERdVwTb6Uv5rPGJ39ouAMlpUD9ElvbA12"
Subject: Re: [Qemu-devel] [PATCH v3] target/m68k: Switch fpu_rom from
 make_floatx80() to make_floatx80_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org, peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ERdVwTb6Uv5rPGJ39ouAMlpUD9ElvbA12
From: Kamil Rytarowski <n54@gmx.com>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org, peter.maydell@linaro.org
Message-ID: <d110585e-b1a8-fb2f-dfe1-99a9cef6bdcd@gmx.com>
Subject: Re: [PATCH v3] target/m68k: Switch fpu_rom from make_floatx80() to
 make_floatx80_init()
References: <20170904164659.26915-1-n54@gmx.com>
 <20170904173226.25252-1-n54@gmx.com>
 <1a66a487-b906-3f9f-6f4c-15e04c409903@vivier.eu>
In-Reply-To: <1a66a487-b906-3f9f-6f4c-15e04c409903@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.09.2017 21:02, Laurent Vivier wrote:
>=20
> I don't want to be picky, but you should use "ULL" instead of "LL" for
> the new values.
>=20

I was wondering why the integer is shorter.. should be fixed in v4.



--ERdVwTb6Uv5rPGJ39ouAMlpUD9ElvbA12
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZrcfVAAoJEEuzCOmwLnZsGwMP/Ar/9yjrP0vjcWpDTltz3DTl
1vyog3ngRYM1M1nRlAYyKS9Cw0FQo5iltV/RVkMjbIw2d6IihD+j3U9J3KP36BL7
uyRLeoX2iYMwDn1kiL0rqODc9tsKtx8kU3ycpuFqnq5StMJzkwUXpJVsziZQkfkY
nxxixY6jnq5K7BS2UioiUdLrc3/oWuVGVOwV3Ce8bhp1w9d5BDA+CBPWuTnH/2l0
H5vg+FgU26FlNPuqz2nL+xwMYYRfxd2GJ70gMykKntJpg2jR7ED4kXF8B/2DSLPs
wZXAQID9M9DffIUMRBkPuaGkjhCRDG3CGbkFkxuztUWe9zXudwPZAKKmJqA5d7tC
kmqcYY8Iq93yDCkbB7+chwSODiNmbxvgKXh2q55YPU5S2wj+u41iEiJi1CZKSeFE
rMROE7Y+snLyd7qAzKjMAxAOTsJFwwIEvcCPHRoAEpjFUknaE5KzGM2zCHnHvnuF
pK3mfvKiMCv9MGjeOixoRWfkSt6Q+o1lp4c223QvqA+V/pNcWiTodFlRgKT25WPl
3t6Lyycx8vBtWtEa6cIYPYd0THRPlRQ8rXP0OacUx3aMeD2uiwNbnzGyVLbv5TBv
zx1Nm+8sa3ZvvdMj4O0cpFQBms1SbJINr/3O5sl3ufBvRK9KyrvMkFmF3xIo5TqE
Ttzn08dFjU2MzU/h5sHN
=mi8F
-----END PGP SIGNATURE-----

--ERdVwTb6Uv5rPGJ39ouAMlpUD9ElvbA12--
