Received: from eggs.gnu.org ([209.51.188.92]:36121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hDQHN-0007pX-Ts
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hDQHN-0006Yn-27
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:09:25 -0400
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::6]:33412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1hDQHL-0006Vg-Le
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:09:24 -0400
Date: Mon, 8 Apr 2019 11:09:10 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20190408110911.46d3b9d0.olaf@aepfle.de>
In-Reply-To: <9a4ea235-29ce-2a98-a723-0a61be55433f@redhat.com>
References: <20190405123928.70da87e2.olaf@aepfle.de>
	<1cec1873-9962-f258-a052-167efec620e9@redhat.com>
	<20190405125918.462c6ae4.olaf@aepfle.de>
	<9a4ea235-29ce-2a98-a723-0a61be55433f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/WTSsj_EH+VdbA4pv_K6_Yh5";
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

--Sig_/WTSsj_EH+VdbA4pv_K6_Yh5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Mon, 8 Apr 2019 11:04:09 +0200
schrieb Laszlo Ersek <lersek@redhat.com>:

> This is not a QEMU build failure, but an issue in the downstream
> packaging that not only tries to build QEMU, but performs a maintainer
> build on binary artifacts.

I'm sure everyone will rebuild the things from source that can be rebuilt.
Who would ship random binary blobs from unknown origin?

Olaf

--Sig_/WTSsj_EH+VdbA4pv_K6_Yh5
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXKsPtwAKCRBdQqD6ppg2
fiTYAJ9OX04ljC0Fic+3uuNr9LuPN+WEXgCdH8RKe5cS8hmWCwUZmbsvLyMs4vg=
=nu3x
-----END PGP SIGNATURE-----

--Sig_/WTSsj_EH+VdbA4pv_K6_Yh5--
