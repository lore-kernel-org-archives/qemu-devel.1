Received: from eggs.gnu.org ([209.51.188.92]:56605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCNCc-0000x4-IY
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:40:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCN47-0005sB-8n
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:31:25 -0400
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::11]:23162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1hCN45-0005YF-J4
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:31:23 -0400
Date: Fri, 5 Apr 2019 13:31:14 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20190405133114.485ca24e.olaf@aepfle.de>
In-Reply-To: <b1c37e96-4679-b342-bf26-7043cc754220@redhat.com>
References: <20190405123928.70da87e2.olaf@aepfle.de>
	<1cec1873-9962-f258-a052-167efec620e9@redhat.com>
	<20190405125918.462c6ae4.olaf@aepfle.de>
	<20190405131616.071a6390.olaf@aepfle.de>
	<b1c37e96-4679-b342-bf26-7043cc754220@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/BZMUf3vx_2P/1aun_wF1/QI";
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

--Sig_/BZMUf3vx_2P/1aun_wF1/QI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Fri, 5 Apr 2019 13:29:44 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:

> I'll submit that patch.

Can this actually work? It does not remove the naming conflict.

Olaf

--Sig_/BZMUf3vx_2P/1aun_wF1/QI
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXKc8ggAKCRBdQqD6ppg2
fhouAKCRJ8C+XNoA5yb8mfDilhDtOqRI9ACeMU9AZNCrUzoPq3Aazgi4C7d/+qI=
=yoFY
-----END PGP SIGNATURE-----

--Sig_/BZMUf3vx_2P/1aun_wF1/QI--
