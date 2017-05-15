Received: from eggs.gnu.org ([2001:4830:134:3::10]:55318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAGl2-0002ia-N9
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAGkx-0007d8-Nx
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:13:56 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dAGkx-0007cs-K9
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:13:51 -0400
Received: by mail-qk0-x241.google.com with SMTP id u75so17278818qka.1
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 07:13:51 -0700 (PDT)
Date: Mon, 15 May 2017 15:13:48 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170515141348.GN1201@stefanha-x1.localdomain>
References: <20170513022143.2838-1-n54@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QQNwO3VdVfodZayb"
Content-Disposition: inline
In-Reply-To: <20170513022143.2838-1-n54@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] maintainers: Add myself as a NetBSD
 reviewer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


--QQNwO3VdVfodZayb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 13, 2017 at 04:21:43AM +0200, Kamil Rytarowski wrote:
> I volunteer to review NetBSD patches.
> Adding myself will help to not miss some of them.
>=20
> Restore NetBSD as a maintained host.
>=20
> All patches to make qemu/pkgsrc building have been emitted to review.
>=20
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> ---
>  MAINTAINERS | 6 ++++++
>  configure   | 1 +
>  2 files changed, 7 insertions(+)

Will you maintain a patch queue (git repo) so you can send pull
requests?  If yes, please add a T: field.

Thanks,
Stefan

--QQNwO3VdVfodZayb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGbecAAoJEJykq7OBq3PIcL8H/A24Kwl4e4eJOP5nVTS+Sa2C
dzzeMa8jAuP64UiQWws9sQH2Rzzzw7aWT0RDLs0Ewdctorqzgw7HGwYlFzmCuCxu
98fpbgwGtqlziExJJGdILkWGbkpzu10tnDU02moidTeZKiwCr/FoyjTlvz3TVwxM
h6kfAbBQ9L8JFxfeWym6mSQRj2M3tR3+cIM207C1+ZqhOxcHsYBJOUuV8DDJaIeJ
+bbeXRCxTkbz23v6R8vbpphIYLTfqvfxdB0DHwT1IizIWllgmUdeFq/bNiHcPzSx
ZUDv6l9mHrWKL15OAI5IrSEEdW4aEh8sitDXwvwJAvOhd7iXpnIH+Kf8GF2xotM=
=l0n2
-----END PGP SIGNATURE-----

--QQNwO3VdVfodZayb--
