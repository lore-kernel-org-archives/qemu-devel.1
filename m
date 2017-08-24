Received: from eggs.gnu.org ([2001:4830:134:3::10]:48455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dksYg-0002Fj-DZ
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dksYc-0007zZ-17
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:52:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dksYb-0007z2-No
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:52:25 -0400
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
	<48906779-cd74-bfe6-1e4a-4678eb2d0a0d@redhat.com>
	<5f09f24a-4100-6f3d-62de-3edbfe5e91ba@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <900a72e6-1f5d-216f-4816-fbde0e5905dc@redhat.com>
Date: Thu, 24 Aug 2017 09:52:12 -0400
MIME-Version: 1.0
In-Reply-To: <5f09f24a-4100-6f3d-62de-3edbfe5e91ba@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aR4aKgg3eAF3EevBkt5i2AQXO7JUm5krg"
Subject: Re: [Qemu-devel] make check speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aR4aKgg3eAF3EevBkt5i2AQXO7JUm5krg
From: Cleber Rosa <crosa@redhat.com>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <900a72e6-1f5d-216f-4816-fbde0e5905dc@redhat.com>
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
 <48906779-cd74-bfe6-1e4a-4678eb2d0a0d@redhat.com>
 <5f09f24a-4100-6f3d-62de-3edbfe5e91ba@redhat.com>
In-Reply-To: <5f09f24a-4100-6f3d-62de-3edbfe5e91ba@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/23/2017 08:13 AM, Luk=C3=A1=C5=A1 Doktor wrote:
> Dne 23.8.2017 v 14:01 Thomas Huth napsal(a):
>> On 23.08.2017 13:51, Luk=C3=A1=C5=A1 Doktor wrote:
>>> Dne 23.8.2017 v 10:35 Thomas Huth napsal(a):
>>>> On 23.08.2017 10:01, Paolo Bonzini wrote:
>>>>> On 23/08/2017 09:49, Thomas Huth wrote:
>>>>>> While we're at it: I'd like to have a "make check-fast", too. Some=
times
>>>>>> the normal "make check" is already too slow, e.g. while developing=
 new
>>>>>> patches, I sometimes just want to do a very quick sanity test to s=
ee
>>>>>> whether I broke some basic things or not, and only do the "make ch=
eck"
>>>>>> before I submit my patches.
>>>>>> So we would get three stages:
>>>>>>
>>>>>> - make check-fast =3D> For very, very quick sanity tests only
>>>>>>
>>>>>> - make check =3D> E.g. has to be run before submitting patches
>>>>>>
>>>>>> - make check-harder =3D> might run a very long time, so best suite=
d for
>>>>>>                        nightly regression tests etc.?
>>>>>>
>>>>>> Does that sound reasonable? And the crucial question: Who is going=
 to
>>>>>> implement the basic framework for this?
>>>>>
>>>>> There's already make check-unit or make check-qtest-x86_64 dependin=
g on
>>>>> what you're working on.
>>>>
>>>> True. And I just learned that you can also already set the SPEED
>>>> variable to either "quick" or "slow" and that we're already using
>>>> g_test_quick() and g_test_slow() in a couple of places to check this=
=2E So
>>>> the framework for running quick vs. thorough tests is already there =
=2E..
>>>> we just might want to add this to some more tests, I guess...
>>>>
>>>> Question for the maintainers and the test automation folks: Is anybo=
dy
>>>> already running "make check SPEED=3Dslow" or is this just rather an
>>>> unheard-of way of running the tests?
>>>>
>>>>> If you have a many-core machine, of course, there's no simpler solu=
tion
>>>>> than throwing more CPUs at it. :)
>>>>
>>>> Is it safe nowadays to run "make check -j4" for example? Last time I=

>>>> tried (maybe 1 or 2 years ago), there were still issues since some t=
ests
>>>> were using hard-coded temporary file names, so the parallel tests we=
re
>>>> disturbing each other, for example...
>>>>
>>>
>>> Actually the `.travis.yml` defines `MAKEFLAGS=3D"-j3"`, which results=
 in `make check` being executed with 3 threads...
