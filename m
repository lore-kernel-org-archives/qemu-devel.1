Received: from eggs.gnu.org ([2001:4830:134:3::10]:57485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db4BP-0002iE-Mq
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db4BO-0008GC-Sl
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:15:55 -0400
Date: Fri, 28 Jul 2017 13:15:51 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170728121551.GH12364@stefanha-x1.localdomain>
References: <20170727120210.6943-1-crosa@redhat.com>
	<20170727120210.6943-4-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1EKig6ypoSyM7jaD"
Content-Disposition: inline
In-Reply-To: <20170727120210.6943-4-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] qemu-iotests: remove commented out
 variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org


--1EKig6ypoSyM7jaD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2017 at 08:02:08AM -0400, Cleber Rosa wrote:
> The variables FULL_MKFS_OPTIONS and FULL_MOUNT_OPTIONS are commented
> out, never used, and even refer to functions that do exist.  The last
> time these were touched was around 8 years ago, so I guess it's safe
> to assume outputting such information on test execution is still on the
> radar.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/qemu-iotests/check | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--1EKig6ypoSyM7jaD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZeyr3AAoJEJykq7OBq3PIoLMH/0k46GD3Ug/f4SaAehmPuqUw
VGlzFXqU39doBv4WzzQsjeS4a7DivzyyXvSxUVsARy/1xKrXQBf3oNHu86i+wDUK
U9rjxS6dKrcH7C0VxnDiyJYb4ksczTmA2DqhcGaWvc8YTeK+WmzPwFf0O2v4hHI0
A7vjq+1mONcdM3hEf506z7A3CmPWJ9N516EaAV5RF0P0mmSS4VDMfDUbFjHJuezT
2pqaMtByioGvd6jJnxboeDKrcYjsAuOtd7MfytP00WEHCmtClWwgL8n/kFbPhNrM
Y8ztLitstPiFh/ffGO96snSrEvfsNzUryvRXBRvuFkRmhLHt04sohLtNmhcsGIw=
=Hfvs
-----END PGP SIGNATURE-----

--1EKig6ypoSyM7jaD--
