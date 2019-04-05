Received: from eggs.gnu.org ([209.51.188.92]:52295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCMpf-00033D-Pe
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCMpe-0003Y7-Sa
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:16:27 -0400
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::10]:8830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1hCMpd-0002zH-J7
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:16:26 -0400
Date: Fri, 5 Apr 2019 13:16:16 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20190405131616.071a6390.olaf@aepfle.de>
In-Reply-To: <20190405125918.462c6ae4.olaf@aepfle.de>
References: <20190405123928.70da87e2.olaf@aepfle.de>
	<1cec1873-9962-f258-a052-167efec620e9@redhat.com>
	<20190405125918.462c6ae4.olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_//HIIvx4XHusNlIL9qTMU16i";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] edk2 fails to compile in v4.0.0-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, "Michael S.
	Tsirkin" <mst@redhat.com>

--Sig_//HIIvx4XHusNlIL9qTMU16i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Fri, 5 Apr 2019 12:59:18 +0200
schrieb Olaf Hering <olaf@aepfle.de>:

> This used to work still in January with c9d18c1c150c84e7a976df989ad04ddf0=
1083f46.

It is not possible to just override EFIROM=3D$(type -P EfiRom) because this=
 variable is also used by ipxe.git.

Olaf

--Sig_//HIIvx4XHusNlIL9qTMU16i
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXKc5AAAKCRBdQqD6ppg2
ftktAJ9zGqkhztmcHlXyz4W069+m22o9GQCg2h5J+QdpJX+j1Y9YTfdceAg1Oi8=
=EMC/
-----END PGP SIGNATURE-----

--Sig_//HIIvx4XHusNlIL9qTMU16i--
