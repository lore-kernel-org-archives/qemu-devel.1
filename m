Received: from eggs.gnu.org ([2001:4830:134:3::10]:39602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1etQI4-0007AR-L4
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 23:02:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1etQHz-00012Q-Ob
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 23:02:56 -0500
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:36267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1etQHz-00010l-Dp
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 23:02:51 -0500
Received: by mail-pf0-x22f.google.com with SMTP id 68so466364pfx.3
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 20:02:51 -0800 (PST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20171016093641.GH2776@umbus.fritz.box>
	<e419ca8a-6e0b-70eb-14da-03a843fa8b92@ozlabs.ru>
	<20171019062440.GY2776@umbus.fritz.box>
	<699e58bf-de22-5341-ecc6-458df7ccbe65@ozlabs.ru>
	<9227196b-789c-e4b2-c9c5-4fd95ed42b4e@ozlabs.ru>
	<20171109063822.GD7732@umbus.fritz.box>
	<d6f4ad92-bd83-b990-4e86-ac89638c44d0@ozlabs.ru>
	<9fabc6c4-9a95-d44e-dc4c-33d91c00fb0c@ozlabs.ru>
	<20180103000947.GE24581@umbus.fritz.box>
	<9188ab4a-f3d6-3cfb-ae26-a24f7781fad1@ozlabs.ru>
	<20180110085958.GJ19773@umbus.fritz.box>
	<6b829875-ce25-5b15-9a22-2b46bc4ed773@ozlabs.ru>
Message-ID: <8f09881e-971b-1afc-842a-1039f01060a3@ozlabs.ru>
Date: Wed, 7 Mar 2018 15:02:43 +1100
MIME-Version: 1.0
In-Reply-To: <6b829875-ce25-5b15-9a22-2b46bc4ed773@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6BchfRTTL8BrOhbOkk4NjCtGv1ZZtUvzM"
Subject: Re: [Qemu-devel] [PATCH qemu v3] RFC: ppc/spapr: Receive and store
 device tree blob from SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Balbir Singh <bsingharora@gmail.com>, Greg Kurz <groug@kaod.org>, slof@lists.ozlabs.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6BchfRTTL8BrOhbOkk4NjCtGv1ZZtUvzM
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Balbir Singh <bsingharora@gmail.com>, Greg Kurz <groug@kaod.org>,
 slof@lists.ozlabs.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Message-ID: <8f09881e-971b-1afc-842a-1039f01060a3@ozlabs.ru>
Subject: Re: [PATCH qemu v3] RFC: ppc/spapr: Receive and store device tree
 blob from SLOF
References: <20171016093641.GH2776@umbus.fritz.box>
 <e419ca8a-6e0b-70eb-14da-03a843fa8b92@ozlabs.ru>
 <20171019062440.GY2776@umbus.fritz.box>
 <699e58bf-de22-5341-ecc6-458df7ccbe65@ozlabs.ru>
 <9227196b-789c-e4b2-c9c5-4fd95ed42b4e@ozlabs.ru>
 <20171109063822.GD7732@umbus.fritz.box>
 <d6f4ad92-bd83-b990-4e86-ac89638c44d0@ozlabs.ru>
 <9fabc6c4-9a95-d44e-dc4c-33d91c00fb0c@ozlabs.ru>
 <20180103000947.GE24581@umbus.fritz.box>
 <9188ab4a-f3d6-3cfb-ae26-a24f7781fad1@ozlabs.ru>
 <20180110085958.GJ19773@umbus.fritz.box>
 <6b829875-ce25-5b15-9a22-2b46bc4ed773@ozlabs.ru>
In-Reply-To: <6b829875-ce25-5b15-9a22-2b46bc4ed773@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15/02/18 16:43, Alexey Kardashevskiy wrote:
> On 10/01/18 19:59, David Gibson wrote:
>> On Mon, Jan 08, 2018 at 07:35:43PM +1100, Alexey Kardashevskiy wrote:
>>> On 03/01/18 11:09, David Gibson wrote:
>>>> On Tue, Jan 02, 2018 at 05:13:09PM +1100, Alexey Kardashevskiy wrote=
:
>>>>> On 11/12/17 17:20, Alexey Kardashevskiy wrote:
>>>>>> On 09/11/17 17:38, David Gibson wrote:
>>>>>>> On Tue, Nov 07, 2017 at 06:14:04PM +1100, Alexey Kardashevskiy wr=
ote:
>>>>>>>> On 20/10/17 11:46, Alexey Kardashevskiy wrote:
>>>>>>>>> On 19/10/17 17:24, David Gibson wrote:
>>>>>>>>>> On Tue, Oct 17, 2017 at 04:55:03PM +1100, Alexey Kardashevskiy=
 wrote:
>>>>>>>>>>> On 16/10/17 20:36, David Gibson wrote:
>>>>>>>>>>>> On Mon, Oct 16, 2017 at 04:20:04PM +1100, Alexey Kardashevsk=
iy
>>>>>>>>>>> wrote:
>>>>>>>>>> [snip]
>>>>>>>>>>>> ||
>>>>>>>>>>>>
>>>>>>>>>>>> Yeah.. this is all a bit complicated, I'm really thinking ab=
out a
>>>>>>>>>>>> fdt_fsck() function for libfdt.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Oh. So what now? Do as below or wait for libdtc update?
>>>>>>>>>>
>>>>>>>>>> So I started hacking on this.  It's a bit fiddlier to get righ=
t than I
>>>>>>>>>> anticipated.  How about you make a placeholder function to "te=
st" the
>>>>>>>>>> tree for now, with a comment that it will be updated once the =
libfdt
>>>>>>>>>> extensions are there.
>>>>>>>>>
>>>>>>>>> What would the placeholder do? Nothing or my proposed "FDT_CHK"=
 thingy?
>>>>>>>>>
>>>>>>>>> Are we in a hurry with this one at all, or I can wait till libf=
dt gets this
>>>>>>>>> fsck()?
>>>>>>>>
>>>>>>>>
>>>>>>>> Ping?
>>>>>>>>
>>>>>>>> This is not v2.11 material, is it?
>>>>>>>
>>>>>>> Not at this stage, no.
>>>>>>>
>>>>>>> I've started looking at writing the fdt_fsck() thing, but got
>>>>>>> sidetracked by a bunch of related fixes to safety of handling
>>>>>>> corrupted blobs in libfdt.
>>>>>>
>>>>>> Please let me know when I can repost the "
>>>>>> ppc/spapr: Receive and store device tree blob from SLOF" again. Th=
anks.
>>>>>
>>>>>
>>>>> Still to early to repost?
>>>>
>>>> No.
>>>
>>>
>>> I looked at the recent libfdt (from qemu tree, sha1  e543880, v1.4.6)=
 and
>>> could not find fdt_fsck() or similar, and I was waiting for this real=
ly,
>>> have I missed something?
>>
>> Oh, right, yeah, I haven't had time to look at that again.
>=20
>=20
> Any progress with fdt_fsck()? Thanks,


Ping?


--=20
Alexey


--6BchfRTTL8BrOhbOkk4NjCtGv1ZZtUvzM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAlqfZGMOHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILlX/g/9EYObFfKRjC2+16lOrboV9okelGp49wYJh0Vr
Ew/Qk4YJPoDE8DpdaUroe3gqBmMDo2k6XLo0LRmonc0VhzDql4CDwkNv/jVDW63S
7Pxi3VonZl9fb8Ut/nK9YACPS207HBaA9ArQJQ3pZcLDFsX5c+JsVh7Lkr41m/ku
yIsaYpDWxkxlIOI+sqoLMxLfWyX/ZoukdSth9zZ9ebj4/cD0gufdQQzjItWz8f+3
BjWiuRLzRzFKawCAfMIVtuVC+3T9psNVw1Mw4CtavhOurXHdDZmeLKFZohrij547
0N60nvWYSeV/T3g3gqiJgeBkx/T640ufBT2r3ZZW9EprJap+b+3Z+4ZWpnYbaem7
+xXlDfg6P3zy77TErWAQzwvpTY8LmiDbPB7yKsQ8aXNfyfahX8BRguAPfTWtzJvx
aeswnbNwHoLYAwukUWsyqdpUC81Emt8nxMdGN3yifdgfutHg/dsBfePE2R+nEWL1
yeespmCnSz7uA6FzxRWjbszj1TsoBpWC0Bei2PTpAwKQAE9wvp/noSkV8nwmqzWN
taeOcgOZ2FQ6riZc7K88L2Q7yl37IRAXWokkb6qskMGWZnJEOTmR7nsJUUgFrDlX
IvsFuwH4ZixTyH6gSy9+PuA2jLByyoG2E43fA1KPLUtd12iTiXrCPw4roA8evDl/
AeBhdBQ=
=FXl5
-----END PGP SIGNATURE-----

--6BchfRTTL8BrOhbOkk4NjCtGv1ZZtUvzM--
