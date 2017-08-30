Received: from eggs.gnu.org ([2001:4830:134:3::10]:51717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dn9Ey-0000js-5v
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:05:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dn9Ev-0000Mf-1k
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:05:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dn9Eu-0000MN-Oe
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:05:28 -0400
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
	<1502951113-4246-3-git-send-email-thuth@redhat.com>
	<20170817104122.4d72674b.cohuck@redhat.com>
	<98d06e4e-b0e9-9a44-195a-3aab6f3cf219@redhat.com>
	<20170818095448.226fc4e9.cohuck@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <34f910ca-58a7-79ee-2c94-ca9d59517c33@redhat.com>
Date: Wed, 30 Aug 2017 16:05:21 -0400
MIME-Version: 1.0
In-Reply-To: <20170818095448.226fc4e9.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HIdrikwLptiRjf9qRALh308gpcAtAG3Lm"
Subject: Re: [Qemu-devel] [PATCH 2/6] tests: Add network filter tests to the
 check-qtest-s390x list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Yang Hongyang <yanghy@cn.fujitsu.com>, Michael S Tsirkin <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HIdrikwLptiRjf9qRALh308gpcAtAG3Lm
From: Cleber Rosa <crosa@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
 Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>,
 Eric Farman <farman@linux.vnet.ibm.com>,
 Zhang Chen <zhangchen.fnst@cn.fujitsu.com>,
 Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>,
 Halil Pasic <pasic@linux.vnet.ibm.com>,
 Janosch Frank <frankja@linux.vnet.ibm.com>,
 Jason J Herne <jjherne@linux.vnet.ibm.com>,
 Jing Liu <liujbjl@linux.vnet.ibm.com>,
 Pierre Morel <pmorel@linux.vnet.ibm.com>,
 QingFeng Hao <haoqf@linux.vnet.ibm.com>,
 Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>,
 Yang Chen <bjcyang@linux.vnet.ibm.com>,
 Yi Min Zhao <zyimin@linux.vnet.ibm.com>,
 Yang Hongyang <yanghy@cn.fujitsu.com>, Michael S Tsirkin <mst@redhat.com>
Message-ID: <34f910ca-58a7-79ee-2c94-ca9d59517c33@redhat.com>
Subject: Re: [PATCH 2/6] tests: Add network filter tests to the
 check-qtest-s390x list
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
 <1502951113-4246-3-git-send-email-thuth@redhat.com>
 <20170817104122.4d72674b.cohuck@redhat.com>
 <98d06e4e-b0e9-9a44-195a-3aab6f3cf219@redhat.com>
 <20170818095448.226fc4e9.cohuck@redhat.com>
In-Reply-To: <20170818095448.226fc4e9.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/18/2017 03:54 AM, Cornelia Huck wrote:
> On Thu, 17 Aug 2017 16:02:00 +0200
> Thomas Huth <thuth@redhat.com> wrote:
>=20
>> On 17.08.2017 10:41, Cornelia Huck wrote:
>>> On Thu, 17 Aug 2017 08:25:09 +0200
>>> Thomas Huth <thuth@redhat.com> wrote:
>>>  =20
>>>> With some small modifications, we can also use the the netfilter,
>>>> the fiter-mirror and the filter-redirector tests on s390x. =20
>>>
>>> s/fiter/filter/ =20
>>
>> OK ... could you please fix that when picking up the patch (in case I =
do
>> not have to resend)?
>=20
> Sure.
>=20
>>
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>  tests/Makefile.include         |  3 +++
>>>>  tests/test-filter-mirror.c     |  9 +++++++--
>>>>  tests/test-filter-redirector.c | 22 ++++++++++++++++------
>>>>  tests/test-netfilter.c         | 11 ++++++++++-
>>>>  4 files changed, 36 insertions(+), 9 deletions(-)
>>>> =20
>>>  =20
>>>> diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c=

>>>> index a1d5865..d569d27 100644
>>>> --- a/tests/test-filter-mirror.c
>>>> +++ b/tests/test-filter-mirror.c
>>>> @@ -25,6 +25,11 @@ static void test_mirror(void)
>>>>      char *recv_buf;
>>>>      uint32_t size =3D sizeof(send_buf);
>>>>      size =3D htonl(size);
>>>> +    const char *devstr =3D "e1000";
>>>> +
>>>> +    if (g_str_equal(qtest_get_arch(), "s390x")) {
>>>> +        devstr =3D "virtio-net-ccw";
>>>> +    } =20
>>>
>>> I'm wondering if we could unify selection of the network device
>>> somehow. There's probably two cases:
>>> - Test a specific device. This obviously needs to be decided
>>>   individually.
>>> - Just use a functional network device. For s390x, this will be
>>>   virtio-net-ccw; for other architectures, this test uses e1000, whil=
e
>>>   one of the tests below uses rtl8139 (why?). A helper for that may b=
e
>>>   useful. =20
>>
>> Maybe ... OTOH, this likely increases also test coverage if we do not
>> use the same PCI NIC in all the tests...?
>=20
> It just looks like a bit of unneeded churn to me.
>=20
> Re coverage: Do we have a very simple test that we can run for all kind=

> of NICs? This would give some reliable testing for various devices
> instead of having to rely on people picking different devices for their=

> tests...
>=20

The ideal approach here would be to have a predictable default network
(or any other kind of) device selection, per-target.  Then, no one would
wonder if rtl8139 was chosen on purpose for this specific test.

Besides the default predictable selection, the framework should provide
a way for test *runners* to switch to another device at test run-time.
This is the kind of thing that can improve the coverage a lot, at a very
low development cost.

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--HIdrikwLptiRjf9qRALh308gpcAtAG3Lm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAlmnGoEACgkQZX6NM6Xy
CfMaXw//fkGh2Xa+P955bw5Bz2A124a8gqxhHIM2ZDrJyrB1FQG62baFgzZholXa
OGM87BdI4RXdtXoLHuFjDFNXODzeDfYOkUhSKEmm9MOBKe3YB6V8eJjV/ZxUWt7j
AC39G4YE6NILdN73Fxqn+QcrQrJJG/NqUdhYk1Pfv/bdp5NaqV66xXYDNc1k9KJk
jWThatBWlkDuCdAHwBKKw7uSSZsmtiygGrC1aQvoaaz9gLZvvJ7daOolc0Z3WtnE
X2L7sJBpUOf1T7EwRTvgkpVSEBk3RPPXfAI7Rol/Eyv/99xYPxZwjOcs3//nEBhS
esfNwwD4eSgo9Sbk3TLukBzUNdrbq/VoAFE8wAyeqGgX0n1glLt57gU5Y+Fx1O/t
xGmwRo0U/Ud/emvel+X0KWEAOheVtSD9U0tF5vfqZZxmDAHX03xmN8eGijI7AJa7
3sISCLJEiDZvnHEVamgmlP84wAgaKlCo+fbNgLvpapJGhS8ol7naTWGDQ3vZDV3l
Hx5XZNGMHFyVZZ0hwgn3/5fEWNEIVoaMYkGLkoDgmpOd1K2h90dU6H0MngHns0jo
ucOEe8tO+F+v3BJI0vMubZCFLfc0DQ5E+b6++dCpC36rwoV9llNLkqBc2trEom1/
oj15Pt8j5s2vbIKZ8DxIeVrdv8DZeCPck7UrWZkXW4PJRXSDKro=
=24JL
-----END PGP SIGNATURE-----

--HIdrikwLptiRjf9qRALh308gpcAtAG3Lm--