>>>
>>> I was actually looking at the increasing number of failed travis buil=
ds and it seems to be related to the fluctuating performance. Running `ni=
ce -n 20 make check -j 12` with `nice -n 5 stress -c 20` in background re=
sults in the same kind of failures:
>>>
>>>     File '/tmp/qemu/include/qapi/qmp/qobject.h'
>>>     Lines executed:0.00% of 9
>>>     **
>>>     ERROR:tests/prom-env-test.c:42:check_guest_memory: assertion fail=
ed (signature =3D=3D MAGIC): (0x7c7f1b78 =3D=3D 0xcafec0de)
>>
>> I think you're simply running into timeout issues here since you're
>> likely overloading the host, I guess. Or does your host have that many=
 CPUs?
>> If the timeouts are really an issue here, we simply might have to
>> increase the timeout values a bit again...
>>
>=20
> The reason I did this is that the `make check -j 12` runs for ~ 4 minut=
es on my machine (8 cores) while in travis it sometimes runs even more th=
an 40 minutes. I wanted to get closer to see why is it failing and this m=
ight be the reason and yes, it's most certainly timeout issue. The proble=
m with Travis is it gives quite decent power, but sometimes it's slowed f=
or couple of seconds, or even minutes. This affects many of our (Avocado)=
 selftests so we usually have timeouts between 10-60s for operations that=
 usually take less than a second.

And we learned that even huge timeouts are not a valid solution, in fact
they can become a counter solution.  On many environments it's not wise
to even run tests are time sensitive.  Travis is one, Fedora package
build hosts are another example.

IMO, this signals that test metadata (and categorization on top of it)
can be of great help in many situations.  Instead of writing a multitude
of "make check-(you-characteristics-here)" targets, something like "make
EXCLUDE=3Dtime_senstitive check" is far more flexible.

Using Avocado as an example, it'd mean running something like:

 $ avocado run -t '-time_sensitive,-superuser' tests/*

- Cleber.

>=20
> Luk=C3=A1=C5=A1
>=20
> PS: Usually the `make check -j 12` works well on my machine...
>=20
>>  Thomas
>>
>=20
>=20

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--aR4aKgg3eAF3EevBkt5i2AQXO7JUm5krg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAlme2g8ACgkQZX6NM6Xy
CfM0nhAAlBiiSx215lAKlRBn8g/mbg+RyaceYzsIFuPnbOGsFe62CWu7inUFrnPc
Voylo+Vwg15Z6v0SvZEb9RhVDcS7FMLCubbzERqr+qkPfZQx71bwLnvhFVibRxl2
ZQwjsYAwdvmqEO1CZcRh+TtLwEwUo/eMEp8Ev0BYjJAnizAmpUoFODe6eThU4+aJ
DO+UBYeMviTJnlFSPLSrsaVf8fhn3hYv8oSq1zF7MW8h3M8+wH7v2MMUsscEAdLJ
ypR2gv4jAYRWu/gJME6FlDcUAnIU0KLxakTKYGQ7NjexDr1mj1NNeSoYOu4u5M1/
wtAWBVODQ7YR0U+/r3e88xSNofNF1P7+FACFpl1LCFQigUHbKeXo3AMBuz9fotqi
Uyooj5RfR4ZzlUWJQK/6shPEd2fdP+IJxFsn6Gh5k7qjA/z8rNUVSN/vrlAwE1YS
fW/aVxFc9gHaS9FL2BgZ+1SLL2hcinDHGp1/ZNkJRux43evoMDdqA299Lysv3xVZ
f3Vx98XSiXFTKfqlyd1/HqRL56fYXbyLppv3dfMJflyas9ZYDNy+rPnL535bFYMp
Xvt59PXxO/JXLUtsbro5ddFPBElG73klAqCd4N82DjuEg/+eTyowT6uL5hbyOkcZ
TS90BKv5J7AfL8iaCXwg92/8X5BHSHBB8zQp0zObVsQibL72g1U=
=F1Vw
-----END PGP SIGNATURE-----

--aR4aKgg3eAF3EevBkt5i2AQXO7JUm5krg--
