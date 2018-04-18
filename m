Received: from eggs.gnu.org ([2001:4830:134:3::10]:59099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1f8mhq-0001u7-If
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1f8mhl-0003Ta-5l
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:01:02 -0400
Date: Wed, 18 Apr 2018 15:00:40 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20180418150029.30c5d1bb.olaf@aepfle.de>
In-Reply-To: <20180418124753.GM27579@redhat.com>
References: <20180418123838.3511-1-olaf@aepfle.de>
	<20180418124753.GM27579@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/DN7LZlIsuduvQZTnacYL_7M";
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
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

--Sig_/DN7LZlIsuduvQZTnacYL_7M
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Wed, 18 Apr 2018 13:47:53 +0100
schrieb Daniel P. Berrang=C3=A9 <berrange@redhat.com>:

> IIRC, one of Peters desired build targets required 2.22, but I guess we
> missed this bug because that platform would not enable vfio functionality=
 ?

Does the check in configure need a wrap "if Linux", just as the Makefile do=
es?

Olaf

--Sig_/DN7LZlIsuduvQZTnacYL_7M
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCWtdBeAAKCRBdQqD6ppg2
focNAJ4+3ZKIBxbc+HcMpF2RNI2LO9uyfQCdG2wu3phutai9uuGECZrd/WnNyo0=
=I1vq
-----END PGP SIGNATURE-----

--Sig_/DN7LZlIsuduvQZTnacYL_7M--
