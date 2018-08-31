Received: from eggs.gnu.org ([2001:4830:134:3::10]:50527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fvkQ2-00014U-0F
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 10:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fvkOs-0002W7-6M
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 10:27:50 -0400
References: <20180831142446.22264-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c6d83ea0-295b-3874-936c-5f4681eb87bd@redhat.com>
Date: Fri, 31 Aug 2018 16:27:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180831142446.22264-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3HVCdIeP5ytBxTnmk1ahDoCs4BWx0hUpL"
Subject: Re: [Qemu-devel] [PULL 00/11] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3HVCdIeP5ytBxTnmk1ahDoCs4BWx0hUpL
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <c6d83ea0-295b-3874-936c-5f4681eb87bd@redhat.com>
Subject: Re: [PULL 00/11] Block patches
References: <20180831142446.22264-1-mreitz@redhat.com>
In-Reply-To: <20180831142446.22264-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-31 16:24, Max Reitz wrote:
> The following changes since commit 19b599f7664b2ebfd0f405fb79c14dd24155=
7452:
>=20
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-08-=
27-v2' into staging (2018-08-27 16:44:20 +0100)
>=20
> are available in the Git repository at:
>=20
>   https://git.xanclic.moe/XanClic/qemu.git tags/pull-block-2018-08-31
>=20
> for you to fetch changes up to 40954cc7831c4f95f9ce6402ae3d6761f44f31ff=
:
>=20
>   jobs: remove job_defer_to_main_loop (2018-08-31 16:11:27 +0200)
>=20
> ----------------------------------------------------------------
> Block patches:
> - (Block) job exit refactoring, part 1
>   (removing job_defer_to_main_loop())
> - Locking fix for the file-posix block driver
> - test-bdrv-drain leak fix
>=20
> ----------------------------------------------------------------

Self-NACK.  Sorry, I don't quite know how the locking fix slipped in
there, but it shouldn't be here.

Max


--3HVCdIeP5ytBxTnmk1ahDoCs4BWx0hUpL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluJUF0ACgkQ9AfbAGHV
z0BAAwgAkZvOBiM35BYdxV/xkpw3KLcm3HQOY6pw1AGjwwF0kOg80n+3nbR1e1dU
Tml8eNX35lGNzpDAwoDFeRjE/vRGPjwPdQjw7ydNQLdfDE8FdGNYf/ujm6gZYuah
wwjoIh0affq4ZZRs7wFv30F2tyAwLs5XnqtfFTR3+agyy5w8X0gKnpqk930n+qeD
IY53qC/L9VH91c9rpPW1kxw2vDxZrbrXj2wUbB6MZKZ/y6LaAZT236shA4zQS006
sLmkHvb6OAH11Sl2P7NFVdm8mR5MWvCSmrLzBPTuc935DHflIg4NeWSNkq68gBKq
XH/L2R+Ky8im2IL+Mxq54NLFf9wYhg==
=s5JT
-----END PGP SIGNATURE-----

--3HVCdIeP5ytBxTnmk1ahDoCs4BWx0hUpL--
