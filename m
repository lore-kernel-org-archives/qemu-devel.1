Received: from eggs.gnu.org ([2001:4830:134:3::10]:49690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnxpz-0000cc-6Y
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnxpu-0004Jv-Lu
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:34:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnxpu-0004JM-GP
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:34:46 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-45-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <efa08864-0ad5-78d7-988f-38d89aac4631@redhat.com>
Date: Tue, 14 Mar 2017 20:34:44 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-45-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UvcLQ4530Io9MmOJKgqJdS0s70L73ENUo"
Subject: Re: [Qemu-devel] [PATCH for-2.9 44/47] qapi: union_types is a list
 used like a dict, make it one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UvcLQ4530Io9MmOJKgqJdS0s70L73ENUo
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <efa08864-0ad5-78d7-988f-38d89aac4631@redhat.com>
Subject: Re: [PATCH for-2.9 44/47] qapi: union_types is a list used like a
 dict, make it one
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-45-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-45-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi.py | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--UvcLQ4530Io9MmOJKgqJdS0s70L73ENUo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyJo0AAoJEKeha0olJ0NqluoH/0ONwd/lTNtjWWTLPg/iHqPU
9FlDdRu3DudxsUIs/Tym3s6d0d4hJ33jxoy63hAADGh1U1DlAj/3n5v4fEtCldPJ
8K4USgJi31H90uZlYr88jlwTZ8JAuTVd91W3+A/SJhSPkciFXSiOAe1yJeXsXaVH
FXORJRs8nIFT15j/i0tFqFU1bBRgggWnQWe8D/dCPaAhgUoINmoocRv8Oh8s0I1h
lstefFviED/np7RefxbEATv1K+RACcyMsTgBr3LutBwUZmioG4rWaQw8C2SS/P5W
ZN8Rg/Nn7KmpvgKVTlVcvPK/VgK8/NIrXlTpIgHMFnPEDvdhhharey/8tt+Oby4=
=TcJ2
-----END PGP SIGNATURE-----

--UvcLQ4530Io9MmOJKgqJdS0s70L73ENUo--
