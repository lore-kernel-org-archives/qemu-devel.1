Received: from eggs.gnu.org ([2001:4830:134:3::10]:56306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etAyp-0007xB-Lo
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:42:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etAym-0006kt-Gs
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:42:03 -0500
Date: Tue, 6 Mar 2018 11:41:57 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180306114157.GF31045@stefanha-x1.localdomain>
References: <20180222215838.18223-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WlEyl6ow+jlIgNUh"
Content-Disposition: inline
In-Reply-To: <20180222215838.18223-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] checkpatch: Exempt long URLs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, peter.maydell@linaro.org


--WlEyl6ow+jlIgNUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 03:58:38PM -0600, Eric Blake wrote:
> Sometimes, we want to refer to really long URLs, but checkpatch
> balks, and we have to manually bypass the check.  URL shorterners
> may be nice at reducing long links, but it's hard to guarantee the
> shortened link will live as long as the real target, and it is
> also nice to see the original target without having to load the
> shortened URL through a browser.  So exempt a line containing
> only a URL from the long-line syntax check.
>=20
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  scripts/checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--WlEyl6ow+jlIgNUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJann6FAAoJEJykq7OBq3PIjksH/1udaa9BV34N3rBWH+aWNZSz
ZDWmwfaf4sf1i30czTDghtRRolnoPiQbeDkxmblv3jy6JoSvhv/L+OthhqSWSYRF
z0V/+NxWacXCowKzvzwAV379yRhyB6QkJxj/CY/QOAbB/haSyVMN+XTbdYQ5MMBI
S6+yrLdRoXoD3std8GoUpOyhqrF5UaSo2XDze4c9Yh60M8lFh7rY+CDzzdsTb4bY
O95/N1S+HXOOWGr27J6WHF4NVmFMA5qHK5qyRGta9+obyB+M2PtEZtd/jw9Kuil1
MWZ+s7WSx1xWNI/dOmfx+lNEHs1sZRbcv3jvcPDPzT9HFPXplHHn2XUgk+sccRk=
=uyIe
-----END PGP SIGNATURE-----

--WlEyl6ow+jlIgNUh--
