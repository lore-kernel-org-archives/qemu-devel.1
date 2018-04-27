Received: from eggs.gnu.org ([2001:4830:134:3::10]:57890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fC9OP-0007A6-1X
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fC9OO-0004KR-71
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:50:53 -0400
References: <20180427191916.26637-1-alex.bennee@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7781dba2-883b-52b2-2c80-316816779e15@redhat.com>
Date: Fri, 27 Apr 2018 14:50:34 -0500
MIME-Version: 1.0
In-Reply-To: <20180427191916.26637-1-alex.bennee@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lH8UHjazXymAow9HLzaV1QTruWMQqneUX"
Subject: Re: [Qemu-devel] [PATCH] arm/translate-a64: add FP16 FCMP operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org, "open list:ARM" <qemu-arm@nongnu.org>, qemu-devel@nongnu.org, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lH8UHjazXymAow9HLzaV1QTruWMQqneUX
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org
Cc: peter.maydell@linaro.org, "open list:ARM" <qemu-arm@nongnu.org>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Message-ID: <7781dba2-883b-52b2-2c80-316816779e15@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] arm/translate-a64: add FP16 FCMP operations
References: <20180427191916.26637-1-alex.bennee@linaro.org>
In-Reply-To: <20180427191916.26637-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2018 02:19 PM, Alex Benn=C3=A9e wrote:
> These where missed out from the rest of the half-precision work.
>=20

s/where missed out from/were missed during/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lH8UHjazXymAow9HLzaV1QTruWMQqneUX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrjfwoACgkQp6FrSiUn
Q2ptsgf/YVER4UoC9XqlpRFKOUB10lvesS6dUjDQrqFEwfeVkNY7cuzieEDjwBsu
OZsS0480x18L/7vf3QX4MBUiT2K1pt+hkieWzNmtTGpgKIiwFbtWFBLwoNNBxitM
okW+rYLb4sdg6htHRrn3frucX3rj68pHUou9fGkxYyx3pfGh8JrOHUMGbH8ywOHo
vu2P0E9djlj+7w1Ko0cjIPUHByZwawDVaS4yskAhgT82/Nb+HqdhDDNn8mIJ2Ohs
fZ51bcK7x26mIivUwM4QGWpX9QVkFBGhbSq/BmXfqbMla638rpDCzjhHdLn42G/w
/BO6tV054xSJ5x1s15EiO59VA/SqJQ==
=8FD2
-----END PGP SIGNATURE-----

--lH8UHjazXymAow9HLzaV1QTruWMQqneUX--
