Received: from eggs.gnu.org ([2001:4830:134:3::10]:58948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gSknm-00072z-Jj
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:33:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gSknl-0002nx-Jg
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:33:58 -0500
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
	<20181129101801.6421-3-vsementsov@virtuozzo.com>
	<2f4c1bec-b5ca-e97f-88f9-75f3d2cb210c@redhat.com>
	<e9e07da0-0cd8-9820-642a-ab4fe227afc8@virtuozzo.com>
	<abcad6d9-2d40-15b4-9bce-964f6a3141a0@redhat.com>
	<73cb2885-3a40-6d2b-24fa-c528decdbc9b@virtuozzo.com>
	<20181130141017.GF5106@localhost.localdomain>
	<97939091-38e2-565b-7aa3-cfb9ebf239cb@virtuozzo.com>
	<e6a8ba59-4871-35f4-88a4-43567997e3bc@redhat.com>
	<8a2d8bc5-1144-9b20-c80c-934a9c732e2c@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a8113670-91d6-4c6b-fe1c-d124e5015f36@redhat.com>
Date: Fri, 30 Nov 2018 16:33:37 +0100
MIME-Version: 1.0
In-Reply-To: <8a2d8bc5-1144-9b20-c80c-934a9c732e2c@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zatGGsJ8Y7s8mDBtP4hpCSnfOuFkWVBNR"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: simple mirror test with
 kvm on 1G image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jcody@redhat.com" <jcody@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zatGGsJ8Y7s8mDBtP4hpCSnfOuFkWVBNR
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jcody@redhat.com" <jcody@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Message-ID: <a8113670-91d6-4c6b-fe1c-d124e5015f36@redhat.com>
Subject: Re: [PATCH v2 2/2] iotests: simple mirror test with kvm on 1G image
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
 <20181129101801.6421-3-vsementsov@virtuozzo.com>
 <2f4c1bec-b5ca-e97f-88f9-75f3d2cb210c@redhat.com>
 <e9e07da0-0cd8-9820-642a-ab4fe227afc8@virtuozzo.com>
 <abcad6d9-2d40-15b4-9bce-964f6a3141a0@redhat.com>
 <73cb2885-3a40-6d2b-24fa-c528decdbc9b@virtuozzo.com>
 <20181130141017.GF5106@localhost.localdomain>
 <97939091-38e2-565b-7aa3-cfb9ebf239cb@virtuozzo.com>
 <e6a8ba59-4871-35f4-88a4-43567997e3bc@redhat.com>
 <8a2d8bc5-1144-9b20-c80c-934a9c732e2c@virtuozzo.com>
In-Reply-To: <8a2d8bc5-1144-9b20-c80c-934a9c732e2c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.11.18 16:24, Vladimir Sementsov-Ogievskiy wrote:
> 30.11.2018 17:59, Max Reitz wrote:
>> On 30.11.18 15:51, Vladimir Sementsov-Ogievskiy wrote:
>>> 30.11.2018 17:10, Kevin Wolf wrote:
>>>> Am 30.11.2018 um 14:48 hat Vladimir Sementsov-Ogievskiy geschrieben:=

>>>>> 30.11.2018 16:13, Max Reitz wrote:
>>>>>> On 30.11.18 14:06, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> 30.11.2018 15:30, Max Reitz wrote:
>>>>>>>> On 29.11.18 11:18, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>>>> This test is broken without previous commit fixing dead-lock in=
 mirror.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozz=
o.com>
>>>>>>>>> ---
>>>>>>>>>      tests/qemu-iotests/235     | 59 ++++++++++++++++++++++++++=
++++++++++++
>>>>>>>>>      tests/qemu-iotests/235.out |  1 +
>>>>>>>>>      tests/qemu-iotests/group   |  1 +
>>>>>>>>>      3 files changed, 61 insertions(+)
>>>>>>>>>      create mode 100755 tests/qemu-iotests/235
>>>>>>>>>      create mode 100644 tests/qemu-iotests/235.out
>>>>>>>> I'll get to the first patch in a second, but first a suggestion =
for this
>>>>>>>> patch: I think it's not so good to use 2 GB of space for a test =
(1 GB
>>>>>>>> for the source, 1 GB for the target).  So I tried my luck and fo=
und that
>>>>>>>> the test works, too, if you just use preallocation=3Dmetadata fo=
r the
>>>>>>>> source (instead of actually writing data) and blockdev-mirror'in=
g the
>>>>>>>> data to a throttled null-co device.
>>>>>>>
>>>>>>> Hmm, so parsing metadata is enough for qcow2 to yield on write, y=
es?
>>>>>>
>>>>>> Apparently so.  If you can confirm that applying those changes to =
the
>>>>>> test still make it work (i.e., fail before patch 1, pass afterward=
s),
>>>>>> then I think it is just as good.
>>>>>
>>>>> Ok, I've checked that your changes works for me.
>>>>>
>>>>> hm, but we write to null, so, yield on write comes from throttling,=
 however,
>>>>> without preallocation=3Dmetadata, it don't work.., do you know, why=
 we need
>>>>> preallocation to reproduce?
>>>>
>>>> If I should take a guess, probably because mirror only copies alloca=
ted
>>>> clusters?
>>>>
>>>> Kevin
>>>>
>>>
>>> hm, so, what preallocation=3Dmetadata does? I thought, it preallocate=
s tables, but all qcow2 clusters would be unallocated..
>>
>> No, it initializes all metadata structures (i.e., L2 tables) so they
>> point to data clusters; which is why you cannot use it with backing
>> files.  It's just that the data clusters are not written.
>=20
> so, clusters are allocated? in this case, we don't avoid allocating of =
1G, but only have a performance gain?

The data isn't written, so less than 1 MB are actually allocated on-disk.=


The L2 tables do point to offsets over a range of 1 GB, but they should
all be holes on the filesystem.

Max


--zatGGsJ8Y7s8mDBtP4hpCSnfOuFkWVBNR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlwBWFEACgkQ9AfbAGHV
z0CwMAgAqhQAgSGjscLhHVcEHsC/eJDjLgNdmro5Oj9KoEpxrheTfzOWfV3Cp9+M
6hul6IxwsjIcPoTLEdOxqGVPt3UPj7+t/7XO+urYo0X31lO59HDmikHWRTUV6r1E
RLI/nVpnQ3ZNQeRtG6mNjF5JsmTJAFB708kDAABjuEgSzYLpDExdBR+9IGHb5ea2
RXAjbadF6iK61wi8X3cGr8jbmTIOAGJS45UQ8rklpnDg/ZkLLTGD0h5eJSHxE6ZH
pNrajSzogpDOdIREBmC1rP6nOgBx3eMXe/WckSv67DhAlmw0ed4TkwljcQ0zsRdN
pnU7I37Beam1Fk1zmdRHFO7Z9ve9ug==
=g3rs
-----END PGP SIGNATURE-----

--zatGGsJ8Y7s8mDBtP4hpCSnfOuFkWVBNR--
