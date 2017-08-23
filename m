Received: from eggs.gnu.org ([2001:4830:134:3::10]:40884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dkV9k-0000wP-CC
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dkV9g-0000Zl-Bs
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:53:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dkV9g-0000ZX-29
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:53:08 -0400
References: <20170816082650.21880-1-cohuck@redhat.com>
	<223c4e3c-097f-5a91-37fa-df4bfb427d60@redhat.com>
	<CAFEAcA_UfM_XNKdc5zfHsehoRE6Q+EszRZX3FByskir7c+0Lww@mail.gmail.com>
	<20170822010917.GO12356@umbus.fritz.box>
	<CAFEAcA8wbRjjJYtk-65NJEsu-ELVdKgtwreipabSaMtLTfS--Q@mail.gmail.com>
	<3f0dc918-0f55-e2f4-bf47-fe4abf5453bb@redhat.com>
	<CAFEAcA_ezKWweEuUB-cXTer0LLaeuiGDkSdfhApedhw4ykDT0Q@mail.gmail.com>
	<20170822112046.GC12356@umbus.fritz.box>
	<20170822134815.77020eb8.cohuck@redhat.com>
	<20170823002907.GC5379@umbus.fritz.box>
	<20170823091650.48e7c44e.cohuck@redhat.com>
	<54526d47-b436-79d5-7a38-9516eaa727a6@redhat.com>
	<5b0ff74a-08d6-558d-4c79-a93758e6302a@redhat.com>
	<0bb344a3-f8f8-3365-cef1-1c68cf7d160d@redhat.com>
	<dafbe774-2544-f64e-aad2-9cf957025e8d@redhat.com>
	<8f085a7b-bc3d-9551-b63e-4191f9e13af6@redhat.com>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <dcbe3399-91d8-d632-c77b-2cd52806e373@redhat.com>
Date: Wed, 23 Aug 2017 14:52:55 +0200
MIME-Version: 1.0
In-Reply-To: <8f085a7b-bc3d-9551-b63e-4191f9e13af6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hNCSeuF2m3a95MDCmRTJCXpDn77aJp1D4"
Subject: Re: [Qemu-devel] make check speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hNCSeuF2m3a95MDCmRTJCXpDn77aJp1D4
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, David Gibson
 <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>
Message-ID: <dcbe3399-91d8-d632-c77b-2cd52806e373@redhat.com>
Subject: Re: make check speed
References: <20170816082650.21880-1-cohuck@redhat.com>
 <223c4e3c-097f-5a91-37fa-df4bfb427d60@redhat.com>
 <CAFEAcA_UfM_XNKdc5zfHsehoRE6Q+EszRZX3FByskir7c+0Lww@mail.gmail.com>
 <20170822010917.GO12356@umbus.fritz.box>
 <CAFEAcA8wbRjjJYtk-65NJEsu-ELVdKgtwreipabSaMtLTfS--Q@mail.gmail.com>
 <3f0dc918-0f55-e2f4-bf47-fe4abf5453bb@redhat.com>
 <CAFEAcA_ezKWweEuUB-cXTer0LLaeuiGDkSdfhApedhw4ykDT0Q@mail.gmail.com>
 <20170822112046.GC12356@umbus.fritz.box>
 <20170822134815.77020eb8.cohuck@redhat.com>
 <20170823002907.GC5379@umbus.fritz.box>
 <20170823091650.48e7c44e.cohuck@redhat.com>
 <54526d47-b436-79d5-7a38-9516eaa727a6@redhat.com>
 <5b0ff74a-08d6-558d-4c79-a93758e6302a@redhat.com>
 <0bb344a3-f8f8-3365-cef1-1c68cf7d160d@redhat.com>
 <dafbe774-2544-f64e-aad2-9cf957025e8d@redhat.com>
 <8f085a7b-bc3d-9551-b63e-4191f9e13af6@redhat.com>
In-Reply-To: <8f085a7b-bc3d-9551-b63e-4191f9e13af6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 23.8.2017 v 14:35 Thomas Huth napsal(a):
> On 23.08.2017 13:51, Luk=C3=A1=C5=A1 Doktor wrote:
> [...]
>> and all ERROR lines:
>>
>>     ERROR:tests/prom-env-test.c:42:check_guest_memory: assertion faile=
d (signature =3D=3D MAGIC): (0x00000000 =3D=3D 0xcafec0de)
>=20
> This test uses a timeout of 120 s, see check_guest_memory() in
> tests/prom-env-test.c ... that's a lot already, but if you hit this on =
a
> real system, feel free to send a patch to increase the timeout.
>=20
>>     ERROR:tests/rtc-test.c:173:check_time: assertion failed (ABS(t - s=
) <=3D wiggle): (3 <=3D 2)
>=20
> You might need to increase the "wiggle" variable here.
>=20
>>     ERROR:tests/vhost-user-test.c:779:test_reconnect: child process (/=
i386/vhost-user/reconnect/subprocess [5264]) failed unexpectedly
>>     ERROR:tests/vhost-user-test.c:807:test_connect_fail: child process=
 (/x86_64/vhost-user/connect-fail/subprocess [7751]) failed unexpectedly
>>     ERROR:tests/vhost-user-test.c:835:test_flags_mismatch: child proce=
ss (/x86_64/vhost-user/flags-mismatch/subprocess [7892]) failed unexpecte=
dly
>=20
> I've got no clue about what could be wrong here ... maybe Marc-Andr=C3=A9=
 can
> advise here (who wrote these tests if I got "git blame" right).
>=20
>>     ERROR:tests/boot-sector.c:127:boot_sector_test: assertion failed (=
signature =3D=3D SIGNATURE): (0x00000000 =3D=3D 0x0000dead)
>=20
> Uses a timeout of 90 s ... feel free to send a patch to increase it if
> it's necessary (the timeout can be found in boot_sector_test() in
> tests/boot-sector.c).
>=20
>  Thomas
>=20

