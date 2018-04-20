Received: from eggs.gnu.org ([2001:4830:134:3::10]:49904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9Rdv-0003li-98
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9Rdt-00046V-Cr
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:43:42 -0400
Date: Fri, 20 Apr 2018 16:43:30 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180420084330.GR15181@stefanha-x1.localdomain>
References: <20180416165849.28864-1-mreitz@redhat.com>
	<20180416165849.28864-10-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ep5m4srWGXPl6O+g"
Content-Disposition: inline
In-Reply-To: <20180416165849.28864-10-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 9/9] iotests: Add test for COR across nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--Ep5m4srWGXPl6O+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 16, 2018 at 06:58:49PM +0200, Max Reitz wrote:
> diff --git a/tests/qemu-iotests/216 b/tests/qemu-iotests/216
> new file mode 100755
> index 0000000000..2f34f94faa
> --- /dev/null
> +++ b/tests/qemu-iotests/216
> @@ -0,0 +1,117 @@
> +#!/usr/bin/env python

Welcome to the dark side!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Ep5m4srWGXPl6O+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa2agyAAoJEJykq7OBq3PIDGUH/1ow9dZlXv77gJnfhH7+WLCF
R+y6rpWpqzWb8ZLCb5G9AbG+v/Em/GJDZG6V3wVaf04xwruLxroQ2fqRJx/XVpuG
2tOM6jtofy9PoLIpmZisCiUYLGhO9YBscOijoi6aHC7lCCpPNXrIieQwpZwV1Orj
6mJR9XZcgObVaibK9cEcIUbg0uWoABClboKXBWGxHApAoWfx/JQtES34p/43GTlE
pZVAXzu/obHeG78RLNT2eO8l3+56XMu/JTwoNJhh5lbGY2aTcis36rGD+PBb8zxS
nz2AUfz08+yHvO8Y5TtdEbm+XG+J88qQLNqbiwKcsbbAW1liXRGhlrWHwiah7Tk=
=M3oC
-----END PGP SIGNATURE-----

--Ep5m4srWGXPl6O+g--
