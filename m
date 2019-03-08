Received: from eggs.gnu.org ([209.51.188.92]:55307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h2Mww-0000ca-B3
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 16:22:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h2Mwv-0002OW-FK
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 16:22:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h2Mwv-0002NS-3r
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 16:22:37 -0500
References: <20190308202858.26636-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f51cb786-1949-6103-3bf1-8a255216c50d@redhat.com>
Date: Fri, 8 Mar 2019 15:22:29 -0600
MIME-Version: 1.0
In-Reply-To: <20190308202858.26636-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ObDMrZd46gjtdGxAQFMyPL2F2q7b2HCPR"
Subject: Re: [Qemu-devel] [PULL 00/17] Bitmaps patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ObDMrZd46gjtdGxAQFMyPL2F2q7b2HCPR
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Message-ID: <f51cb786-1949-6103-3bf1-8a255216c50d@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/17] Bitmaps patches
References: <20190308202858.26636-1-jsnow@redhat.com>
In-Reply-To: <20190308202858.26636-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/8/19 2:28 PM, John Snow wrote:
> The following changes since commit 234afe78281b10a798fb97c584e1b677844a=
aab8:
>=20
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2=
019-03-08' into staging (2019-03-08 16:31:34 +0000)
>=20
> are available in the Git repository at:
>=20
>   https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request
>=20
> for you to fetch changes up to fc91aa3d937e56d512c702d9b966fcea0e499f0e=
:
>=20
>   block/dirty-bitmaps: implement inconsistent bit (2019-03-08 14:07:29 =
-0500)
>=20
> ----------------------------------------------------------------
> Pull request

Replying to the cover letter in case Peter doesn't see the nested reply:
NACK, v2 coming up for minor checkpatch fixes

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ObDMrZd46gjtdGxAQFMyPL2F2q7b2HCPR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyC3RYACgkQp6FrSiUn
Q2qT5wf+MFSFXowSQ5QMJUCK3HpgKpTyigwhLcANwLyDPl8mAUUq9cq4UFmMKOAe
aa5ssZZmY4Otd6kOBg9p/x8+oVmQdwfYcik/kBtIiyzDj8ieCGz8JpORbdWAZl11
ZqUB9wYMxKgKdRfAms2OWzYRj2JPc7l864nzE3uypDfUHB6PxMb33IXOVv++WOcR
/AXa8E9HiisU688fdcm6ILlo4qKu/qbF89eLeg+46PbcRZThSh15I3d9PIyyAqke
RYF41Dl+LN2+fq2uUhxbMFFjLGbWwZZzJQOOXn+TFL3XsnsIKT3HpzAyAKhBDcZT
O4/JwBGDPNSD3ksFp6Qj1WFqwkYQxA==
=yNz/
-----END PGP SIGNATURE-----

--ObDMrZd46gjtdGxAQFMyPL2F2q7b2HCPR--
