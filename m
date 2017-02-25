Received: from eggs.gnu.org ([2001:4830:134:3::10]:52580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chdvh-0004gn-1m
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 10:06:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chdvg-0001KO-9v
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 10:06:37 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-50-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b2572b62-28d3-18a9-7ac6-77480e905468@redhat.com>
Date: Sat, 25 Feb 2017 16:06:30 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-50-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rIec59l9sAnJOwaLGtncAM5WE9irBIlC5"
Subject: Re: [Qemu-devel] [PATCH 49/54] tests: Remove FIXME comments
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
--rIec59l9sAnJOwaLGtncAM5WE9irBIlC5
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <b2572b62-28d3-18a9-7ac6-77480e905468@redhat.com>
Subject: Re: [PATCH 49/54] tests: Remove FIXME comments
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-50-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-50-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> Not requesting any permissions is actually correct for these test cases=

> because no actual I/O or other operation covered by the permission
> system is performed.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/test-blockjob.c | 2 +-
>  tests/test-throttle.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--rIec59l9sAnJOwaLGtncAM5WE9irBIlC5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlixnXYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AwDIIAKZ2oCS27adx+a68l1/7u6MRzmkdP+Ur
c4qxySoJBG2Rgw5gAzmbbzMgY7upEm6LEP01Zzf0htfp06obiOuz/ndZDWsXEWLr
c8zpxveINO010k83uEFtxHBn6DaOKgnufGsoY0oA9H4QoalMKm7Hkif9PbiP0ABV
Y1znGRsKmeqg8Ee+kaunkWogkIM+Y4geyeir9FePV2cskFU5NMh92U6jqwtH+Dhr
W/gzplrpMmOjJzilRiyq/lr/8NRcOtr05QhVQN63UqYN1X7TNVoMof3zX22Vks/K
CiTYKyDi2r2iccNxA1O0AAFCUg4QwYNqGU7tFc9BKUnByOasuHqaDs4=
=X6zJ
-----END PGP SIGNATURE-----

--rIec59l9sAnJOwaLGtncAM5WE9irBIlC5--
