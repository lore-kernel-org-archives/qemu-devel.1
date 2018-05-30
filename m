Received: from eggs.gnu.org ([2001:4830:134:3::10]:42192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO0fO-0004a4-H3
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO0fK-0006hM-Ee
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:57:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42458 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fO0fK-0006h8-9o
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:57:22 -0400
Date: Wed, 30 May 2018 13:57:19 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180530125719.GM14623@stefanha-x1.localdomain>
References: <20180529193730.9204-1-crosa@redhat.com>
	<20180529193730.9204-4-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B9BE8dkJ1pIKavwa"
Content-Disposition: inline
In-Reply-To: <20180529193730.9204-4-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/5] Acceptance tests: add quick VNC
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>


--B9BE8dkJ1pIKavwa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 29, 2018 at 03:37:28PM -0400, Cleber Rosa wrote:
> This patch adds a few simple behavior tests for VNC.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/acceptance/vnc.py | 60 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 tests/acceptance/vnc.py

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--B9BE8dkJ1pIKavwa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbDp+vAAoJEJykq7OBq3PIp+AH/iZHqdsTf7I+swVhMrvmQtl0
6JuyXMfQZPTgnEOyAVpN7ha0FxlgE66HO4mLWXV+1MkeAUcr54WYP+16z/iRUzu+
+wotZ7+5L8lzaGHqRQbxsSyIUss/T2CIKVFqZo8ws2r227jGbuJJUr14+7NA96wh
2jprAYcqqePsEQArfNmtX0Iozg0xoGeDpsU2sLQgsYgiF5clc35Krv4GOSosd8cH
PhEh4hBhuUoCrpaMizcJlFs20YSXsWnm+Dj4t+eYkJ3lr+qrjEre2y1YqHOvfHrI
KuRcdPcrQ6mPvJjui/6fShUrohQ3XhV+lJJVo+6arS6ebMFVmTOH7Ou0nEAiJno=
=+KxV
-----END PGP SIGNATURE-----

--B9BE8dkJ1pIKavwa--
