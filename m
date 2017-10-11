Received: from eggs.gnu.org ([2001:4830:134:3::10]:53510)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1e2IHh-0000Du-80
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 10:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1e2IHe-0002Kn-21
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 10:46:57 -0400
Received: from mout.gmx.net ([212.227.17.21]:56922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1e2IHd-0002KZ-Mq
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 10:46:53 -0400
References: <20171011083604.11820-1-kraxel@redhat.com>
	<CAFEAcA9uXw7XYOBu9cKY+B=OWNbS=cRp7BKcXacLTaRLx9RWdA@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <f5444f37-4931-d9e6-216e-2c0b78184a1e@gmx.com>
Date: Wed, 11 Oct 2017 16:49:14 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9uXw7XYOBu9cKY+B=OWNbS=cRp7BKcXacLTaRLx9RWdA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="V6AjVuMLlKROoeqDDi61ki9IpfpqBtcaf"
Subject: Re: [Qemu-devel] [PULL 00/10] Ui 20171011 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V6AjVuMLlKROoeqDDi61ki9IpfpqBtcaf
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <f5444f37-4931-d9e6-216e-2c0b78184a1e@gmx.com>
Subject: Re: [Qemu-devel] [PULL 00/10] Ui 20171011 patches
References: <20171011083604.11820-1-kraxel@redhat.com>
 <CAFEAcA9uXw7XYOBu9cKY+B=OWNbS=cRp7BKcXacLTaRLx9RWdA@mail.gmail.com>
In-Reply-To: <CAFEAcA9uXw7XYOBu9cKY+B=OWNbS=cRp7BKcXacLTaRLx9RWdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.10.2017 16:37, Peter Maydell wrote:
> The OpenBSD failure is because make now tries to run a
> script that uses #!/bin/bash, and this machine doesn't
> have bash installed. Do we really need to add bash to
> our build-dependencies? The script doesn't seem like it's
> doing anything that critically requires bash...

NetBSD installs bash by default to /usr/pkg/bin/bash, FreeBSD installs
it to /usr/local/bin/bash. If bash is really needed it should be used
with the "#!/usr/bin/env bash" shebang.


--V6AjVuMLlKROoeqDDi61ki9IpfpqBtcaf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZ3i9vAAoJEEuzCOmwLnZsosAQAJIGOcy9oJNwHNI0noibAgCB
SEdAW/W4jnaaUtTncL9iFT+a+DW48f3G6SzojoOxzvH9FiqfD87t+uxVqevoraVy
jqA1N+zd7thC7V4O7AQvA+8IusfB6VD0Lopk6lUDopQjy9T6m10lzpQfV/MaP+ky
rVO04r7wZSfQeaZ0LXRFfo8mMzWPJlVXUAnDzXB5wFzt4D3l9bRKWKoSJZm+LbMr
cVP7EG22L4qU1AZg6L9+Ysx1DoQuE14wRQ+u5ts+kCsUBKHDbUj5LHirIxgLEia1
K1MJZQfgr5Y2FwvWhkbiHP8IGn5FCsJnRBkXCzgsmjGYD/uduccjbLjPR+1g3HIa
5YCbhNGjcO45tb5+4PoFEMmdCawVxsW9ZnkubvpyhXwiuWQ6SyZtpwjA3ZVOQrRz
cvcUaxjn21oCIzIQm2oBn+Nw0JZ30fHDjjALOJ9xQoXjoD5OOKrBoxfV3qkukmPD
Zh84onsIdc3+woSZ8DCfcZ28Ob8cx3lKNuKibuEI0uOoaaHQxP7oG7Zxf8W0MS1j
VbaaWcKLWPrgEimpccFD2H3cO/10TDH9ZCx/PatujCD6vB8tAa0vTHFOvSCNKHPO
fxXHGvwZfA3jhJALBNHpTuA9cCxAwiOEkcnnsm43Quv5ParClsPR0tFlwM4iuhwh
mIvLX/5iKNs83dHSv28v
=sLkv
-----END PGP SIGNATURE-----

--V6AjVuMLlKROoeqDDi61ki9IpfpqBtcaf--
