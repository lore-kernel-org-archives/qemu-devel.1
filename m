Received: from eggs.gnu.org ([209.51.188.92]:51301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gsq98-0007Sh-QQ
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 09:31:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gsq98-000142-2B
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 09:31:50 -0500
References: <20190201192935.18394-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <988211be-4de7-76db-f571-c4189a291050@redhat.com>
Date: Sun, 10 Feb 2019 15:31:41 +0100
MIME-Version: 1.0
In-Reply-To: <20190201192935.18394-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lQEufSDJ3GZ01GR89lYDNH6DLdBA1RTnY"
Subject: Re: [Qemu-devel] [PATCH v13 00/31] Fix some filename generation
 issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lQEufSDJ3GZ01GR89lYDNH6DLdBA1RTnY
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <988211be-4de7-76db-f571-c4189a291050@redhat.com>
Subject: Re: [PATCH v13 00/31] Fix some filename generation issues
References: <20190201192935.18394-1-mreitz@redhat.com>
In-Reply-To: <20190201192935.18394-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.02.19 20:29, Max Reitz wrote:
> Once more, I=E2=80=99ll spare both me and you another iteration of the =
cover
> letter, so I direct you to the previous version=E2=80=99s cover letter =
(which
> will direct you further):
>=20
> http://lists.nongnu.org/archive/html/qemu-block/2018-10/msg00229.html
>=20
> There are mostly rebase fixes in this version.  Provided no major
> complaints arise, I intend to merge this series in the next week or so.=

Thanks for the reviews in all of the versions until now, applied to my
block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--lQEufSDJ3GZ01GR89lYDNH6DLdBA1RTnY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxgNc0ACgkQ9AfbAGHV
z0B7uAf8CWPFKbfOLCsVCJ2ir4jwAhf9JcrILqYsKudx8w4K23zkEBea8PL3dxJH
Nfl6i/gf82X6gwd7ZjXA1q4OeRTpdIWzC0FjM42g1wMDedHXY4YJDlBGi4E4O/eD
enevolSCy6xlnJWoGRNlwhrG5yZ4DyczYl6gZy7MAWitsqqa8ztlk9JNbSWAHAW+
JtmrI+T2FkdVrtVtNXjFbaJQRFFpZmGbBZOYZjAEoliSE51o/bxOZeK2EOI57SU3
mbtKmWbs2KiB6GblEownQ4UNKWjPwRxAI6BbXsIJqIzzIh9jtByniTnvc9C1GI2+
X8cOHJpsZucvhCG2A88ddaRLpiFYow==
=Z1oK
-----END PGP SIGNATURE-----

--lQEufSDJ3GZ01GR89lYDNH6DLdBA1RTnY--
