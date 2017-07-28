Received: from eggs.gnu.org ([2001:4830:134:3::10]:59194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db4Dk-0004bD-1y
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db4De-0002AH-5r
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:18:20 -0400
Date: Fri, 28 Jul 2017 13:18:10 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170728121810.GK12364@stefanha-x1.localdomain>
References: <20170727120210.6943-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jtds+vpI57xq70EV"
Content-Disposition: inline
In-Reply-To: <20170727120210.6943-1-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] Trivial fixes and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>


--Jtds+vpI57xq70EV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2017 at 08:02:05AM -0400, Cleber Rosa wrote:
> This is a collection of trivial fixes and cleanups.  The only expected
> behavior change is in the output on config.log, as per the first
> patch.
>=20
> Cleber Rosa(5):
>   configure: remove duplicate single quotes on config.log
>   qemu-iotests: get rid of _full_imgproto_details()
>   qemu-iotests: remove commented out variables
>   qemu-iotests: remove comment about root privileges
>   docs: fix broken paths to docs/interop dir
>=20
>  configure                           |  4 +---
>  docs/devel/writing-qmp-commands.txt |  2 +-
>  qapi-schema.json                    |  2 +-
>  tests/qemu-iotests/check            | 13 +------------
>  tests/qemu-iotests/common.rc        |  5 -----
>  5 files changed, 4 insertions(+), 22 deletions(-)

CCing Kevin Wolf for qemu-iotests changes.

--Jtds+vpI57xq70EV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZeyuCAAoJEJykq7OBq3PIlrsH/3Ayv4QECyKxXyp6GulhAFYS
hWTqMi0dqusNqMGJ7nkZrapGCdkWx68J/XiBt3BfxcLABDDawW439oa6KKV1jp29
93mpCgEMYsKIN5hB/9gLJZCzYP8dzrTVVjQcucns35Oh0eMBZVN1sdt635k5EBOX
CU7NMtsR2vK+mIY7RQdQWR71qhbIzmoRknDEJU9cng/ACZQA/AFPx8DYVL1Hchv2
WNuYpYoNLdH08vYPIFicOIkEU1tB4dK+NDUx6qc/8fluIryq7ZrYDXFV4YNMbduj
7FpFVPS/Fo+JujEslgm+d5y/lYVq6jiP6L0fdfkqbnt/Dyqc5oOPvGszDs9XuqI=
=IkX0
-----END PGP SIGNATURE-----

--Jtds+vpI57xq70EV--
