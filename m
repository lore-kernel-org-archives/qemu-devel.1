Received: from eggs.gnu.org ([2001:4830:134:3::10]:36786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fdU4D-0004fD-P1
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 01:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fdU49-0002wU-Me
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 01:23:01 -0400
References: <20180702062644.48040-1-aik@ozlabs.ru>
	<20180710122244.7466489f@aik.ozlabs.ibm.com>
	<20180710064248.GM22363@umbus.fritz.box>
	<20180710171453.6e3eee34@aik.ozlabs.ibm.com>
	<20180711062619.GQ22363@umbus.fritz.box>
	<20180711205305.0f3a42f1@aik.ozlabs.ibm.com>
	<20180712010152.GR22363@umbus.fritz.box>
	<a230a615-1dcb-dde9-6dae-bee8ef7c08fb@redhat.com>
	<20180712151448.13157365@aik.ozlabs.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a0a5ec57-6fe4-043d-e5a7-27ed27ad5361@redhat.com>
Date: Thu, 12 Jul 2018 07:22:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180712151448.13157365@aik.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="8VEU79WjLZ8FyQYKRnD0QkROEQ2fcOGE7"
Subject: Re: [Qemu-devel] [Qemu-ppc] [GIT PULL for qemu-pseries] pseries:
 Update SLOF firmware image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8VEU79WjLZ8FyQYKRnD0QkROEQ2fcOGE7
From: Thomas Huth <thuth@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <a0a5ec57-6fe4-043d-e5a7-27ed27ad5361@redhat.com>
Subject: Re: [Qemu-ppc] [GIT PULL for qemu-pseries] pseries: Update SLOF
 firmware image
References: <20180702062644.48040-1-aik@ozlabs.ru>
 <20180710122244.7466489f@aik.ozlabs.ibm.com>
 <20180710064248.GM22363@umbus.fritz.box>
 <20180710171453.6e3eee34@aik.ozlabs.ibm.com>
 <20180711062619.GQ22363@umbus.fritz.box>
 <20180711205305.0f3a42f1@aik.ozlabs.ibm.com>
 <20180712010152.GR22363@umbus.fritz.box>
 <a230a615-1dcb-dde9-6dae-bee8ef7c08fb@redhat.com>
 <20180712151448.13157365@aik.ozlabs.ibm.com>
In-Reply-To: <20180712151448.13157365@aik.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.07.2018 07:14, Alexey Kardashevskiy wrote:
> On Thu, 12 Jul 2018 07:01:34 +0200
> Thomas Huth <thuth@redhat.com> wrote:
>=20
>> On 12.07.2018 03:01, David Gibson wrote:
>>> On Wed, Jul 11, 2018 at 08:53:05PM +1000, Alexey Kardashevskiy wrote:=
 =20
>>>> On Wed, 11 Jul 2018 16:26:19 +1000
>>>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>>> =20
>>>>> On Tue, Jul 10, 2018 at 05:14:53PM +1000, Alexey Kardashevskiy wrot=
e: =20
>>>>>> On Tue, 10 Jul 2018 16:42:48 +1000
>>>>>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>>>>>    =20
>>>>>>> On Tue, Jul 10, 2018 at 12:22:44PM +1000, Alexey Kardashevskiy wr=
ote:   =20
>>>>>>>> On Mon,  2 Jul 2018 16:26:44 +1000
>>>>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>>>>      =20
>>>>>>>>> The following changes since commit edb1fb337f65f82fe32b989c4f01=
8efe85c1dddb:
>>>>>>>>>
>>>>>>>>>   pseries: Update SLOF firmware image (2018-07-02 16:21:30 +100=
0)
>>>>>>>>>
>>>>>>>>> are available in the git repository at:
>>>>>>>>>
>>>>>>>>>   git@github.com:aik/qemu.git tags/qemu-slof-20180702
>>>>>>>>>
>>>>>>>>> for you to fetch changes up to edb1fb337f65f82fe32b989c4f018efe=
85c1dddb:
>>>>>>>>>
>>>>>>>>>   pseries: Update SLOF firmware image (2018-07-02 16:21:30 +100=
0)
>>>>>>>>>
>>>>>>>>> ---------------------------------------------------------------=
-
>>>>>>>>>
>>>>>>>>> I just missed a couple of gcc 8.1 fixes and thought I can still=
 squeeze
>>>>>>>>> them before the 3.0  soft freeze.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> *** Note: this is not for master, this is for pseries     =20
>>>>>>>>
>>>>>>>>
>>>>>>>> Not good for 3.1 either?     =20
>>>>>>>
>>>>>>> Ugh.. somehow I missed this SLOF update request, and now we're in=
 3.0
>>>>>>> hard freeze.
>>>>>>>
>>>>>>> How bad are the bugs this SLOF update fixes?   =20
>>>>>>
>>>>>> These only fix gcc 8.1 warnings and runtime errors =3D> not really=

>>>>>> bugfixes so it is not a big deal if they miss 3.0.   =20
>>>>>
>>>>> Ok, well, if you want to resend the update, I'll queue it for 3.1. =
=20
>>>>
>>>>
>>>> It is still on github, why resend? =20
>>>
>>> Good point, done. =20
>>
>> Won't there be another update in the 3.1 time frame? If yes, this soun=
ds
>> like wasted space in the repository to me (the firmware blobs are rath=
er
>> big, and there are no new features in that binary, just fixes for
>> compiling with GCC 8 ... and people who want to compile SLOF on their
>> own can use the sources from aik's git tree, too).
>=20
> I compiled the blob with gcc 8.1 and if something goes wrong I'd rather=

> know this earlier than later - this my motivation, not the fixes
> themselves.

Ok, that's a fair argument. But in that case, I think it is even good
that this missed the hard freeze - you likely don't want to hunt
hard-to-debug compiler bugs in the freeze period, do you?

 Thomas


--8VEU79WjLZ8FyQYKRnD0QkROEQ2fcOGE7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJbRuWtAAoJEC7Z13T+cC21tCMP/0TOHbdeWUa3e0DDxujy/KHT
ELER/8vMj1Sgfgg3zQEG4pagNeABCq8WnBpmM1VM4Px+cggji7I7TgMzosbgJVwT
xxiawneoIizgrz0R1XRaB/ln33UDMn7AFtN2L6T02qfwdl85Eog9W3MBhQsahkzO
fEgWeWX91nWZR1v+CcH6p7jDUP7ZBLMHv7Uexy3ojjXerSTbMCB8Wpg4I6sj7x9w
j0FXealJxna3vB5BRozUH6TOhuHKB/MLJbe1ziv7JG6LMR9+osPhDqOCnB/Rxh2m
vpKAMMPeQHKKpraoHxeE+607qdKHcMg/O67+KMuS1tgcPvOgLTzTNKPEyLdTuFam
PmEjCfLIUlk5ygiqMfb6LoMUW53ojA88tPGVbYXcOrjKU2wDiRZYHTLx+ynlcqyX
z38ZHOJDj5K8tklOQQQbl92D/URAjE8UuRq4SX1SMBKB+B22VwbMXV6e+l6G7bnt
r7t1nzSpBZTWckoGEJE+pvhR0FVgTXOtwG43HdgbMVLoaEQf7mNvV0GHMrMdIZFv
3yqMwBciUccUYo8tPHpqPF6txC+65UuA7eSbipINiuBC7nhXyjaFje75iJLZw0k9
Uj9cmk4e0/zNqd4HzjeXock7fO56Yb933C1jM4CvUmV83jnKqXf4Eht+a3Rljh3D
gcXpBvUv549aEGgZ0K5y
=qQE8
-----END PGP SIGNATURE-----

--8VEU79WjLZ8FyQYKRnD0QkROEQ2fcOGE7--
