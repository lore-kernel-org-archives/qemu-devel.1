Received: from eggs.gnu.org ([2001:4830:134:3::10]:59996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dDADq-0002f2-7a
	for qemu-devel@nongnu.org; Tue, 23 May 2017 09:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dDADm-0005RN-C4
	for qemu-devel@nongnu.org; Tue, 23 May 2017 09:51:38 -0400
Date: Tue, 23 May 2017 14:51:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170523135131.GF17369@stefanha-x1.localdomain>
References: <1495486409-5197-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JSkcQAAxhB1h8DcT"
Content-Disposition: inline
In-Reply-To: <1495486409-5197-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: Move the qemu-ga description
 into a separate chapter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>


--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2017 at 10:53:29PM +0200, Thomas Huth wrote:
> The qemu-ga description is currently a subsection of the Disk Images
> chapter - which does not make much sense since the qemu-ga is not
> directly related to disk images. So let's move this information
> into a separate chapter instead.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-doc.texi | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--JSkcQAAxhB1h8DcT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZJD5jAAoJEJykq7OBq3PINS8H/3TggK6bObX9nMJsj/+EaekT
D0h+zHPxgutxyqetAB0SS7t1XAkrf8E1NWqq1AgKF8C8AuUDP39zKKtik64VOTMM
poKBoYpJGJBiLYsLnZfRjEIP/ou8rDL/IJm9kC+aihhN5TDD+rO1+0jBigHeJphl
r720LyUbre6fCnBozLz9QpvzvikC7b3cX3tzZi9Lb5u5pQCdT5eOb2aJLLvIkqSf
m4C44uhXuQutIiTY2RMFhxOQk6ecO4gg8hp6waM65r6EjOQZyxr36nJpXWdYgWAe
BXvdeVEx4WSs5MUwPsmiWOcjCnzQqCpaHUlhXxla5wZyRRqE7irpYeemx2oQniI=
=q0PA
-----END PGP SIGNATURE-----

--JSkcQAAxhB1h8DcT--
