Received: from eggs.gnu.org ([2001:4830:134:3::10]:57179)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dLCZG-00069y-UR
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dLCZC-0004jF-0p
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:58:59 -0400
Received: from mout.gmx.net ([212.227.17.21]:56428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dLCZB-0004hl-Lj
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:58:53 -0400
References: <20170614105547.Horde.Qq_wt1XJCR6spCHFrm8xE9K@www.quantumachine.net>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <d3d7529a-2d0c-d5e7-1634-4aa16546eef8@gmx.com>
Date: Wed, 14 Jun 2017 19:50:11 +0200
MIME-Version: 1.0
In-Reply-To: <20170614105547.Horde.Qq_wt1XJCR6spCHFrm8xE9K@www.quantumachine.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="U1quKoCPpgSlMjQwO7LRKTIUt2hEqpQgn"
Subject: Re: [Qemu-devel] DragonFly BSD support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Antonio_Huete_Jim=c3=a9nez?= <tuxillo@quantumachine.net>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U1quKoCPpgSlMjQwO7LRKTIUt2hEqpQgn
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Antonio_Huete_Jim=c3=a9nez?= <tuxillo@quantumachine.net>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Message-ID: <d3d7529a-2d0c-d5e7-1634-4aa16546eef8@gmx.com>
Subject: Re: [Qemu-devel] DragonFly BSD support
References: <20170614105547.Horde.Qq_wt1XJCR6spCHFrm8xE9K@www.quantumachine.net>
In-Reply-To: <20170614105547.Horde.Qq_wt1XJCR6spCHFrm8xE9K@www.quantumachine.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.06.2017 12:55, Antonio Huete Jim=C3=A9nez wrote:
>=20
> Hi all,
>=20
> According to 2.9 changelog page, DragonFly BSD will be listed as
> unsupported with the possibility of dropping support completely in the
> future:
>=20
> http://wiki.qemu.org/ChangeLog/2.9
>=20
> I'd like to volunteer so that qemu can keep DragonFly BSD as a supporte=
d
> platform.
> Could you please let me know the requirements needed to do so?
>=20
> Best regards,
> Antonio Huete
>=20
>=20

Are there any local patches for qemu in your ports tree?

Please add yourself to MAINTAINERS and set DragonFly as maintained in
"configure".

There is an option to establish a BSD pull-request queue (as a public
group on GitHub?) and share it for BSD-specific patches. I work on
NetBSD and we still need someone at least for FreeBSD/OpenBSD.


--U1quKoCPpgSlMjQwO7LRKTIUt2hEqpQgn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZQXdbAAoJEEuzCOmwLnZs+aYP/3xB1xs0pCrWm1hjWRqD3GGx
v1kRFzlnDbouv2oTLH4ZhYiWnEo7QJEVRrV1qLH85PvbRaRfMZLVpgV88kDzAF8a
9on2t8ptaYGdYXrOL2wSGd12pT9TJK+VI7qVTzTdFBffPfBThbt63vT4dcZC84gH
DbJHOduZiYufKsFc07x9yfeStRR7Wbx+iZKqb/aKEMf+7p7VzSRRxx7fxcU/cuFZ
9Yh6waNzmW8vmOsJrumpwMiNSPwnAPmg9kWD8piZ8X6y9//RW1uW6vxEZiLq0uWi
GDt4YdaD3iKQ2Uo5ifr/Tv4y41eGgPzQgtXvxmlK3Y7/nBnhOiDj1F5oEpmsAFsl
5j6UIS5m4CIn13BQPMG+6wND8w3hvJ+x0jhPWedfa4B2pTRB85USI8TKm2VkR4+K
YaNGWEyJk9mLtAi/IPrgwjjfFsn/GGfuxiOIoiOMbTacaSLSL/NHT0hDK+r0c9sk
ZrjurbLAUGe0En89KWq4nGYtYR5cWTJ3IOBe9vuVyw6AKBNtzZJ8g+31rrVYyAaL
hIdZQ9TFXzfOter0/6OcQew5kcs+hgjB2u8hAJD0iFidhuVEl+9IvlhuTsUhiFGX
diRTXvsKnaWvXaNgCzTYfm+Uv3MRfn02SCRtkXQkS3OtZkNGCRMwqJMa0ZOFKy9O
7r3pU2RRkWP6mSXsA83i
=vNK1
-----END PGP SIGNATURE-----

--U1quKoCPpgSlMjQwO7LRKTIUt2hEqpQgn--
