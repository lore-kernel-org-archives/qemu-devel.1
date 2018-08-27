Received: from eggs.gnu.org ([2001:4830:134:3::10]:33426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuI5d-0002Yl-G4
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuI3D-00049B-Px
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 09:59:28 -0400
References: <20180823222249.13518-1-jsnow@redhat.com>
	<20180823222249.13518-12-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <89d7b1ee-0d1a-b1dc-82b5-739f48e0dae9@redhat.com>
Date: Mon, 27 Aug 2018 15:59:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180823222249.13518-12-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mn8rkBAbsiM7WqqZTUBXCeeUBCavvDrQU"
Subject: Re: [Qemu-devel] [PATCH v2 11/13] qapi/block-mirror: expose new job
 properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mn8rkBAbsiM7WqqZTUBXCeeUBCavvDrQU
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com,
 Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <89d7b1ee-0d1a-b1dc-82b5-739f48e0dae9@redhat.com>
Subject: Re: [PATCH v2 11/13] qapi/block-mirror: expose new job properties
References: <20180823222249.13518-1-jsnow@redhat.com>
 <20180823222249.13518-12-jsnow@redhat.com>
In-Reply-To: <20180823222249.13518-12-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-24 00:22, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  blockdev.c           | 14 ++++++++++++++
>  qapi/block-core.json | 30 ++++++++++++++++++++++++++++--
>  2 files changed, 42 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--mn8rkBAbsiM7WqqZTUBXCeeUBCavvDrQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluEA7MACgkQ9AfbAGHV
z0CALQf/SwsBq6XgNQfok7LuU08rd/QoPc1/qSD4n/PsxYTg43XQDVA+dq6Is53x
lA9tLB9SBmpwYwrtO3Gd6z9APG5PkUaSpvx/jNcS9J/NH+Ma5rKRE4eMgf6Hbv0G
+aoU1QHa7z55Dy92j9c4R94CuTilQ0T/aohi0lsxqPTaPYkdivODhDBr7GD2gbRQ
Pz4eEKZSBZTDdmsuMn1JygDE8jtj2bv17WPjFJESVq8iLwgOcPuTmBCIar+hrX8b
mcupymWKNqK0aS/D4ZzUaHIfTBTwb7WhHKZfa0bvZWg4I028zDo/yiGCQMOflAeP
Ct4wohgAtsTjpQfXQvIo0ZJv9PYvPw==
=0Vui
-----END PGP SIGNATURE-----

--mn8rkBAbsiM7WqqZTUBXCeeUBCavvDrQU--
