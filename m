Received: from eggs.gnu.org ([2001:4830:134:3::10]:38073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dLBGO-0007TL-VB
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 12:35:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dLBGO-0001F8-8s
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 12:35:24 -0400
References: <20170613140358.81651-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <53205127-6e9b-09aa-c753-f560aa58747b@redhat.com>
Date: Wed, 14 Jun 2017 18:35:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170613140358.81651-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s0Px2FLuetB5kdREgfXEHNIJDeQBcskr9"
Subject: Re: [Qemu-devel] [PATCH v21 00/30] qcow2: persistent dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s0Px2FLuetB5kdREgfXEHNIJDeQBcskr9
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <53205127-6e9b-09aa-c753-f560aa58747b@redhat.com>
Subject: Re: [PATCH v21 00/30] qcow2: persistent dirty bitmaps
References: <20170613140358.81651-1-vsementsov@virtuozzo.com>
In-Reply-To: <20170613140358.81651-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-13 16:03, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
>=20
> There is a new update of qcow2-bitmap series - v21.
>=20
> web: https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=3Dqco=
w2-bitmap-v21
> git: https://src.openvz.org/scm/~vsementsov/qemu.git (tag qcow2-bitmap-=
v21)

No objections left on my part. :-)

I'll give John and Kevin some time to react before merging this, though.

Max


--s0Px2FLuetB5kdREgfXEHNIJDeQBcskr9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZQWW6EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQG/v
B/0cKje7E8/YziuEB4EhtgrC0bPKa/sfmME+2l2UcQvbBTVFNKHURQtrTPfqSy03
ijB+5YVTZsch3GG8yHAMsrA1W9c17XsLVSXA5sCrTbGOCnzP61tVEHUgBa0iE60x
RNttHrIfKAkEPaS0y3MrchbbBS/J15c/dZRSIK/IR5loDf5oCXkaEWgjsKwmuDwY
BKUCSyel/mUAWhT9TYMrBplGjqhWw3DxrTBNnIkMEoqLfQYSIFLSp+IkAkCvpsqF
SDwszlfRFoGM1uh933+v66JDYylVQcFCfxUSIH/2dqYyBXHxfrbYiEIs4RRGcGJC
SKBOv2hN592CLifoFZvfm0lN
=snEh
-----END PGP SIGNATURE-----

--s0Px2FLuetB5kdREgfXEHNIJDeQBcskr9--
