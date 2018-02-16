Received: from eggs.gnu.org ([2001:4830:134:3::10]:37116)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1emjWz-0007S0-FD
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:10:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1emjWv-0004Re-3P
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:10:41 -0500
Received: from mout.gmx.net ([212.227.15.19]:50137)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1emjWu-0004Pk-Fx
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:10:36 -0500
References: <20180216164620.GA53727@humpty.home.comstyle.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <cf32ffb4-80f1-4995-fed2-6c1a7c708cfb@gmx.com>
Date: Fri, 16 Feb 2018 18:12:48 +0100
MIME-Version: 1.0
In-Reply-To: <20180216164620.GA53727@humpty.home.comstyle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dJH9noPGVE4DrHtf0LpsgGoswjQp9pGau"
Subject: Re: [Qemu-devel] [PATCH] maintainers: Add myself as a OpenBSD
 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dJH9noPGVE4DrHtf0LpsgGoswjQp9pGau
From: Kamil Rytarowski <n54@gmx.com>
To: Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Message-ID: <cf32ffb4-80f1-4995-fed2-6c1a7c708cfb@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] maintainers: Add myself as a OpenBSD
 maintainer
References: <20180216164620.GA53727@humpty.home.comstyle.com>
In-Reply-To: <20180216164620.GA53727@humpty.home.comstyle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.02.2018 17:46, Brad Smith wrote:
> Add myself as an OpenBSD maintainer and add OpenBSD as maintained.
>=20
> Signed-off-by: Brad Smith <brad@comstyle.com>
>=20

Reviewed-by: Kamil Rytarowski <n54@gmx.com>

Would you like to co-maintain with myself a merge-branch for BSD? Right
now I send patches through other developers and it does not always work
smoothly.

>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 57358a08e2..86329e274f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -386,6 +386,12 @@ M: Kamil Rytarowski <kamil@netbsd.org>
>  S: Maintained
>  K: ^Subject:.*(?i)NetBSD
> =20
> +OPENBSD
> +L: qemu-devel@nongnu.org
> +M: Brad Smith <brad@comstyle.com>
> +S: Maintained
> +K: ^Subject:.*(?i)OpenBSD
> +
>  W32, W64
>  L: qemu-devel@nongnu.org
>  M: Stefan Weil <sw@weilnetz.de>
> diff --git a/configure b/configure
> index 913e14839d..850c46ebac 100755
> --- a/configure
> +++ b/configure
> @@ -760,6 +760,7 @@ OpenBSD)
>    audio_drv_list=3D"sdl"
>    audio_possible_drivers=3D"sdl"
>    HOST_VARIANT_DIR=3D"openbsd"
> +  supported_os=3D"yes"
>  ;;
>  Darwin)
>    bsd=3D"yes"
>=20



--dJH9noPGVE4DrHtf0LpsgGoswjQp9pGau
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlqHERAMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZs/PIQALopz4IQ0e8KiDPZ0UlBxY80AirjxYvhKNKEDYbM
w8PHIEfSLOFApqlA/oMNuna470hhdR8I3XN52I7f+wWIpQUUNtG8OAZZwQGxtv4F
FyaMyH/UNhEwYi+zh2/C9BmGWsvYRhzEX7jXvodQY5CHbc8GCskg+j2o4aC00C4G
Wma2Cxq8bTuCotLAudqPIv03+IEgRlh7v9wNToYaIfXUVQx9pl4lcYt8QBXvLbA2
vhRks6UJzuRtXCZbDLp91SUWHaLbFA2VVC3TuJvmJN32g4MYZLfT4AM3HzgK4A/w
oYSmlVCiCAzRXQtR3yzh9zRsnUqJY/gAq3rdHosSNuoRR9Hh3nbBkywADXFVmN5Q
H2XPW643w9zb14nTgBIdE4ThQVslUBoiCuulkVhTQM9kEm6MXnXjxLwlLo+1pKYp
g5T9aqLhbvp1RSVI+g6ij9DYwydZwZaTzznf9pwHDid47T6atrFeUJeF7P2SYo3/
P6puHXbqIF4SuMvACWfHX1d8UTWEoF69N/GVzEDuS1NJMlUAq6HqXaG5uXHqSAFK
U9zC3oFvodZ285dasDmqNvZwTnoIYPo0nf6Sq57g9mtqMLEgpFCVb+xEx4uPfmTf
ZxgrJbJwzQKGUetnszIZ60FXDrJAb2A5wjW/wzLqi4OhtP4hY++GRbIW02F2G1EU
0+X5
=uKg5
-----END PGP SIGNATURE-----

--dJH9noPGVE4DrHtf0LpsgGoswjQp9pGau--
