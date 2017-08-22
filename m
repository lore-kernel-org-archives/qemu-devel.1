Received: from eggs.gnu.org ([2001:4830:134:3::10]:43283)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dkAFT-00085k-QO
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dkAFO-0003u0-Tk
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:33:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:55981)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dkAFO-0003ti-HD
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:33:38 -0400
References: <20170822044155.2451-1-famz@redhat.com>
	<40d04f21-011e-1736-ed62-1d205926d60a@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <7a823db0-4fb1-8a47-bd8b-c0a4cc77fa9e@gmx.com>
Date: Tue, 22 Aug 2017 16:23:29 +0200
MIME-Version: 1.0
In-Reply-To: <40d04f21-011e-1736-ed62-1d205926d60a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aQLI9NbSBnkk4BXAvnjbvvg7knJjSh0mh"
Subject: Re: [Qemu-devel] [PATCH v3 00/10] tests: Add VM based build tests
 (for non-x86_64 and/or non-Linux)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aQLI9NbSBnkk4BXAvnjbvvg7knJjSh0mh
From: Kamil Rytarowski <n54@gmx.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com
Message-ID: <7a823db0-4fb1-8a47-bd8b-c0a4cc77fa9e@gmx.com>
Subject: Re: [PATCH v3 00/10] tests: Add VM based build tests (for non-x86_64
 and/or non-Linux)
References: <20170822044155.2451-1-famz@redhat.com>
 <40d04f21-011e-1736-ed62-1d205926d60a@redhat.com>
In-Reply-To: <40d04f21-011e-1736-ed62-1d205926d60a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22.08.2017 15:58, Paolo Bonzini wrote:
> On 22/08/2017 06:41, Fam Zheng wrote:
>> as it is not easy to automate. (The ideal approach is like the ubuntu.=
i386
>> script, which configures the guest on top of an official released imag=
e, fully
>> automatically.)
>=20
> Out of curiosity, why can't the 32-bit test use containers instead?
>=20
> Paolo
>=20

At least this is more friendly to !Linux users.


--aQLI9NbSBnkk4BXAvnjbvvg7knJjSh0mh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZnD5oAAoJEEuzCOmwLnZs8EIP/jWz/mQBHcpiLyypFTFUPasM
JjcE2UHeDGJHzgca7eQWKkfdCBHZ9AoA/Hw/Z53hDCDSpPSnja+WErQUOL9w6+at
oMHMGTNKPUtFerGqFcHYLTsbfmwXFwI8YXuXVavJAXeQpsze62qnirtk1HpKsWCY
c0mKVFXI8zrULbvnzFD9NrhJd4R1KrnZZAxoquad2GN37cQ6ZlagLK/X7pbWHMkw
Ib87LYV/JBQvwBfL1fo+vVwhpHl3WmQppAp6JfrOdKJYJsHPiTdQuvC2+ML7RDGJ
JgoradQM2V8RUgHxCEx6BXm+MxvESKEUQyRLnhbo41Ep/nUiMa0Z3ZgYC6Z7r7yb
vWpjcVLto4xWqi/sH6s2qhptDRMtssJoa+pwafoUfeky2uqQ7lFTCuwucqWaW1Pp
vmO3jUI4HMfVncqHTKJ0Ko7glSEkFrnkbaTkY+AW1fRFlTSDBMemvXzaT7HVG4Ce
bkj48cJag5v3OvCY3bKUuumPBevuUz5bbVjHhZhhsjMfH2QKuWHvN8goB+kR6AN5
KTfkqO11RORLK06PhpwcRKiOuCVCdO2qxM276WRhuMaPi6DpgztOzJuaovoQyPJ0
vXzltITt9JhkuL/BaxJW6hultxOvXYCTUVxGlDcIlF2Bp1v9LjBYTDorXoIg1ltW
bv9B8SGc0/3SRhw70plL
=/BQY
-----END PGP SIGNATURE-----

--aQLI9NbSBnkk4BXAvnjbvvg7knJjSh0mh--
