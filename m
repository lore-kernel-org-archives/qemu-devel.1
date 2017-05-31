Received: from eggs.gnu.org ([2001:4830:134:3::10]:38751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG6BY-0005Ih-0g
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG6BX-0005bu-6W
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:09:23 -0400
References: <20170509173342.29286-1-berrange@redhat.com>
	<20170509173342.29286-5-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <aa47be64-2387-3d32-7b1b-118d4c25646b@redhat.com>
Date: Wed, 31 May 2017 18:09:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170509173342.29286-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oXUJHGlQwwOgCHKlfnPA5VDraRHLqaWvv"
Subject: Re: [Qemu-devel] [PATCH v5 4/5] iotests: add more LUKS hash
 combination tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oXUJHGlQwwOgCHKlfnPA5VDraRHLqaWvv
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <aa47be64-2387-3d32-7b1b-118d4c25646b@redhat.com>
Subject: Re: [PATCH v5 4/5] iotests: add more LUKS hash combination tests
References: <20170509173342.29286-1-berrange@redhat.com>
 <20170509173342.29286-5-berrange@redhat.com>
In-Reply-To: <20170509173342.29286-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-09 19:33, Daniel P. Berrange wrote:
> Add tests for sha224, sha512, sha384 and ripemd160 hash
> algorithms.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/qemu-iotests/149     |  10 +-
>  tests/qemu-iotests/149.out | 482 +++++++++++++++++++++++++++++++++++++=
+++++++-
>  2 files changed, 484 insertions(+), 8 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--oXUJHGlQwwOgCHKlfnPA5VDraRHLqaWvv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLuqqEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQAp0
B/9PyEaTvWICHNlwFCmiakyYGJfbEZnt1uvRGVPxDZaK21JrU3Ihq3YP4YDm1uCU
BcmBmpp5tauWNIQAkDJ21h06FUj0J0pRBizWEWGjvBVAx0ll6rZRh4omDAGbJWgr
IRILiqpVBb9oEmEx4HUPsQ8sOxjZ8ccWg201jQkWzX8YejOyMyM7cyZfOKd/Mwmp
X6egdUJIiIMRtlwlcudURlzIDDDpApH/9Pp2Kpj1T6bHlbGVv1sd3ld6bjOX/Hse
L/Wp10W8Ue1nuLMin5eR6LfOm4v55bLGhp4/rJWkBZg6I5ZMiZbs0Ry4hjAZxz/3
ALU9gavt3p1d5vTcUg7WodkZ
=xJbm
-----END PGP SIGNATURE-----

--oXUJHGlQwwOgCHKlfnPA5VDraRHLqaWvv--
