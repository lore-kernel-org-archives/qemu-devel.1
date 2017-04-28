Received: from eggs.gnu.org ([2001:4830:134:3::10]:56212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d48zm-0000nm-Dl
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d48zj-0001AP-CO
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:43:50 -0400
References: <20170427205100.9505-1-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f14b3ea0-ab40-b3db-faf4-9b4882b12065@redhat.com>
Date: Fri, 28 Apr 2017 18:43:43 +0200
MIME-Version: 1.0
In-Reply-To: <20170427205100.9505-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ckSnlhUEKE3aNG1ctJBAC1CfTNmJCxtjr"
Subject: Re: [Qemu-devel] [PATCH 0/2] iotests: trivial fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, kwolf@redhat.com, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ckSnlhUEKE3aNG1ctJBAC1CfTNmJCxtjr
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, kwolf@redhat.com, eblake@redhat.com
Message-ID: <f14b3ea0-ab40-b3db-faf4-9b4882b12065@redhat.com>
Subject: Re: [PATCH 0/2] iotests: trivial fixups
References: <20170427205100.9505-1-jsnow@redhat.com>
In-Reply-To: <20170427205100.9505-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.04.2017 22:50, John Snow wrote:
> Excised from an old patchset from 2015, just a couple of touchups.
>=20
> John Snow (2):
>   iotests: clarify help text
>   iotests: fix exclusion option
>=20
>  tests/qemu-iotests/common | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Thanks, applied to my block tree:

https://github.com/XanClic/qemu/commits/block

Max


--ckSnlhUEKE3aNG1ctJBAC1CfTNmJCxtjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkDcT8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A6rwIAIOudfoVYcUIlVdbGcm/Jn3WmJ/x8nF5
YXNSxecyBmphxgpJqcjpPCThFoANQ3FX2vlReC1865sKze2pAkYZJhMeWulbSe8X
uy/H+E0ThfGaZJUeXZEfZLrnaQeXWVuynJA4VGcjqtxC35DxrSmaE4PQKKBT81y0
BzC4rAqfCDBk81uMuej3o4jZjWugwI3zEyOMZPNzkv5imk07L2XI5nmi7AZ+jybu
uiEShlRAhPkt12BQX8xmsxQjX9hvNLXeeVpunqeU7c9Kt2N6GMoVoC3+36o5a0Dz
wursMACtjAs87ZcfK6fCzFGIKDLknpK/9ZYeawv0AU+3pEKp8EJFGSg=
=Phur
-----END PGP SIGNATURE-----

--ckSnlhUEKE3aNG1ctJBAC1CfTNmJCxtjr--
