Received: from eggs.gnu.org ([209.51.188.92]:59744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gopU8-0001ti-CF
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:00:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gopU2-0007sR-GC
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:00:56 -0500
References: <20181217224348.14922-1-mreitz@redhat.com>
	<c62e3c26-de97-6af2-85ae-ba75a3e4956a@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <180509a6-ed6b-1d02-49d6-805309f5e02b@redhat.com>
Date: Wed, 30 Jan 2019 14:00:36 +0100
MIME-Version: 1.0
In-Reply-To: <c62e3c26-de97-6af2-85ae-ba75a3e4956a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3GKVKuOhDvInXFXLzMsCoAXDSFN13lml0"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v12 00/31] block: Fix some
 filename generation issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3GKVKuOhDvInXFXLzMsCoAXDSFN13lml0
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <180509a6-ed6b-1d02-49d6-805309f5e02b@redhat.com>
Subject: Re: [Qemu-block] [PATCH v12 00/31] block: Fix some filename
 generation issues
References: <20181217224348.14922-1-mreitz@redhat.com>
 <c62e3c26-de97-6af2-85ae-ba75a3e4956a@redhat.com>
In-Reply-To: <c62e3c26-de97-6af2-85ae-ba75a3e4956a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.01.19 21:51, John Snow wrote:
>=20
>=20
> On 12/17/18 5:43 PM, Max Reitz wrote:
>> Once more, I=E2=80=99ll spare both me and you another iteration of the=
 cover
>> letter, so I direct you to the previous version=E2=80=99s cover letter=
 (which
>> will direct you further):
>>
>> http://lists.nongnu.org/archive/html/qemu-block/2018-10/msg00229.html
>>
>> There are only minor changes in this version.  Provided no major
>> complaints arise, I intend to merge this series in the next month.
>>
>=20
> It looked like this got a full set of reviews by Berto, should we not
> just merge it and see who cries?
>=20
> Would you like additional eyes on it?

I was about to rebase it (and send it again with a shorter "I will merge
this" period), but then I found that a non-non-significant number of
iotests failed, so I wanted to fix those first.

Max


--3GKVKuOhDvInXFXLzMsCoAXDSFN13lml0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxRn/QACgkQ9AfbAGHV
z0CORggAk1pBggVRD9vWxEMOWo7S7IQXUkSv6eT/lOfwpnwoc97vaSQldVD4nC4P
mKdw4SMt2+bF2ZpFUw5eitx/FvUJUbUiR0aOSBVmr0MhmMU1fVY57IaaTnR9Ocrg
iHMStl95ocMuDEr2xI/wBejmRLL5vDACqEyfC1SMM6RyQ5ateKvf2lWV8i9+0Lqm
rEl5PvAoQlaDx/NU78QgZs/MF0P/bpPUqK3jreWmJRqeel5GBNOkQDkxuMmVt0DJ
BGLOuTORkOQLbSuKEmDAWmGx8snYXMa13ToV0ewxFuaDdY85t7Nmfrcm3v4WPEnZ
+eiln8MFzTfyl0/iP2zMO4fD5b8JDw==
=ULcz
-----END PGP SIGNATURE-----

--3GKVKuOhDvInXFXLzMsCoAXDSFN13lml0--
