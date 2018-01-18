Received: from eggs.gnu.org ([2001:4830:134:3::10]:35294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecCAh-0000qH-T7
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:32:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecCAc-00041q-3z
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:32:07 -0500
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:32820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecCAb-000416-U5
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:32:02 -0500
Received: by mail-qt0-x22c.google.com with SMTP id e2so31130071qti.0
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 07:32:01 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
	<CAFEAcA-8dwLpfrbV8+--L4Z9Um9xVsyUOfKjcz9-T1aTPkgrEg@mail.gmail.com>
	<20180117201515.1a49fcbf@redhat.com>
	<CAFEAcA9gXOOkv+-rTXcNyzgY9P8CR66Rrx-0GM2G0m0x+HbAmA@mail.gmail.com>
	<20180118114330.53ad7ce7@redhat.com>
	<CAFEAcA-My_vDd=_7g907MpO2WmVHOHKxsw2-E-vQwn=_SZadRQ@mail.gmail.com>
	<20180118140605.028b7e33@redhat.com>
	<CAFEAcA-oP7hCgjwqiCh4TKKpq-Jfho0JOAsSvWfc09iUouiUWg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1f5614b9-591c-a3f9-c6ce-15d615d13c03@amsat.org>
Date: Thu, 18 Jan 2018 12:31:53 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-oP7hCgjwqiCh4TKKpq-Jfho0JOAsSvWfc09iUouiUWg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="55uQlmzhXezkZ1rPSUR1RVyTFY8qPyFk3"
Subject: Re: [Qemu-devel] [PATCH 00/24] generalize parsing of cpu_model
 (part 4)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Michael Tokarev <mjt@tls.msk.ru>, Riku Voipio <riku.voipio@iki.fi>, Agustin Henze <tin@debian.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Debian QEMU Team <pkg-qemu-devel@lists.alioth.debian.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--55uQlmzhXezkZ1rPSUR1RVyTFY8qPyFk3
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>, Michael Tokarev <mjt@tls.msk.ru>,
 Riku Voipio <riku.voipio@iki.fi>, Agustin Henze <tin@debian.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Debian QEMU Team <pkg-qemu-devel@lists.alioth.debian.org>
Message-ID: <1f5614b9-591c-a3f9-c6ce-15d615d13c03@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 00/24] generalize parsing of cpu_model (part
 4)
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
 <CAFEAcA-8dwLpfrbV8+--L4Z9Um9xVsyUOfKjcz9-T1aTPkgrEg@mail.gmail.com>
 <20180117201515.1a49fcbf@redhat.com>
 <CAFEAcA9gXOOkv+-rTXcNyzgY9P8CR66Rrx-0GM2G0m0x+HbAmA@mail.gmail.com>
 <20180118114330.53ad7ce7@redhat.com>
 <CAFEAcA-My_vDd=_7g907MpO2WmVHOHKxsw2-E-vQwn=_SZadRQ@mail.gmail.com>
 <20180118140605.028b7e33@redhat.com>
 <CAFEAcA-oP7hCgjwqiCh4TKKpq-Jfho0JOAsSvWfc09iUouiUWg@mail.gmail.com>
In-Reply-To: <CAFEAcA-oP7hCgjwqiCh4TKKpq-Jfho0JOAsSvWfc09iUouiUWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

