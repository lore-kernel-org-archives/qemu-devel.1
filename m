Received: from eggs.gnu.org ([2001:4830:134:3::10]:53140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d89Ue-00086P-E0
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d89Ua-0000hn-FV
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:04:16 -0400
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
	<046303d38caf2e9919588f87850ac884a48dd567.1494140528.git.mjt@msgid.tls.msk.ru>
From: Eric Blake <eblake@redhat.com>
Message-ID: <77d50415-65eb-a11f-c946-bf14e8f56a0c@redhat.com>
Date: Tue, 9 May 2017 13:04:03 -0500
MIME-Version: 1.0
In-Reply-To: <046303d38caf2e9919588f87850ac884a48dd567.1494140528.git.mjt@msgid.tls.msk.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PPpqMbcRReN7m2IpaSVOOAc6xbt40umv6"
Subject: Re: [Qemu-devel] [PULL 11/23] channel-file: fix wrong parameter
 comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, "sochin.jiang fix wrong parameter comments in channel-file.h" <sochin@aliyun.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PPpqMbcRReN7m2IpaSVOOAc6xbt40umv6
From: Eric Blake <eblake@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
 "sochin.jiang fix wrong parameter comments in channel-file.h"
 <sochin@aliyun.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <77d50415-65eb-a11f-c946-bf14e8f56a0c@redhat.com>
Subject: Re: [Qemu-devel] [PULL 11/23] channel-file: fix wrong parameter
 comments
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
 <046303d38caf2e9919588f87850ac884a48dd567.1494140528.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <046303d38caf2e9919588f87850ac884a48dd567.1494140528.git.mjt@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/07/2017 02:02 AM, Michael Tokarev wrote:
> From: "sochin.jiang fix wrong parameter comments in channel-file.h" <so=
chin@aliyun.com>

Do we really want this HUGE email name, or can we get it touched up
before stefanha promotes his staging branch to master?

>=20
> Signed-off-by: sochin.jiang <sochin@aliyun.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  include/io/channel-file.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PPpqMbcRReN7m2IpaSVOOAc6xbt40umv6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEgSTAAoJEKeha0olJ0NqewUH/2P6LPeGN2akOgaYrIKHPfNw
fCDditqgjDRv/lvr8WRofhjcacXGSa1p2V8fCLT8PdIgIxmtBB+ka9zaiV9habUO
5K5iT2S9ttfdwCwPtzc9rri6H2lJD5iSzsY50tlTjvIT3zshb2pTDBv0S/GB4Jyy
Ocz6unsa6yN4t77XafKqEwawbB6i2r5o1P7Li7UYjMihiyvkepO+RNKtuaS8wZHg
lIBS0ZF/hzVOgyD0yOtvDSxFysHH8fQMKS9J/tBPcq+eFsK9VlKuKVVSeizAt7H5
Fcs9DnppsCTyU9+3hop2mIXw6mkXmTYFVLxx0wGu6h6vxT8vuhFbu+kV2AwPhVw=
=2qmk
-----END PGP SIGNATURE-----

--PPpqMbcRReN7m2IpaSVOOAc6xbt40umv6--
