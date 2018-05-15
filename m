Received: from eggs.gnu.org ([2001:4830:134:3::10]:40297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fITRm-0007o2-4K
	for qemu-devel@nongnu.org; Tue, 15 May 2018 02:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fITRl-0000gZ-8o
	for qemu-devel@nongnu.org; Tue, 15 May 2018 02:28:30 -0400
Date: Tue, 15 May 2018 08:28:17 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20180515082817.1125f292.olaf@aepfle.de>
In-Reply-To: <152636426980.156.13889592265459743277@1f70390a8372>
References: <20180515055949.6446-1-olaf@aepfle.de>
	<152636426980.156.13889592265459743277@1f70390a8372>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/xxdQ6aQc2Cv6ScX=WE_563q";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] replace functions which are only available
 in glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: no-reply@patchew.org
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-trivial@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com

--Sig_/xxdQ6aQc2Cv6ScX=WE_563q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Mon, 14 May 2018 23:04:31 -0700 (PDT)
schrieb no-reply@patchew.org:

> vfio-helpers.c:525:17: error: assignment from incompatible pointer type=20

Does anyone happen to know what s390x is trying to do here?

Olaf

--Sig_/xxdQ6aQc2Cv6ScX=WE_563q
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCWvp+AQAKCRBdQqD6ppg2
fnZwAKDS8nHzFVDmrHPzsgVS+BUZHNxCpQCeKj3m6zo6rd+r5tp4V2hyc4l8zbc=
=JKN3
-----END PGP SIGNATURE-----

--Sig_/xxdQ6aQc2Cv6ScX=WE_563q--
