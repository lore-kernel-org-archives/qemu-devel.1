Received: from eggs.gnu.org ([2001:4830:134:3::10]:57152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXCr-0002iO-46
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:43:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXCq-0001bY-Gs
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:43:45 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-13-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fac8368f-289f-c590-6af5-d71e88106416@redhat.com>
Date: Wed, 22 Feb 2017 14:43:38 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-13-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GCi4obd9bcxC3GKKSi9aIcRmiO8SudR6T"
Subject: Re: [Qemu-devel] [PATCH 12/54] block: Add op blocker permission
 constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GCi4obd9bcxC3GKKSi9aIcRmiO8SudR6T
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <fac8368f-289f-c590-6af5-d71e88106416@redhat.com>
Subject: Re: [PATCH 12/54] block: Add op blocker permission constants
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-13-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-13-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> This patch defines the permission categories that will be used by the
> new op blocker system.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block.h | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--GCi4obd9bcxC3GKKSi9aIcRmiO8SudR6T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlitlYoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AmlsH/iAFKZwK09d1I5f8XFYsp3RgaoTNUVY8
IIdKXU84yZ/mBXxoQ6/hRI65wxLSBZBptprSEbRGcTnJh//HLKtT7/PFbIWCqkub
VSC88WovjnYNKpGpy5sQEJ5F/GIb0CEQ07XSTlIivNB2v+NUPa5gOhrYYBEST0Tn
C3YIFmvsQaUxkRodvOJv498aiRfhAzejvI2XPtEIHOKSWL6tbRMxpFqT1l6do3KT
EtkyIJotmZ/2KDCw+/ej0q3IsxDXhisMaKAMmokb8GC8u31SxIP2HlcZVWsPpxQP
WIIcj/G1uSu0gt6r3n9r8l+y+GpJ1Nx8J+F3cXPM7PlQM3ItExP5yxg=
=pPDp
-----END PGP SIGNATURE-----

--GCi4obd9bcxC3GKKSi9aIcRmiO8SudR6T--
