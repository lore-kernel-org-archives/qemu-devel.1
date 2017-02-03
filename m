Received: from eggs.gnu.org ([2001:4830:134:3::10]:46405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZf1l-0008NM-1M
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:39:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZf1g-0003hz-Bh
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:39:53 -0500
Date: Fri, 3 Feb 2017 14:39:44 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170203143944.GC642@stefanha-x1.localdomain>
References: <20170202114101.2655-1-philipp.gesang@intra2net.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Content-Disposition: inline
In-Reply-To: <20170202114101.2655-1-philipp.gesang@intra2net.com>
Subject: Re: [Qemu-devel] [PATCH] docs: update manpage for stderr->log rename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philipp Gesang <philipp.gesang@intra2net.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 02, 2017 at 12:41:01PM +0100, Philipp Gesang wrote:
> With commit ed7f5f1d8db06fc31352a5ef4f54985e630c575a the name of
> this backend changed from =E2=80=9Cstderr=E2=80=9D to =E2=80=9Clog=E2=80=
=9D.
>=20
> Signed-off-by: Philipp Gesang <philipp.gesang@intra2net.com>
> ---
>  qemu-option-trace.texi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYlJYvAAoJEJykq7OBq3PIKzgIALY+RFz7vW5JFugL1SxQmfqI
pANXTyhNi20h0Hj6jUw1c6GJPYGX9UsAtco9rZmKXOWpc4slwkmCvhq3HpYzngUH
3aHD5FsdcolwQqcgvcMGykoCCQV1BadyXQ3X47NoTroKB9voSuLYJg6FNk3W7ZhP
15TamXqQS2ZPU4Rsx4WeXAOqBgtVRDl6sX7OUFVcn82QiTkkq2NbR/DiRHGVIere
692z+nFKYtkMnzYQmfwxyL/+visKadpLyBp+CRiJFYoTHz5aHO6V52NqnR7N0Tys
JQoVRgJRugDxMSD414XXu7Mi+1145neEXHT+Lm3R2rTWfII0K3T40PnjeZS/LQo=
=ialI
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--
