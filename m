Received: from eggs.gnu.org ([209.51.188.92]:60238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gtyRx-0008Db-MH
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 12:35:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gtyRo-0002Bl-Rp
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 12:35:50 -0500
References: <20190210145736.1486-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <52330e46-2da6-9319-645c-fa24f51d9388@redhat.com>
Date: Wed, 13 Feb 2019 18:30:27 +0100
MIME-Version: 1.0
In-Reply-To: <20190210145736.1486-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YZSI5mcOI9R2lfcLuSzV5ZqcOQMBiqKz4"
Subject: Re: [Qemu-devel] [PATCH v3 00/10] iotests: Fix some issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YZSI5mcOI9R2lfcLuSzV5ZqcOQMBiqKz4
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <52330e46-2da6-9319-645c-fa24f51d9388@redhat.com>
Subject: Re: [PATCH v3 00/10] iotests: Fix some issues
References: <20190210145736.1486-1-mreitz@redhat.com>
In-Reply-To: <20190210145736.1486-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.02.19 15:57, Max Reitz wrote:
> No fundamental changes from v2, so if you=E2=80=99re new to this series=
, the
> cover letter is here:
>=20
> http://lists.nongnu.org/archive/html/qemu-block/2019-01/msg01123.html
>=20
>=20
> Otherwise, these are the changes:
>=20
> v3:
> - Patch 10: Rebased onto 039be85c410bfb4b53cdee2083b4245e0d4e4181

Applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--YZSI5mcOI9R2lfcLuSzV5ZqcOQMBiqKz4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxkVDMACgkQ9AfbAGHV
z0AOUAgAkbKiJfHKccfX7Wq9pQcOLtem3qdaDipYPcIGskwPLsyugJXyho8lXq0t
qCLCNuCFLqMvOp+8Bk3JRcNxcBWixQkliispv5cyTvV7EyO0/coRdWnIJywKs11f
y80z1RZj2SjDfVe4SHrt4JxoMTalh9T/0oCdi0kFDuB4HYvVMu1u8hG5lufqVJHu
o5gD2Rj2MO/I910vBsUfLgQbHEyL0HYgKJAywt4pLeYUOwGBckha6lkczZgmgnBF
CHsLEukZMJ/oHFWU8mk/r5uLfekhkO5IE+XiGwUQsOKaOLgtKWX/TAsQGXvVNA/g
jMJgkgpodxW9WIIT5GD6FGEVMlKMaw==
=xJgt
-----END PGP SIGNATURE-----

--YZSI5mcOI9R2lfcLuSzV5ZqcOQMBiqKz4--
