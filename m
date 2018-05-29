Received: from eggs.gnu.org ([2001:4830:134:3::10]:50176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNd0z-00084m-2p
	for qemu-devel@nongnu.org; Tue, 29 May 2018 07:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNd0y-0004Uy-BE
	for qemu-devel@nongnu.org; Tue, 29 May 2018 07:42:09 -0400
References: <20180525163327.23097-1-kwolf@redhat.com>
	<20180525163327.23097-6-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1acb8bac-48b6-f643-5871-1311e35d6db7@redhat.com>
Date: Tue, 29 May 2018 13:41:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180525163327.23097-6-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kVlm3rhBK8QbsbsQZ1nFpzhrHespLDcma"
Subject: Re: [Qemu-devel] [PATCH 05/14] qemu-iotests: Add
 VM.get_qmp_events_filtered()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kVlm3rhBK8QbsbsQZ1nFpzhrHespLDcma
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <1acb8bac-48b6-f643-5871-1311e35d6db7@redhat.com>
Subject: Re: [PATCH 05/14] qemu-iotests: Add VM.get_qmp_events_filtered()
References: <20180525163327.23097-1-kwolf@redhat.com>
 <20180525163327.23097-6-kwolf@redhat.com>
In-Reply-To: <20180525163327.23097-6-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-25 18:33, Kevin Wolf wrote:
> This adds a helper function that returns a list of QMP events that are
> already filtered through filter_qmp_event().
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--kVlm3rhBK8QbsbsQZ1nFpzhrHespLDcma
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsNPIYACgkQ9AfbAGHV
z0A5jwf+IQM3xPRKpol5R/oa6q3274vO6s+bX8JFr5uGQDQ5ZaoMAzowBhwQIIuZ
DTuk4PltVHeyNrlHk9VJO9wZueK24G/aT54Mccq5Yveq0wjjmyE8UNfm7Tas2dH9
nAMlhvS74C00T9UQyunULWbKToyM0wF4oPoYhnkOuKMHCtw59nFnZ1vOXC93paBr
EiN2l/osGYkXvjejKGVFd2fgV8YzmJ+X+YJadNWTGeWWM/sltI8JR1KjpsouatpW
UCPQvu7MONNHSmbOmAyAH3/teqTS9sLjs5+uKpMFcOopNGtDkzPBqkCo9jBnMcPZ
osTyaG2qnCSomseunIB1qaY2lCj6vQ==
=jYFI
-----END PGP SIGNATURE-----

--kVlm3rhBK8QbsbsQZ1nFpzhrHespLDcma--
