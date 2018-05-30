Received: from eggs.gnu.org ([2001:4830:134:3::10]:44380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNxtT-0002Mv-IG
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:59:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNxtS-0003iz-RI
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:59:47 -0400
References: <20180529203910.7615-1-kwolf@redhat.com>
	<20180529203910.7615-8-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ebe264c6-20b6-0fdf-a431-e3f7aa5210cd@redhat.com>
Date: Wed, 30 May 2018 11:59:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180529203910.7615-8-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XRdtAL6EFqSJ879xqL8WpLOFVcOikOG4B"
Subject: Re: [Qemu-devel] [PATCH v2 07/16] qemu-iotests: Add
 iotests.img_info_log()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XRdtAL6EFqSJ879xqL8WpLOFVcOikOG4B
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, eblake@redhat.com,
 pkrempa@redhat.com, qemu-devel@nongnu.org
Message-ID: <ebe264c6-20b6-0fdf-a431-e3f7aa5210cd@redhat.com>
Subject: Re: [PATCH v2 07/16] qemu-iotests: Add iotests.img_info_log()
References: <20180529203910.7615-1-kwolf@redhat.com>
 <20180529203910.7615-8-kwolf@redhat.com>
In-Reply-To: <20180529203910.7615-8-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-29 22:39, Kevin Wolf wrote:
> This adds a filter function to postprocess 'qemu-img info' input
> (similar to what _img_info does), and an img_info_log() function that
> calls 'qemu-img info' and logs the filtered output.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--XRdtAL6EFqSJ879xqL8WpLOFVcOikOG4B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsOdgoACgkQ9AfbAGHV
z0C2cwf/d5zfO2e0CDZMPoPv0a8iSyDAB5/NvFkA1uSgvR1AttcaDdb5HMmGDu4/
PKX1MXmy35TbFZycpBQB8hljhNRs3pDhXJkEl9zTPsqOVSzC51j0LsclIOV7j5qV
UYRZXF/BkMZ2abNi6JuhIf+HT8y5W/rjFW22wMVmn5WUV2/Dwtsm6Bw9EwlFpEWe
uUBJ04EYMunsVQPGmwhchdcYRljQZUVDj0i4esRHHjAonUn2HZvC1DFDa7l/O/5p
SLjR5wSredKEBNkFZ2tBiDT8INUJZiz7iJilOohG+5V4LLCtNua1dGUGmjj6dOg7
TA1FuyRvoIfPgp32H/V4VOP7kM/kJw==
=7+6j
-----END PGP SIGNATURE-----

--XRdtAL6EFqSJ879xqL8WpLOFVcOikOG4B--
