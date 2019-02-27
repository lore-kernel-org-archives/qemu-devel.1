Received: from eggs.gnu.org ([209.51.188.92]:52758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyzVT-0006oM-0R
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:44:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyzVP-0002sv-Rt
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:44:18 -0500
References: <1549378185-7970-1-git-send-email-thuth@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5b987596-37e5-242f-2ee3-f7e66f2a56f3@redhat.com>
Date: Wed, 27 Feb 2019 14:42:30 +0100
MIME-Version: 1.0
In-Reply-To: <1549378185-7970-1-git-send-email-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QT5lfbSGLpqz1ryQ0Mu9oijMVYg5eAcyJ"
Subject: Re: [Qemu-devel] [PATCH] tests/qemu-iotests: Remove redundant
 COPYING file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QT5lfbSGLpqz1ryQ0Mu9oijMVYg5eAcyJ
From: Max Reitz <mreitz@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org
Message-ID: <5b987596-37e5-242f-2ee3-f7e66f2a56f3@redhat.com>
Subject: Re: [PATCH] tests/qemu-iotests: Remove redundant COPYING file
References: <1549378185-7970-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1549378185-7970-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.02.19 15:49, Thomas Huth wrote:
> The file tests/qemu-iotests/COPYING is the same text as in the
> COPYING file in the main directory. So as far as I can see, we don't
> need the duplicate here.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qemu-iotests/COPYING | 339 -------------------------------------=
--------
>  1 file changed, 339 deletions(-)
>  delete mode 100644 tests/qemu-iotests/COPYING

Reviewed-by: Max Reitz <mreitz@redhat.com>


--QT5lfbSGLpqz1ryQ0Mu9oijMVYg5eAcyJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlx2k8YACgkQ9AfbAGHV
z0BmlAf/R8r7SGaYbQBzxz3A4NJRPi4gNT8b6viQ8hi00SoGk90KArIe+OaPVXej
WAn59BlHqIa0DwIKPutYGxeIACQO+ruJ+KWxjZ8tJfPPv2iu5KOeqP5dhYrtXAeb
sef5t+ropQCgbHsoE5f7jEDNcxfKaKgq50fot9JVgGLf10VHGPk81ddBhEMnleMM
iBQwy/FpH7JqF1cYOMvLGnTSOj1fVdcEMWU7JD0rW0NUhog2qyBHxuFHmv8volnr
SJTKYbngrgzRMNdCXByEwx7H6oh5GHu+fr/PSFaPQtDqawRbXmat9D+gPJ5Pd7BP
1QFDco/adwb918UFzmitnnF194S3cg==
=YDtQ
-----END PGP SIGNATURE-----

--QT5lfbSGLpqz1ryQ0Mu9oijMVYg5eAcyJ--
