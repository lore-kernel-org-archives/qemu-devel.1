Received: from eggs.gnu.org ([2001:4830:134:3::10]:44325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cikIo-0004uD-Vn
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cikIo-0007U1-CA
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:07:02 -0500
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
	<1488286469-9381-42-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bd05f3c2-a8e2-1e18-9ef7-4ec2f69ec593@redhat.com>
Date: Tue, 28 Feb 2017 17:06:55 +0100
MIME-Version: 1.0
In-Reply-To: <1488286469-9381-42-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QDSHNUHah9lg0NI4pTWk74djd0msBwvE6"
Subject: Re: [Qemu-devel] [PATCH v3 41/44] block: Assertions for write
 permissions
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
--QDSHNUHah9lg0NI4pTWk74djd0msBwvE6
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <bd05f3c2-a8e2-1e18-9ef7-4ec2f69ec593@redhat.com>
Subject: Re: [PATCH v3 41/44] block: Assertions for write permissions
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
 <1488286469-9381-42-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488286469-9381-42-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 28.02.2017 13:54, Kevin Wolf wrote:
> This adds assertions that ensure that the necessary write permissions
> have been granted before someone attempts to write to a node.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/io.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--QDSHNUHah9lg0NI4pTWk74djd0msBwvE6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli1oB8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AGT8IAJ6U2e7ZZseGmUerAIlyXq+HfcrRcg0g
pl4KNSFdFU7CbBZ2MJOcVVJiaJblIq8h+3Xj8YX+QnlYHF220bdwZy9aJLN3WFbh
L44j8HIiz7uQ8kYxvDeam55WJ7VZF2d17tDLSxFzIVxb2PZtYx3oFSqQ9qsndoJe
m1eWRZBjrFsIOiGOi8q3RqEx5f/Ujzq3LptowCBYwIg1+V+ay3RW8ruXXY530PLy
6I6T9Kn2JUOU1bew6tOKFdpMNWHPWYSzBXYl7Vo6KRHVp59mzmIit+Rl+eq9AcsU
roJQdnXkHPzo8J9f+XyyFp4oHRk6rKexzio3nigrd9ZUdITftpLPM/M=
=DKIi
-----END PGP SIGNATURE-----

--QDSHNUHah9lg0NI4pTWk74djd0msBwvE6--
