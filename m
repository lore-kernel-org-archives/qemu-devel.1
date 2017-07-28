Received: from eggs.gnu.org ([2001:4830:134:3::10]:58690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db4Ct-0003vx-SD
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db4Cp-0001YO-Ci
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:17:27 -0400
Date: Fri, 28 Jul 2017 13:17:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170728121720.GJ12364@stefanha-x1.localdomain>
References: <20170727120210.6943-1-crosa@redhat.com>
	<20170727120210.6943-6-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6THr7QwYWIbrk6Kt"
Content-Disposition: inline
In-Reply-To: <20170727120210.6943-6-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] docs: fix broken paths to docs/interop
 dir
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


--6THr7QwYWIbrk6Kt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2017 at 08:02:10AM -0400, Cleber Rosa wrote:
> With the move of some docs to docs/interop on d59157e, a couple of
> references where not updated.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  docs/devel/writing-qmp-commands.txt | 2 +-
>  qapi-schema.json                    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6THr7QwYWIbrk6Kt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZeytQAAoJEJykq7OBq3PIlogH/0D6483jONvntkvTJDb/iwnU
Zcc5N33koqvSFq9cv9/H+NWhtIxrtw6iglqfNWHMxsJX/uJWo2ttAkgK2It6Vu5M
Ggu5lJgCP+dBXvsPMhvpAnw7VKD8LNN8G1Z8S1OJVjo6/6ozbPMdwloLGJxYrCFO
rh1psZR2UxtGN/h+V5A+MXtbBhCFBklFSuK8gqhph96AKX7+JWm6f0XDISJiWyIG
jyqOsa6dsPmEEP5vRqPVkOQH7cA1jXpOpojg84rIRMhRcE8DS9T7ceg6D/vGlCBb
COXs8J4G7QWRR108I61epknfsFm1jrxxytZER83nC1MPMVeoqUOe0OMK6RxIZJQ=
=vDcG
-----END PGP SIGNATURE-----

--6THr7QwYWIbrk6Kt--
