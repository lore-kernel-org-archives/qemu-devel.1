Received: from eggs.gnu.org ([2001:4830:134:3::10]:50121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbAv9-0008N3-OL
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbAv8-00032Y-TP
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:27:35 -0400
References: <20170728131452.15316-1-kwolf@redhat.com>
	<20170728131452.15316-3-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <04f81df8-a156-d87e-d7f3-d349622a00f0@redhat.com>
Date: Fri, 28 Jul 2017 14:27:27 -0500
MIME-Version: 1.0
In-Reply-To: <20170728131452.15316-3-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GvSbcVALpQ2IMj43jQ8ter3RE5VVPdoJO"
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/7] qemu-iotests: Remove
 blkdebug.conf after tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GvSbcVALpQ2IMj43jQ8ter3RE5VVPdoJO
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <04f81df8-a156-d87e-d7f3-d349622a00f0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/7] qemu-iotests: Remove
 blkdebug.conf after tests
References: <20170728131452.15316-1-kwolf@redhat.com>
 <20170728131452.15316-3-kwolf@redhat.com>
In-Reply-To: <20170728131452.15316-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 08:14 AM, Kevin Wolf wrote:
> qemu-iotests 074 and 179 left a blkdebug.conf behind the scratch

s/behind/behind in/

> directory. Make sure to clean up after completing the tests.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GvSbcVALpQ2IMj43jQ8ter3RE5VVPdoJO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7kB8ACgkQp6FrSiUn
Q2oJwwf+JShtYZAT1fITGPcKSwqyO4v26LGmg4fpJ+aO5liApCK+dwUu8WDyaBnr
p9jpc2jUaT33+nSz5Z+LNN76AmQnh3ZpNI76+soGYwlOhUsld146+WNIC5qlA+Ck
y8d1gu0E3uBPN22IogqMF+xC1m/Q2HfQV+GoEjBocK2o8iJqvoo02pb6QvhHb5HK
LVN+mq+F8BN/2lEEo20/dPFpFTlQ2mZ8Y0G3y8wFzaBaBi1LLxsKckZDF3UwSz8Q
5vRsyBn/5ny9vW3yNA0kOcPHJr4j2fztZqa3nP5+d/EZwnJ6majgGiLXe1z8/Pul
mnFiS/lONSlusVrJg2C4S+8FsyV9Gg==
=rcoj
-----END PGP SIGNATURE-----

--GvSbcVALpQ2IMj43jQ8ter3RE5VVPdoJO--
