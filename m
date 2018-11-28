Received: from eggs.gnu.org ([2001:4830:134:3::10]:38210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gS2vX-0006rc-3Q
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:43:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gS2eS-00034B-Or
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:27:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gS2eS-00031N-Fu
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:25:24 -0500
Date: Wed, 28 Nov 2018 16:25:20 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181128162520.GB32132@stefanha-x1.localdomain>
References: <20181127190849.10558-1-ldewey@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <20181127190849.10558-1-ldewey@suse.com>
Subject: Re: [Qemu-devel] [PATCH] trace: simple style changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Larry Dewey <ldewey@suse.com>
Cc: qemu-devel@nongnu.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 12:08:49PM -0700, Larry Dewey wrote:
> This changes two lines in simple.c that end with a comma, and replaces th=
em
> with a semi-colon.
>=20
> Signed-off-by: Larry Dewey <ldewey@suse.com>
> ---
>  trace/simple.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, applied to my tracing-next tree:
https://github.com/stefanha/qemu/commits/tracing-next

Stefan

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb/sFwAAoJEJykq7OBq3PI9hgIALmXpEDHVzOZalspmqaVYZ4T
o21ijPfyd34luLlz/Ssk8i6HTjnxqkjQyqFRmrnyfizm5Usz7h802H3I5zYAuitX
IvwuKuT+7Vwre1wzEFCcE0CULmMtwa5kcBx3GWm1QHvZnOjXRx689Mil9dADIgpM
WIjGIdMEtj1jT+VFNcpks5f9sDuFSeLOw4BcKEd+6I2+KZlnE9INYwaAQY3x5UuZ
3/xOVo6xG2TYO79DLTqvq5g6eFRhjg8do54jJt5g6EJkvZ4PczcB4P82AsMjAnNa
CfLjiXDep+CiljbbY7HeLG+i83B4+tVSthXkMFWU1N4cfNZp6IOdIP74bGPTPvY=
=BC8E
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
