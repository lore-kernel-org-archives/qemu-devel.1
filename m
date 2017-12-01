Received: from eggs.gnu.org ([2001:4830:134:3::10]:37910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKsJg-0006lH-KI
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 15:53:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKsJg-00009k-0Z
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 15:53:48 -0500
References: <20171116173810.16457-1-crosa@redhat.com>
	<20171116173810.16457-9-crosa@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7145f34c-6745-d402-c6a5-d8320c5ff3dc@redhat.com>
Date: Fri, 1 Dec 2017 21:53:38 +0100
MIME-Version: 1.0
In-Reply-To: <20171116173810.16457-9-crosa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QJAVUp2Mf13gKO4mv1RShhcECd5dVDRlN"
Subject: Re: [Qemu-devel] [PATCH 08/10] qemu-iotests: clean up double
 comment characters
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
--QJAVUp2Mf13gKO4mv1RShhcECd5dVDRlN
From: Max Reitz <mreitz@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <7145f34c-6745-d402-c6a5-d8320c5ff3dc@redhat.com>
Subject: Re: [PATCH 08/10] qemu-iotests: clean up double comment characters
References: <20171116173810.16457-1-crosa@redhat.com>
 <20171116173810.16457-9-crosa@redhat.com>
In-Reply-To: <20171116173810.16457-9-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-16 18:38, Cleber Rosa wrote:
> This is a syntactic only change, just to make it consistent with
> the style used on all other tests.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/qemu-iotests/048 | 37 ++++++++++++++++++-------------------
>  tests/qemu-iotests/074 | 40 ++++++++++++++++++++--------------------
>  2 files changed, 38 insertions(+), 39 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--QJAVUp2Mf13gKO4mv1RShhcECd5dVDRlN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlohwVISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ARQQIAKXTPulDsmOWGFwIftUOK8RVhxWV4rOz
4tjiugK3jx5bE9BLW1+ZIsaqi+WuyNEorWquTehqlofIJocmPmRGek7g48b3sOIa
ndQ1N0JKw5k7P9tWfzMRzJPTKqbJVqShjuj7FjKqrTc1QsXK6WLPEh2AWl1CbZrg
mEOYtCxzEYfqX3O79OrM3IgN9HRLx/I6LYypmvfGJc3WFeAygJ2BzCfqTEOcbFnM
7EsBsnBjukUtb4OfjqiIiHMTI3oysJaf2Ac+u2fMJIWlMP9g94uV7c5dZ0Ov+4SI
o1tpb5Xw2Jq2D4mC8O9WoW6lRtc/G9kgh3fG7cadqPwmCkRybhiwc30=
=Gq2A
-----END PGP SIGNATURE-----

--QJAVUp2Mf13gKO4mv1RShhcECd5dVDRlN--
