Received: from eggs.gnu.org ([2001:4830:134:3::10]:51669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUDjQ-0001VC-OM
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:30:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUDjM-0008BN-FR
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:30:25 -0500
References: <20170119130759.28319-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8aca0172-cb4e-253e-634a-bdaf840f0642@redhat.com>
Date: Thu, 19 Jan 2017 08:30:14 -0600
MIME-Version: 1.0
In-Reply-To: <20170119130759.28319-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QJaWJjwoPSgIUNQdT3043OEL8Xc86fJP4"
Subject: Re: [Qemu-devel] [PATCH 0/2] block: Fix iotests 059
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QJaWJjwoPSgIUNQdT3043OEL8Xc86fJP4
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <8aca0172-cb4e-253e-634a-bdaf840f0642@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] block: Fix iotests 059
References: <20170119130759.28319-1-famz@redhat.com>
In-Reply-To: <20170119130759.28319-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2017 07:07 AM, Fam Zheng wrote:
> The 059.out went out of sync, bring it back in line.
>=20
> Fam Zheng (2):
>   qapi: Tweak error message of bdrv_query_image_info
>   iotests: Fix reference output for 059
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

>  block/qapi.c               | 4 ++--
>  tests/qemu-iotests/059.out | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--QJaWJjwoPSgIUNQdT3043OEL8Xc86fJP4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYgM12AAoJEKeha0olJ0NqvPUH/3lpde1WWDmwJvGLqwappLo8
/OLH9aC8GuyrWMom8iYI/e+Zc5s207Y5mE9QGYFRGLxd1ksnyUTMh8uMbZCputs2
Y6xGi4yOUPvdPK5HnAgWtP/+4r6lajNdslTj2BgIzWmKoABlb/Eg1zett9DPKx/S
PTxzdR0GI2+Dxb/14bMBVBGVAF/RjZd2WaamDupoZwBJIH581rHl4Z7iiu3ZldO0
CiIH/xgzVNv3wpcJ5NUC0j35s5iLqDn0kVz1pncAsp9PFjdnEiTVn7tjx0fauJhq
zNHcIOJKYF5k9z5AaL+f5fiHJ8k02Dcv5hgT/v4ongQW0/DapNVkRV0COgtfu4c=
=zrHa
-----END PGP SIGNATURE-----

--QJaWJjwoPSgIUNQdT3043OEL8Xc86fJP4--
