Received: from eggs.gnu.org ([2001:4830:134:3::10]:60007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dZzIp-0005At-Ec
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dZzIo-0007ol-IA
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:51:07 -0400
Date: Tue, 25 Jul 2017 13:50:57 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170725125057.GB23343@stefanha-x1.localdomain>
References: <1500973176-29235-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
In-Reply-To: <1500973176-29235-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Fix reference output for 186
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 10:59:36AM +0200, Kevin Wolf wrote:
> Commits 70f17a1 ('error: Revert unwanted change of warning messages')
> and e1824e5 ('qemu-iotests: Test 'info block'') had a semantic merge
> conflict, which results in failure for qemu-iotests case 186. Fix the
> reference output to consider the changes of 70f17a1.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/186.out | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZdz6xAAoJEJykq7OBq3PIYCsIAJQes7GyDq2jANRjyqaK5UMx
r01CuuJjHJaAlSMJ5VOnELpavzp7AXG+Apu0/y1RI49DGXKLIFQAmHl+b12ppnnD
GgFKMFcv8MRQ8bzrSmwut9NTXPmb+bsJHTt/p3rjln29/ieZgSc488XAEg+MuO20
zIXbE0pBWJupcWQGVgImC/Xc0OZ4m0nAj7dvtYs3djktQX5or9YxI0Ict0o8IrxN
EzaEWTTPlcYEoFZUGmLLG4/m0+V12OQ7YwAgHYFCHHzTNucBQCgoaKGP229OP4lU
wIUy8wJ7+S6yrep1BKvuL/gAt7HYsot1xogrDgQ5MOq3hhXpfhR8Y3H14EtoZ4g=
=epht
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
