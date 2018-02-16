Received: from eggs.gnu.org ([2001:4830:134:3::10]:47840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emk3k-0006VU-6O
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:44:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emk3f-0007Ld-AT
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:44:32 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:44994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emk3f-0007Kc-3y
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:44:27 -0500
Received: by mail-qt0-x241.google.com with SMTP id f18so4713482qth.11
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 09:44:26 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180216164620.GA53727@humpty.home.comstyle.com>
	<c4407146-8ec6-c317-9ec8-a47ab909fb94@amsat.org>
	<85dc7f9f-95e1-c666-ee17-8f04d008d21b@gmx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e625c026-2fa4-f3ea-d85e-080c65a4885f@amsat.org>
Date: Fri, 16 Feb 2018 14:44:05 -0300
MIME-Version: 1.0
In-Reply-To: <85dc7f9f-95e1-c666-ee17-8f04d008d21b@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="7eeA3SbuKkwLQ4Vb4VRTlXsVZYJIEITin"
Subject: Re: [Qemu-devel] [PATCH] maintainers: Add myself as a OpenBSD
 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7eeA3SbuKkwLQ4Vb4VRTlXsVZYJIEITin
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Kamil Rytarowski <n54@gmx.com>, Brad Smith <brad@comstyle.com>,
 qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>
Message-ID: <e625c026-2fa4-f3ea-d85e-080c65a4885f@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] maintainers: Add myself as a OpenBSD
 maintainer
References: <20180216164620.GA53727@humpty.home.comstyle.com>
 <c4407146-8ec6-c317-9ec8-a47ab909fb94@amsat.org>
 <85dc7f9f-95e1-c666-ee17-8f04d008d21b@gmx.com>
In-Reply-To: <85dc7f9f-95e1-c666-ee17-8f04d008d21b@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/16/2018 02:41 PM, Kamil Rytarowski wrote:
> On 16.02.2018 18:30, Philippe Mathieu-Daud=C3=A9 wrote:
>> But before announcing the host OS being supported again, I'd rather se=
e
>> reproducible build/tests logs, in a (public - if possible) continuous
>> integration system. Else it is hard to notice when it get broken.
>>
>=20
> This is already done for FreeBSD, NetBSD and OpenBSD.

We have the ability to run those, but afaik no CI are using them.

$ make vm-test
vm-test: Test QEMU in preconfigured virtual machines

  vm-build-ubuntu.i386            - Build QEMU in ubuntu i386 VM
  vm-build-freebsd                - Build QEMU in FreeBSD VM
  vm-build-netbsd                 - Build QEMU in NetBSD VM
  vm-build-openbsd                - Build QEMU in OpenBSD VM

>=20
> CC: Fam who can confirm this.



--7eeA3SbuKkwLQ4Vb4VRTlXsVZYJIEITin
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlqHGGgACgkQ4+MsLN6t
wN4IdA//akuSHpFf9hHY4E1GAL6lsnl2aIqLKARGg8BnrSPXxH0dCpeT5q5mdzJM
fiGbjTqQinx49w9WBshDDIYCHww/cvf/3YfT+nlyUMv0vhuFH8345nf3imd7NSqN
o440AVeHdhnRI3J5sQllgDDCI/k855YIQcs0ZotEeKOav06Xm+V3J6A1+VRqW9AL
ssR+2ugEWvg2qSaewESMqJKMQCdpkUL3Bj76dtvG2i5hOCaz6zGreJKywV/5wJ11
9NKpJgagq+7nO2Pl0OoeEIVTjC1D4ofbuKdn7U3lUo+5TWTryhMjeAKeBRvS/fQE
SpAOrDfSKJJ9zj/yxBKSGlWWwKeTLO+FqtQcyO+o607ybpcCyWRFHP2TR4zoRleg
OcPWajLZgpfe4PQ6Xn9vtZ/4V03uNw7firi4gtNFSZco87dNsEkW+RyPkrRg3bDR
mqZgk4N1q9N8xipCzQCTjZVQXF73leHeCpUrdO04vMt+ZE97ICpGqQ3LhhChVx1b
CDT6aZ1evHa/QisC7CbjmrcjFCY5C/bfsYplLng4HqkHkbrwdfssIFOxgDy3WzKf
8Kb8Z1GbNo3m8T42vIYuXFpwskkz7PfGnsadoDw+YyLym0JY/95hSaCsT2tzocKv
A6eoHRmYPc5ogrpOkJ/oYRfB8A7Wp0/S6MhM6/DowCBC5a4LsuA=
=qB6+
-----END PGP SIGNATURE-----

--7eeA3SbuKkwLQ4Vb4VRTlXsVZYJIEITin--
