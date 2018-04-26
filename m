Received: from eggs.gnu.org ([2001:4830:134:3::10]:58672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fBfhG-00035p-Na
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:08:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fBfhF-0007ZU-UR
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:08:22 -0400
Date: Thu, 26 Apr 2018 14:08:07 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20180426140807.4a4a577b.olaf@aepfle.de>
In-Reply-To: <c9b7c417-e714-658b-20da-7150c9ec8ab9@redhat.com>
References: <20180418123838.3511-1-olaf@aepfle.de>
	<20180418124753.GM27579@redhat.com>
	<CAFEAcA_TtC-p4JJFRPaBFwim1a8J9G+z79KAK8vqrTx7ZKjOKg@mail.gmail.com>
	<20180418144433.GV27579@redhat.com>
	<CAFEAcA8jXwo35B7KVdVZEiqZTtMRvVXCP87iHKECjWPkHiTJ_A@mail.gmail.com>
	<c9b7c417-e714-658b-20da-7150c9ec8ab9@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/b.SFpbX6pshrYvbZdBJ1/=S";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v1] configure: require glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. =?UTF-8?B?QmVy?=
	=?UTF-8?B?cmFuZ8Op?=" <berrange@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Fam Zheng <famz@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, "open list:All patches
	CC here" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

--Sig_/b.SFpbX6pshrYvbZdBJ1/=S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Thu, 26 Apr 2018 13:52:04 +0200
schrieb Paolo Bonzini <pbonzini@redhat.com>:

> min-glib Dockerfile is using glib 2.22

Why did it not prevent the bad commit from entering 2.12?

Olaf

--Sig_/b.SFpbX6pshrYvbZdBJ1/=S
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCWuHBJwAKCRBdQqD6ppg2
fvxeAKD7H/DPyFKkGZSRsnMEyFOt4GsmmACg+wX8z8Dq6EPgXljo1lkD3EkgYVY=
=EwyO
-----END PGP SIGNATURE-----

--Sig_/b.SFpbX6pshrYvbZdBJ1/=S--
