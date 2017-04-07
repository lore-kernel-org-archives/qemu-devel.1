Received: from eggs.gnu.org ([2001:4830:134:3::10]:56653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwQ0Q-0004aX-Jf
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:16:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwQ0P-0004Ak-MV
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:16:34 -0400
Date: Fri, 7 Apr 2017 10:16:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170407091623.GH13602@stefanha-x1.localdomain>
References: <cover.1491416061.git.jcody@redhat.com>
	<91ebd19aec29055c98e4658ed5cf3fb50720afe5.1491416061.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fmEUq8M7S0s+Fl0V"
Content-Disposition: inline
In-Reply-To: <91ebd19aec29055c98e4658ed5cf3fb50720afe5.1491416061.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 4/9] block: code movement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, kwolf@redhat.com


--fmEUq8M7S0s+Fl0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 02:28:46PM -0400, Jeff Cody wrote:
> Move bdrv_is_read_only() up with its friends.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--fmEUq8M7S0s+Fl0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY51jnAAoJEJykq7OBq3PIVY4IALpaVBlqZMNR7j0v5xmSoEp4
jFkb3JLaLOCu0ykZdDzQpex9lqOZlAx+kweGuXvWdXbr94VEYqxYujDlBl88aRXw
vBIwXsWA2hdgP/dFxEUzyoz84EATMQaRYq7k9ypnBLKJtf/Oi3aqYlRYEl3Z9O3Z
xVB6cKWs3B3AN55G2aV89Ybg7a5YyDWFu/pCKeeyBOVf2/y03YBJN0dojfbaUreg
bA/Wr2OTnhSUEWQ6lvLIdnLx/gziCD5wHvzn+FMi+shT0/vRxCQacQ+RGrViK056
9XKv0MO1JBj5hsQsaGelAP1i49av3h9TNhJS5qSkjuydmkhhIraEaPqRpEVZ/as=
=dCOq
-----END PGP SIGNATURE-----

--fmEUq8M7S0s+Fl0V--