(CC'ing linux-user maintainers)

Hi Peter, Igor,

On 01/18/2018 10:10 AM, Peter Maydell wrote:
> On 18 January 2018 at 13:06, Igor Mammedov <imammedo@redhat.com> wrote:=

>> I've looked and such case is rather an exception,
>> I can fix it up in 2 ways:
>> 1st:
>>   target/arm/cpu.h
>>   +#if !defined(CONFIG_USER_ONLY)
>>   +#define TARGET_DEFAULT_CPU_TYPE TYPE_ARM_CPU
>>   +else
>>   +#define TARGET_DEFAULT_CPU_TYPE ARM_CPU_TYPE_NAME("any")
>>   +#endif
>=20
> This is weird, because TYPE_ARM_CPU isn't really
> a sensible thing to use for anything, so you've really set
> it up as a "this is only of any use for null-machine.c",
> in which case you should just do that in null-machine.c.
>=20
>> or 2nd is to compile in "any" type in system mode
>> (which most targets do), roughly it would amount to:
>>   target/arm/cpu.c
>>   @@ -1671,10 +1671,8 @@ static const ARMCPUInfo arm_cpus[] =3D {
>>      { .name =3D "pxa270-b1",   .initfn =3D pxa270b1_initfn },
>>      { .name =3D "pxa270-c0",   .initfn =3D pxa270c0_initfn },
>>      { .name =3D "pxa270-c5",   .initfn =3D pxa270c5_initfn },
>>   -#ifdef CONFIG_USER_ONLY
>>      { .name =3D "any",         .initfn =3D arm_any_initfn },
>>    #endif
>>   -#endif
>>      { .name =3D NULL }
>>    };
>=20
> This is definitely wrong. We deliberately don't provide "any"
> in system mode, because it's not a sensible thing for users
> to try to use with board emulation. We disabled it some while
> back to avoid users trying it by accident and getting confused.
>=20
> In general, for Arm you really need to know which CPU you want
> to use and why. So:
>  linux-user and bsd-user: should use "any"

I disagree on this, since userland binaries are compiled for a specific
arch/ABI/FPU.
Even without worrying about the FPU, it is unlikely the "any" cpu can
run indifferently ARMv6 and ARMv7 binaries.

IMHO ARMv5 should default to arm946, ARMv6  arm1176 and ARMv7 to cortex-a=
7.

I think we should do the same for linux-user than system and remove the
'any' cpu for ARM.

>  board models: should use whatever CPU that board is designed for
>  null-machine: if it genuinely doesn't care, then pick one at random

Should work :)

Maybe pick the latest/best implemented, hoping this has more features to
cover?

> But there is no single sensible "default CPU type" at an architecture
> level, which is why you can't define a TARGET_DEFAULT_CPU_TYPE
> in target/arm/cpu.h. Any code that thinks it wants that should
> instead be defining it own default that makes sense for that
> context.
>=20
> thanks
> -- PMM
>=20


--55uQlmzhXezkZ1rPSUR1RVyTFY8qPyFk3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpgvekACgkQ4+MsLN6t
wN4g3xAAva8yVJG6UJJbHu9tuRFdj8hqcfXWNyl9KETAwqzCs2n1AjJNB11IZqd8
14mkxV+8nNcOn08+EG49+IOGdM8DaKJI3SvtZ9U2D5kfFztdhccqulZAntWHkv9x
D6fxKPN56qrSypvlYXdcDAynzB+Sg90fqrDnV8wkJjqPkCFlEUWvksfnsZ4j61+p
MbdaApSXeVZ6DDayVOD0LWba06I93Li5YItyr1pT8LLrOUsWipiSqtP6rbpkiexl
TE+2E5+UuiLIUtR2wJR7I3d1G2OhhKXdI4nrgMMVVLUR+/uzzoPWJhutTt85uyHw
PGAO4dEMspblIicpV3ZfNR897O0pGYudlssNeYVpf3IxCBS84yyKHPtDg5O1nDij
fNPKkojkx81+5xMBiVviThFQjFsvS8yXEfbNpxQr4yuWRyOY5vCNUabwRmnCNV2o
wiwPMOMD1IaqmBfLTHSuP5Sarl4nXgwYP5Lg2q7ZVgO1bPtJF2UB2OS64SfZHYzp
bECnLtTUVq/o3QzqsIVt+l+PVYQXKJO5W6fXIYgDCDBePSAinpir2bSHMRKUep+s
I3mJPm25v7DPqa6fFsRKtzjR609utErkKen+roFwcnaUIi+SsdTnYoF28k1wyHGN
HssqlxEBnZJWN+kEzxT5vVbNKtHBlo9T6Vb6HVQ4e3Ub5semWY0=
=cme3
-----END PGP SIGNATURE-----

--55uQlmzhXezkZ1rPSUR1RVyTFY8qPyFk3--
