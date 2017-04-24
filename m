Received: from eggs.gnu.org ([2001:4830:134:3::10]:34291)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1d2Yxa-0007Qf-Cc
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 04:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1d2YxX-0007dT-9q
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 04:03:02 -0400
Received: from mout.gmx.net ([212.227.15.15]:63280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1d2YxW-0007az-Um
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 04:02:59 -0400
References: <e1b08f20-77e6-83c8-85e6-b73c645c44c1@gmx.com>
	<CAFEAcA-ycgLSU9aX1Ywd1Pky2bquqefJbsRpNvo4DuaXOyL3SQ@mail.gmail.com>
	<3c22d799-1f28-a220-59d7-4218307748e5@gmx.com>
	<20170424072604.GE316@lemon.lan>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <838f86dd-70f4-83db-ce4d-7341728ba796@gmx.com>
Date: Mon, 24 Apr 2017 09:54:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170424072604.GE316@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JLnbx50JrxV7e4FDTHiTN79orN6N2Xg7D"
Subject: Re: [Qemu-devel] NetBSD maintenance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JLnbx50JrxV7e4FDTHiTN79orN6N2Xg7D
From: Kamil Rytarowski <n54@gmx.com>
To: Fam Zheng <famz@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <838f86dd-70f4-83db-ce4d-7341728ba796@gmx.com>
Subject: Re: [Qemu-devel] NetBSD maintenance
References: <e1b08f20-77e6-83c8-85e6-b73c645c44c1@gmx.com>
 <CAFEAcA-ycgLSU9aX1Ywd1Pky2bquqefJbsRpNvo4DuaXOyL3SQ@mail.gmail.com>
 <3c22d799-1f28-a220-59d7-4218307748e5@gmx.com>
 <20170424072604.GE316@lemon.lan>
In-Reply-To: <20170424072604.GE316@lemon.lan>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 24.04.2017 09:26, Fam Zheng wrote:
> On Mon, 04/24 00:45, Kamil Rytarowski wrote:
>> I will have a look and try to build qemu from git (master branch).
>>
>> I also find it surprising that there was a call for CI machines and
>> there is no infrastructure for it.
>=20
> There are. We use travis and patchew. I don't know a lot about NetBSD t=
esting
> with travis, but patchew has x86_64 and s390x machines that test patche=
s, and
> welcomes more OSes/architectures:
>=20
> http://patchew.org/QEMU/20170423223216.17856-1-aurelien@aurel32.net/
>=20
> If qemu master can be build on NetBDS, I can create a VM for this on my=
 x86_64
> machine, or you can generously contribute one, which is even better. :)=

>=20
> Fam
>=20

That's great - we will be back to you when the build issues will be
sorted out.


--JLnbx50JrxV7e4FDTHiTN79orN6N2Xg7D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY/a9YAAoJEEuzCOmwLnZs4jsP/1nnRfTXzJzMCVYqAh5+H/lx
M9/jOYF6WiiTnFhWO00tUIe2hx87Bg2g2LNqmiCXbONywMvCPama88h4ksYm0CaS
dtTrRlgquwDbSoDsbxusOdGEzzjAeyfLdeZbWyMKQHyCpNO2HctRwaBtgfT+U0KF
qiV9iOceLM1FeyOxg/OjDIxwYdtd4/nngCINhbJeiRAfhjY7pMbxShp/be6JANzr
780Xa+czKStZ5gfN/jS23opb7fYa3c3Syq2ooJy2p5hD8DEuZ9nFdg2vMdFx0lQ7
sTIZSmrGCKvVKj+p9Ywob+MMkrovtxAZlMLZerALa/hyZ9jc7ojKLVElcLPMglMR
E++B9NhwHriJDXcocBiWmNKPrUr8kwMIgID5FbKXx/FV5zTCz64xlQ/e+fCboJNI
BFClE8gmrWGtrGa9JuxgJFZhHhF2WEjNhkXoIfksMTozNxW7W1Afzqe76wZ9Umbu
MOwXwc79ead/iebq2GYKS7Y+lVhUwwyC2qrfo/FkOWktPwwLfOG+3o4m7C5qtNOr
dPBdvOCqhjkuqJn0Lb95kuISl6gThFOgEDjFV8vnFaceFKWIUZ+Ei07436zGBvEW
c/VjGw4Tkw3mNyVbhjjSAMSObAPlpt0nDAlvWy2Gwooi5Z5FinbvEPwj6lRUiahd
N7CJRq+r+7KanTo1V2FI
=z4ak
-----END PGP SIGNATURE-----

--JLnbx50JrxV7e4FDTHiTN79orN6N2Xg7D--
