Received: from eggs.gnu.org ([2001:4830:134:3::10]:50377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cPB7h-0006ea-PK
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:42:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cPB7d-0006Om-Pb
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:42:41 -0500
Received: from ignoranthack.me ([199.102.79.106]:52657
	helo=mail.ignoranthack.me)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbruno@freebsd.org>) id 1cPB7d-0006O2-Jf
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:42:37 -0500
References: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
	<e90abf9b-f474-2adc-1b2d-5d1df7fb1505@freebsd.org>
	<CAFEAcA9ayxt_fNRd1eRkJVFMa4tEx=nPwAF0L6p23Z1f_XQOYQ@mail.gmail.com>
From: Sean Bruno <sbruno@freebsd.org>
Message-ID: <e0c0a50a-4a5b-cb62-e729-ac95f3ea6206@freebsd.org>
Date: Thu, 5 Jan 2017 09:42:35 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9ayxt_fNRd1eRkJVFMa4tEx=nPwAF0L6p23Z1f_XQOYQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="U8L70dgSoTawbA4F8ScLqM8arufg6RHw7"
Subject: Re: [Qemu-devel] New Year's starting over ... bsd-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U8L70dgSoTawbA4F8ScLqM8arufg6RHw7
From: Sean Bruno <sbruno@freebsd.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <e0c0a50a-4a5b-cb62-e729-ac95f3ea6206@freebsd.org>
Subject: Re: [Qemu-devel] New Year's starting over ... bsd-user
References: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
 <e90abf9b-f474-2adc-1b2d-5d1df7fb1505@freebsd.org>
 <CAFEAcA9ayxt_fNRd1eRkJVFMa4tEx=nPwAF0L6p23Z1f_XQOYQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9ayxt_fNRd1eRkJVFMa4tEx=nPwAF0L6p23Z1f_XQOYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 01/05/17 09:11, Peter Maydell wrote:
> On 5 January 2017 at 16:03, Sean Bruno <sbruno@freebsd.org> wrote:
>> Ok, this is probably too big for a single patch.  I'll see if its
>> reasonable to break this up across *some* kind of logic boundary.
>=20
> Yeah, that's pretty huge. My rough rule of thumb: prefer
> each patch to be <500 lines, prefer <20 patches in a patchset.
>=20
> thanks
> -- PMM
>=20

Ok, let's try a small one patch change for the first pass while I work
on a larger patch series.

sean


--U8L70dgSoTawbA4F8ScLqM8arufg6RHw7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGTBAEBCgB9FiEEuq1GMucSHejSCZfdEgHvyh5yfmQFAlhud3tfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJB
QUQ0NjMyRTcxMjFERThEMjA5OTdERDEyMDFFRkNBMUU3MjdFNjQACgkQEgHvyh5y
fmRTywf+P0VVHYqG1Q2jAVLCdM9YmHsYxTgywU5sZkDBe+YPKTa1EgOzCCMpwt8C
PJEUjYt3rpHwfSfjaQPrhTLhMmT0c/BOVvFJ847mCZuBvUykzK/rw/P8eO62BWOW
+aP4k6nMJezS+Ddukp7Rb02j9xJhOMBLdLt7lWt029PAzuS9No60infgLcP6U+t5
m9b+UIEtX2zQIxWQXagFxs+wkb1jo0/tK2ilKI0+EgesGGX9ADvrh3baZ5oE45si
6gaFuj0IzIRfpOdO/6NtWQWggH9tBZH5YiO+cKYBfk/Efihqxql2FOcOyvDUpb59
x+pRPsnoPmadjU/UeFaxNDCaFE49iQ==
=lpHD
-----END PGP SIGNATURE-----

--U8L70dgSoTawbA4F8ScLqM8arufg6RHw7--
