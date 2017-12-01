Received: from eggs.gnu.org ([2001:4830:134:3::10]:42174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKrky-0001K4-3q
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 15:17:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKrkx-0006pG-7t
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 15:17:56 -0500
References: <20171116173810.16457-1-crosa@redhat.com>
	<20171116173810.16457-3-crosa@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b110f197-b5a3-3216-daa3-4a5850d7aae7@redhat.com>
Date: Fri, 1 Dec 2017 21:17:42 +0100
MIME-Version: 1.0
In-Reply-To: <20171116173810.16457-3-crosa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WBCmc57mf941cFwGVKodfDB6nhtxA5q2C"
Subject: Re: [Qemu-devel] [PATCH 02/10] qemu-iotests: fix filename
 containing checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WBCmc57mf941cFwGVKodfDB6nhtxA5q2C
From: Max Reitz <mreitz@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <b110f197-b5a3-3216-daa3-4a5850d7aae7@redhat.com>
Subject: Re: [PATCH 02/10] qemu-iotests: fix filename containing checks
References: <20171116173810.16457-1-crosa@redhat.com>
 <20171116173810.16457-3-crosa@redhat.com>
In-Reply-To: <20171116173810.16457-3-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-16 18:38, Cleber Rosa wrote:
> Commit cce293a2945 moved some functions from common.config to
> common.rc, but the error messages still reference the old file
> location.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/qemu-iotests/common.rc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
Reviewed-by: Max Reitz <mreitz@redhat.com>


--WBCmc57mf941cFwGVKodfDB6nhtxA5q2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlohuOYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AbAoH/1qxyRFtUrMt8EmUlrDioI/PUvnRFrQj
Zi3teeY4STSNBtl/jLpnC6tRaotOnaFLa72RtCRaWFhDK3UqcsvTMeBab7mYB1lu
hT71LfiCouDsMpT3CmhXYGrSWNlPwZe631XSDMYmDEnKTPl2HeN6tOKZqKjRR17h
CNd2blPRH4CNIT5/UwVjFtGhtBDfjTi4Z9qC1hbw+S/CasdHbYPvQSyZbbYg73vu
nemdVYQ17P9xDzyfbXWNtSKGICu9yPKkxq9K93ZSdiIYLQiaNBY52XhA3BJOgQEh
Z2/Trm7HwSUQFFSshpeXMBSIVNk3Vrj1BEm2qLuIWPKfWQVVPk9cuAY=
=RsHW
-----END PGP SIGNATURE-----

--WBCmc57mf941cFwGVKodfDB6nhtxA5q2C--