Well this one was produced by the `stress` command, so it does not reflec=
t the reality. So this time I took the time and looked at the actual fail=
ures in David's travis results (his builds were already migrated to trust=
y and are failing massively) https://travis-ci.org/dgibson/qemu/builds I =
see only the `vhost-user-test` failing:

ERROR:tests/vhost-user-test.c:779:test_reconnect: child process (/x86_64/=
vhost-user/reconnect/subprocess [58907]) failed unexpectedly
ERROR:tests/vhost-user-test.c:807:test_connect_fail: child process (/x86_=
64/vhost-user/connect-fail/subprocess [58924]) failed unexpectedly
ERROR:tests/vhost-user-test.c:835:test_flags_mismatch: child process (/i3=
86/vhost-user/flags-mismatch/subprocess [56261]) failed unexpectedly

I actually looked there but I have no clue of how to fix this issue. But =
most probably it'd make Travis happier...

Luk=C3=A1=C5=A1


--hNCSeuF2m3a95MDCmRTJCXpDn77aJp1D4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZnXqnExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsEa
rgf+PN00TZHIg1dn0SftnLA/fKYfugbUpUDK/VqtDziL7AvbQorjdc+eYeEA+1Hs
8eFUZjMJVUz8UxE5DC3IVXKs6q6aQguancl16c38C9ieAs5mYP/DSPm5N2Ir8gPj
g1Qj0d1iPugKvDpG+kljYCJQ4k1O47H28ZHdac8P9Offfxeaj/G+D7dPy8i+GwOm
j4qWcwP/ujd5RFk/jmM2BhSvRdk3C8QVWaQm/GF+v5s5ircmHoEzz6+ebGzbLRm3
7xW4uenSWq4I2LG/At/8NG2n0YMKyUzvGUJo5pxHqcXRQAM0WeLKAmlsV/NusDaJ
xuoiyfAJjxEORLdAKh/stYzGgQ==
=zKRr
-----END PGP SIGNATURE-----

--hNCSeuF2m3a95MDCmRTJCXpDn77aJp1D4--
