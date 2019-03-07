Received: from eggs.gnu.org ([209.51.188.92]:51032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h1xYO-0007jH-U5
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:15:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h1xYM-00063z-Vr
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:15:36 -0500
Date: Thu, 7 Mar 2019 18:15:29 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190307181529.GF2915@stefanha-x1.localdomain>
References: <20190307165303.15382-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O98KdSgI27dgYlM5"
Content-Disposition: inline
In-Reply-To: <20190307165303.15382-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2 spec: Describe string header
 extensions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, qemu-devel@nongnu.org


--O98KdSgI27dgYlM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 05:53:03PM +0100, Kevin Wolf wrote:
> Be more specific about the string representation in header extensions.
>=20
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  docs/interop/qcow2.txt | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--O98KdSgI27dgYlM5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcgV/BAAoJEJykq7OBq3PI7moIALgHBlTYhIm2eEWd84CWKzVf
a7hXLSO/iD/7OhDgbgP/8XTGXFXTCZgERNdozDIcNTm1A/Ieferk0JTb5VAAY6d+
Kx4j35bp9f7Z7DNhYWRmdLI35Ml4XDHa+eqMZKEqSuj4QIe/p4j38672O4aAI4M9
axZShSRUHtMh6UQbv56ooJtehRb4a1ZGWISM78FPDu7Mjt+0zqQJYgGG/yM0z+6g
p+byi0tGzQqGZX2YGFTZ7mCUkylTUCAvNnHgD/s1IEjtMiSjSXJ1DMvTtVcIQofS
S+EiBDj5b+AGC4D6yd1h6/lp4siB4n08b5FDX68688Z7iZlIUTpI1wrZH/zExeY=
=41xF
-----END PGP SIGNATURE-----

--O98KdSgI27dgYlM5--
