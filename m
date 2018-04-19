Received: from eggs.gnu.org ([2001:4830:134:3::10]:60945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1f941e-0004iA-5z
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 03:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1f941d-0007hB-Cs
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 03:30:38 -0400
Date: Thu, 19 Apr 2018 09:30:24 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20180419093024.27c77433.olaf@aepfle.de>
In-Reply-To: <87sh7rvf27.fsf@dusky.pond.sub.org>
References: <20180418123838.3511-1-olaf@aepfle.de>
	<20180418144538.4aa2f492.cohuck@redhat.com>
	<20180418125545.GN27579@redhat.com>
	<87sh7rvf27.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/2Z+D0DuBWfubgNZlmcQTGyb";
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
To: Markus Armbruster <armbru@redhat.com>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org, Philippe =?UTF-8?B?TWF0?= =?UTF-8?B?aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, "open list:All patches CC
	here" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

--Sig_/2Z+D0DuBWfubgNZlmcQTGyb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Thu, 19 Apr 2018 09:19:28 +0200
schrieb Markus Armbruster <armbru@redhat.com>:

> > [1]   https://libvirt.org/platforms.html =20
> This policy looks sensible to me

Unless I misinterpret that, noone cares about SLE11 anymore.
So, just wipe that single one developer system with glib-2.22 and move on.

Olaf

--Sig_/2Z+D0DuBWfubgNZlmcQTGyb
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCWthFkAAKCRBdQqD6ppg2
fsQsAKC52LDE4Rmca0SaU4bxxQlPcZYr/ACeN4xsFVQY99sG6zhvViPIqxj6LLE=
=u8yC
-----END PGP SIGNATURE-----

--Sig_/2Z+D0DuBWfubgNZlmcQTGyb--
