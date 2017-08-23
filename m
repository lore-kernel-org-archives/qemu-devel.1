Received: from eggs.gnu.org ([2001:4830:134:3::10]:55684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dkUHi-0002sW-IC
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 07:57:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dkUHc-0005Sh-9m
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 07:57:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dkUHc-0005SF-0H
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 07:57:16 -0400
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
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <dafbe774-2544-f64e-aad2-9cf957025e8d@redhat.com>
Date: Wed, 23 Aug 2017 13:51:33 +0200
MIME-Version: 1.0
In-Reply-To: <0bb344a3-f8f8-3365-cef1-1c68cf7d160d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QNhcoxPiqf2hM3CpWE1vkhXEhkWlqbGoP"
Subject: Re: [Qemu-devel] make check speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QNhcoxPiqf2hM3CpWE1vkhXEhkWlqbGoP
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>
Message-ID: <dafbe774-2544-f64e-aad2-9cf957025e8d@redhat.com>
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
In-Reply-To: <0bb344a3-f8f8-3365-cef1-1c68cf7d160d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 23.8.2017 v 10:35 Thomas Huth napsal(a):
> On 23.08.2017 10:01, Paolo Bonzini wrote:
>> On 23/08/2017 09:49, Thomas Huth wrote:
>>> While we're at it: I'd like to have a "make check-fast", too. Sometim=
es
>>> the normal "make check" is already too slow, e.g. while developing ne=
w
>>> patches, I sometimes just want to do a very quick sanity test to see
>>> whether I broke some basic things or not, and only do the "make check=
"
>>> before I submit my patches.
>>> So we would get three stages:
>>>
>>> - make check-fast =3D> For very, very quick sanity tests only
>>>
>>> - make check =3D> E.g. has to be run before submitting patches
>>>
>>> - make check-harder =3D> might run a very long time, so best suited f=
or
>>>                        nightly regression tests etc.?
>>>
>>> Does that sound reasonable? And the crucial question: Who is going to=

>>> implement the basic framework for this?
>>
>> There's already make check-unit or make check-qtest-x86_64 depending o=
n
>> what you're working on.
>=20
> True. And I just learned that you can also already set the SPEED
> variable to either "quick" or "slow" and that we're already using
> g_test_quick() and g_test_slow() in a couple of places to check this. S=
o
> the framework for running quick vs. thorough tests is already there ...=

> we just might want to add this to some more tests, I guess...
>=20
> Question for the maintainers and the test automation folks: Is anybody
> already running "make check SPEED=3Dslow" or is this just rather an
> unheard-of way of running the tests?
>=20
>> If you have a many-core machine, of course, there's no simpler solutio=
n
>> than throwing more CPUs at it. :)
>=20
> Is it safe nowadays to run "make check -j4" for example? Last time I
> tried (maybe 1 or 2 years ago), there were still issues since some test=
s
> were using hard-coded temporary file names, so the parallel tests were
> disturbing each other, for example...
>=20

Actually the `.travis.yml` defines `MAKEFLAGS=3D"-j3"`, which results in =
`make check` being executed with 3 threads...

I was actually looking at the increasing number of failed travis builds a=
nd it seems to be related to the fluctuating performance. Running `nice -=
n 20 make check -j 12` with `nice -n 5 stress -c 20` in background result=
s in the same kind of failures:

    File '/tmp/qemu/include/qapi/qmp/qobject.h'
    Lines executed:0.00% of 9
    **
    ERROR:tests/prom-env-test.c:42:check_guest_memory: assertion failed (=
signature =3D=3D MAGIC): (0x7c7f1b78 =3D=3D 0xcafec0de)
    GTester: last random seed: R02S117a2b838f1fd17c65a134629577b996
    make: *** [check-qtest-ppc] Chyba 1
    /tmp/qemu/tests/Makefile.include:836: n=C3=A1vod pro c=C3=ADl =E2=80=9E=
check-qtest-ppc=E2=80=9C selhal
    make: *** [check-qtest-sparc] Chyba 1
    /tmp/qemu/tests/Makefile.include:836: n=C3=A1vod pro c=C3=ADl =E2=80=9E=
check-qtest-sparc=E2=80=9C selhal
    **
    ERROR:tests/rtc-test.c:173:check_time: assertion failed (ABS(t - s) <=
=3D wiggle): (3 <=3D 2)
    GTester: last random seed: R02S2ca82eb2e7f63ec62c8433b715d9fe12
    Vhost user backend fails to broadcast fake RARP
    **
    ERROR:tests/vhost-user-test.c:779:test_reconnect: child process (/i38=
6/vhost-user/reconnect/subprocess [5264]) failed unexpectedly
    GTester: last random seed: R02S6e728ccb5384a4d856cacc4166be8052
    Gcov report for hw/misc/tmp105.c:
    File 'hw/misc/tmp105.c'
    Lines executed:30.40% of 125
    Gcov report for arm-softmmu/hw/block/virtio-blk.c:
    File '/tmp/qemu/hw/block/virtio-blk.c'

and all ERROR lines:

    ERROR:tests/prom-env-test.c:42:check_guest_memory: assertion failed (=
signature =3D=3D MAGIC): (0x00000000 =3D=3D 0xcafec0de)
    ERROR:tests/rtc-test.c:173:check_time: assertion failed (ABS(t - s) <=
=3D wiggle): (3 <=3D 2)
    ERROR:tests/vhost-user-test.c:779:test_reconnect: child process (/i38=
6/vhost-user/reconnect/subprocess [5264]) failed unexpectedly
    ERROR:tests/vhost-user-test.c:807:test_connect_fail: child process (/=
x86_64/vhost-user/connect-fail/subprocess [7751]) failed unexpectedly
    ERROR:tests/vhost-user-test.c:835:test_flags_mismatch: child process =
(/x86_64/vhost-user/flags-mismatch/subprocess [7892]) failed unexpectedly=

    ERROR:tests/boot-sector.c:127:boot_sector_test: assertion failed (sig=
nature =3D=3D SIGNATURE): (0x00000000 =3D=3D 0x0000dead)

on my machine. Using `make -j 1` or at least `make -j 2` could improve (b=
ut I haven't checked that)

Luk=C3=A1=C5=A1

>  Thomas
>=20



--QNhcoxPiqf2hM3CpWE1vkhXEhkWlqbGoP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZnWxFExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsHr
Agf/Sy8ioJjhKf0n4RQZX9GCK8g/s43Xu9gMkcRQ2iWViCTDceDDw8VcsP5gsN7S
yUztfqtxwuu6RN7UHmSbEu70DqEzK0HEAI+V1nYTtfUwrq6UF5Rj+2vG3llZe8nl
mSjL80jpFeAFvxsVaIjMY5WneXSsAUXwnt1FaPKHSt+bdJ56HXdEBTNcp/bRoUPN
YQaYFKpo+UdLUE7sSYAo2LIDigTnMQg5UyksG2RUWkETLSLxctwriX3AIMNAebm2
5eEbzzqys+Gcq1T86P9/aFj6WQDwujWf9trZrSG14aXtYyAT1SyK6KgQXW0VKowX
0b6fWJRLLsawpg8Q1AM2C34EUw==
=Qobr
-----END PGP SIGNATURE-----

--QNhcoxPiqf2hM3CpWE1vkhXEhkWlqbGoP--
