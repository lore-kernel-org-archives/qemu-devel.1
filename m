Received: from eggs.gnu.org ([2001:4830:134:3::10]:41891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eya3K-0004SD-98
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 05:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eya3F-0002ho-By
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 05:29:02 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:48081)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eya3F-0002hY-1G
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 05:28:57 -0400
References: <1521584722-39133-1-git-send-email-mjc@sifive.com>
	<7534728b-1511-3ba1-57b1-03423b83ad87@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <5d80ea1e-4092-3ba3-9a18-691de69489fe@vivier.eu>
Date: Wed, 21 Mar 2018 10:28:47 +0100
MIME-Version: 1.0
In-Reply-To: <7534728b-1511-3ba1-57b1-03423b83ad87@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4sUCDQGD27oZqaEpRlol7KgHwoZPgjbSS"
Subject: Re: [Qemu-devel] [PULL 00/25] RISC-V Post-merge spec conformance
 and cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Michael Clark <mjc@sifive.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4sUCDQGD27oZqaEpRlol7KgHwoZPgjbSS
From: Laurent Vivier <laurent@vivier.eu>
To: Thomas Huth <thuth@redhat.com>, Michael Clark <mjc@sifive.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <5d80ea1e-4092-3ba3-9a18-691de69489fe@vivier.eu>
Subject: Re: [Qemu-devel] [PULL 00/25] RISC-V Post-merge spec conformance and
 cleanup
References: <1521584722-39133-1-git-send-email-mjc@sifive.com>
 <7534728b-1511-3ba1-57b1-03423b83ad87@redhat.com>
In-Reply-To: <7534728b-1511-3ba1-57b1-03423b83ad87@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 21/03/2018 =C3=A0 08:05, Thomas Huth a =C3=A9crit=C2=A0:
> On 20.03.2018 23:25, Michael Clark wrote:
>> The following changes since commit f1a63fcfcd92c88be8942b5ae71aef9749a=
4f135:
>>
>>   Update version for v2.12.0-rc0 release (2018-03-20 19:04:22 +0000)
>>
>> are available in the git repository at:
>>
>>   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-2.12-fixes
>>
>> for you to fetch changes up to e1a247183ac0816284dfda61423f7030b668667=
9:
>>
>>   RISC-V: Remove erroneous comment from translate.c (2018-03-20 14:34:=
13 -0700)
>>
>> ----------------------------------------------------------------
>> This is a series of spec conformance bug fixes and code cleanups
>> that we would like to get in before the QEMU 2.12 release.
>=20
>  Hi Michael,
>=20
> for future PULL request, could you please send out all patches again
> that should be pulled, and not send the cover letter alone? I.e. do a
> "git format-patch --subject-prefix PULL ..." and then replace the
> contents of the cover letter with the output of "git request-pull".
>=20
> ... this is how all other maintainers are sending PULL requests (at
> least as far as I know) and this way everybody gets a very final chance=

> to have a look at the patches in their final state (it does not happen
> very often that someone replies to such patches, but in some rare cases=

> we already found problems this way).

You can also use git-publish that is a very simple tool to manage patch
series revision and to send pull request in an easy way.

https://github.com/stefanha/git-publish

Thanks,
Laurent


--4sUCDQGD27oZqaEpRlol7KgHwoZPgjbSS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEzS913cjjpNwuT1Fz8ww4vT8vvjwFAlqyJc8ACgkQ8ww4vT8v
vjzwjA/+J7JIFTRMs1bMBA9AGPPUxqpxvkqPGvJf9tXnlZyZladVJYF9oYHOZkyx
MjoBIEb2WEdNirFe//uPqG2baMI5+JzJ3r/nRhpL/Sm6cEqoPbIbHc9BfHudI8NU
FqguxAffLDiK7d7sf0p2CudMaT25cDHbbfEMukV3xISrAfFdBGa8zCRg+tfE7GnG
QOnsjjZwCtTkkiM5WjkbDKiKNjnw6r0n12EDPEESTDBJVM6Zg5ci3HlJiKE5Rqpt
ftFzLEL0PxVbUktHC3Wo0k7/gHzO/HOMZsVnoIQ+rPCrNsx/G++Vx4DdiuS5hun0
BRrb3UViapvwf8cjvhYpcW2od251pc6Ka0C7u83crjZiCllkK60aMC8WLGJxldin
yr3tcRTUiF01nU1YbY8NJihTF0/OuVdPnrkfU0bk+6S2wRXGIa5oI1A4XiVQqe8y
7GYHAKFaAd6b/kUXnE14+g+/XV3+zVU/K6e+D13QtYYqUjUWQDnaEglgoXwWf8UX
GsU3QH1F6vFZJbPzUmUP8RUnIHzPMIFYqGTGotTTwTmIUDI/Vw27Kq8w4Iy5hFpK
ezHwwdLFAef+lP+hmTWXP11D975JnFQqnYqlMQvHCrZ3yDgs1X6IzwttIZcxwU5X
SJjNqjA/n7S9d/eJhrxh4tz2RViPdOYKG8JczqiBg7YrbnVji70=
=SqHp
-----END PGP SIGNATURE-----

--4sUCDQGD27oZqaEpRlol7KgHwoZPgjbSS--
