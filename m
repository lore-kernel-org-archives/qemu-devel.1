Received: from eggs.gnu.org ([2001:4830:134:3::10]:41872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ed6AM-0007KT-Ts
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 22:19:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ed6AI-0002q9-Ke
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 22:19:30 -0500
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:34990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ed6AI-0002pm-Dm
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 22:19:26 -0500
Received: by mail-qt0-x22b.google.com with SMTP id g14so3904210qti.2
	for <qemu-devel@nongnu.org>; Sat, 20 Jan 2018 19:19:26 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180115115309.23982-1-quintela@redhat.com>
	<CAFEAcA-SxiJyKa84UwG8CESpkTXEM9AG5HqEgpPrzSFwrTPzYg@mail.gmail.com>
	<CGME20180119162746epcas1p2143cef3a97b076ce3fbc0b79d7d347b7@epcas1p2.samsung.com>
	<d746e2e8-3690-c27e-f816-9892b36d8a1c@amsat.org>
	<f399b096-6e75-c04f-bb02-80e327de45c4@samsung.com>
	<CAFEAcA-S5yB-3itnRJ41JriJYbsu2EKs9qjPjMC0488vsCZrRw@mail.gmail.com>
	<87h8rg2jdh.fsf@secure.laptop>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <88b2aa3b-8c1a-b0d8-8bfa-2c851e6961d8@amsat.org>
Date: Sun, 21 Jan 2018 00:19:16 -0300
MIME-Version: 1.0
In-Reply-To: <87h8rg2jdh.fsf@secure.laptop>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="FttVwTIZOY8gjd9zrlUKa8c1LW78TbhQ9"
Subject: Re: [Qemu-devel] [PULL 00/27] Migration pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: Alexey Perevalov <a.perevalov@samsung.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FttVwTIZOY8gjd9zrlUKa8c1LW78TbhQ9
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: quintela@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: Alexey Perevalov <a.perevalov@samsung.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, QEMU Developers
 <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <88b2aa3b-8c1a-b0d8-8bfa-2c851e6961d8@amsat.org>
Subject: Re: [PULL 00/27] Migration pull
References: <20180115115309.23982-1-quintela@redhat.com>
 <CAFEAcA-SxiJyKa84UwG8CESpkTXEM9AG5HqEgpPrzSFwrTPzYg@mail.gmail.com>
 <CGME20180119162746epcas1p2143cef3a97b076ce3fbc0b79d7d347b7@epcas1p2.samsung.com>
 <d746e2e8-3690-c27e-f816-9892b36d8a1c@amsat.org>
 <f399b096-6e75-c04f-bb02-80e327de45c4@samsung.com>
 <CAFEAcA-S5yB-3itnRJ41JriJYbsu2EKs9qjPjMC0488vsCZrRw@mail.gmail.com>
 <87h8rg2jdh.fsf@secure.laptop>
In-Reply-To: <87h8rg2jdh.fsf@secure.laptop>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Juan,

On 01/20/2018 08:36 PM, Juan Quintela wrote:
> Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 19 January 2018 at 16:43, Alexey Perevalov <a.perevalov@samsung.com=
> wrote:
>>> As I remember, I tested build in QEMU's docker build system,
>>> but now I checked it on i386 Ubuntu, and yes linker says about unreso=
lved
>>> atomic symbols. Next week, I'll have a time to investigate it deeper.=

>>
>> This sounds like exactly the problem I pointed out in a previous
>> round of this patchset :-(
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg02103.html
>>
>> Ignoring comments and sending patches anyway makes me grumpy,
>> especially when the result is exactly "fails obscurely on
>> some architectures only"...
>=20
> It compiles for me.  F25 i686 gcc.  I did change it to use intptr_t
> instead of uint64_t.  So, I don't know what is going on here.
>=20
> Then, I have a report that clang -m32 didn't work (Mat).  I haven't bee=
n
> able yet to reproduce.  I don't have 32bits libraries installed on my
> x86_64 systems.  clang compiles for me on both 64 bits (f27) and 32bits=

> native (f25, it is a long history that it is not f27).
>=20
> So, I can agree that we have to fix anything that don't work, but I
> can't agree that I didn't care about comments, at least I tried to fix
> the problems you pointed me to.
>=20
> What I don't have is an easier way of compiling on arm and ppc32, but I=

> will search a way to do that for my pull requsets.

You can use docker to cross compile (supposed to work on any Linux):

$ make docker-test-build@debian-powerpc-cross

If you don't want to rebuild all the images the following commands are
faster to modify the codebase and rebuild more frequently:

$ mkdir -p build_ppc32

$ docker run --rm -it -v `pwd`:`pwd` -w `pwd`/build_ppc32 -u `id -u`
qemu:debian-powerpc-cross sh -c '../configure $QEMU_CONFIGURE_OPTS'
[...]

$ docker run --rm -it -v `pwd`:`pwd` -w `pwd`/build_ppc32 -u `id -u`
qemu:debian-powerpc-cross make -j4 subdir-ppc-softmmu
[...]
  CC      ppc-softmmu/gdbstub-xml.o
  CC      ppc-softmmu/trace/generated-helpers.o
  LINK    ppc-softmmu/qemu-system-ppc
=2E./migration/postcopy-ram.o: In function `mark_postcopy_blocktime_end':=

/source/qemu/migration/postcopy-ram.c:717: undefined reference to
`__atomic_fetch_add_8'
/source/qemu/migration/postcopy-ram.c:738: undefined reference to
`__atomic_fetch_add_8'
=2E./migration/postcopy-ram.o: In function `mark_postcopy_blocktime_begin=
':
/source/qemu/migration/postcopy-ram.c:651: undefined reference to
`__atomic_exchange_8'
/source/qemu/migration/postcopy-ram.c:652: undefined reference to
`__atomic_exchange_8'
/source/qemu/migration/postcopy-ram.c:661: undefined reference to
`__atomic_exchange_8'
collect2: error: ld returned 1 exit status
Makefile:193: recipe for target 'qemu-system-ppc' failed
make[1]: *** [qemu-system-ppc] Error 1
Makefile:391: recipe for target 'subdir-ppc-softmmu' failed
make: *** [subdir-ppc-softmmu] Error 2


--FttVwTIZOY8gjd9zrlUKa8c1LW78TbhQ9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpkBrQACgkQ4+MsLN6t
wN6N/BAAqvALeGVrArqtr0K9TcAUPC9ULkoR0p/UjimjBIONcEtg0NkIphe/+Gjb
uZFoBcqD3DhH8fc7Ib6WcWPcJLNJ96eFKO+/76EqldfgVAjsIUEJ0oFwoFR4LyMo
XyyxheewOG6p9pSuJTg8x6WRv9x/tDEGEqSQ0i3SnIUwYlxNgQg/stgQaIEEni6l
bzyXGtqa36HFLdoSYDGZwfMHUFA6BpLedfdz9UU58yGn3Yj9gKl3hnhCL1SOv9dv
RuyiZoX3aQGCN9jJ3ewRvTzSRZ+jMPlcCdL8g2c2R+K6sTTIv6YGfY1CRtJgwQO0
/fI5RImusWmlTBIT6Vszd841ngDkifOZY1i4FZoiGMtxVZRpQ0YjymlAV5DDthmw
vkub6VK6Amo6h4UCJyMKPdwsC6DEsaOIdSDsDfE300FAE0ZMYCc/CatupemiWSGm
twnFE+HJRm95zzZHeVmXA9d3E+EpEqHInNFRX8fWtznn2lE5+uAQnJJiZB1Sqlma
LK0bfbVlC0O81tUSsbvvG1UL2Tg5OnPGeBzcYjQoI64709EWpSLF5COEaTXT1W60
av2V7OHFxTNkavtOaH4AEhmDx5pkVlDxW5HKBUvQEGTd4luRe1q0QddjEjZ7Zuqo
0XSb1ngT4UMhUj+taPum0sZgMNSOOLsBfvuR7UylUyEFUWIyqdM=
=KFz+
-----END PGP SIGNATURE-----

--FttVwTIZOY8gjd9zrlUKa8c1LW78TbhQ9--
