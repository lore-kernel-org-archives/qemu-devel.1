Received: from eggs.gnu.org ([2001:4830:134:3::10]:57848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db4Bw-00039u-If
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db4Bv-0000RE-ON
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:16:28 -0400
Date: Fri, 28 Jul 2017 13:16:24 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170728121624.GI12364@stefanha-x1.localdomain>
References: <20170727120210.6943-1-crosa@redhat.com>
	<20170727120210.6943-5-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/8E7gjuj425jZz9t"
Content-Disposition: inline
In-Reply-To: <20170727120210.6943-5-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] qemu-iotests: remove comment about
 root privileges requirement
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


--/8E7gjuj425jZz9t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2017 at 08:02:09AM -0400, Cleber Rosa wrote:
> The check script contains a commented out root user requirement,
> probably because of its xfstests heritage.  This requirement doesn't
> apply to qemu-iotests, so it better be gone.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/qemu-iotests/check | 6 ------
>  1 file changed, 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/8E7gjuj425jZz9t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZeysYAAoJEJykq7OBq3PItJMIAMmAZx6hIExO8Sgow/fE0AjS
W7GOqGH/0Jxgiyf1npo2sQKXEl1BcBu9vpprGgjaeqYi13antu5qVRAkhhQJzUDD
M7R6+74Yv3b3kWQovK8Of+6oH6TFxNZwoFLP8hEMQfPviupyJ4163qrxBUfHXUrh
NuYE5EnMSDdJVyZZtyaqifhlPOqxgrllKl5FmbAKpMPVsIbWqFuhhpAuGqzVUvXW
hVcUerUARY7Tx1MWPbB1l1p76a60qZAWpza0RUlhIj3EOMzM1+1KSPzMkbGl79Dz
MrX0UjOAx7zuPQLPO/3DfFZp3UDWT0Fz0KJiK97Sd7O3ZUvOcdFn1Sq7GN73Oso=
=hpNq
-----END PGP SIGNATURE-----

--/8E7gjuj425jZz9t--
