Received: from eggs.gnu.org ([2001:4830:134:3::10]:42346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUxem-0003NI-8n
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUxeh-0002Mx-CY
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:05:00 -0400
Date: Tue, 11 Jul 2017 17:04:50 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170711160450.GG31231@stefanha-x1.localdomain>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-12-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TmwHKJoIRFM7Mu/A"
Content-Disposition: inline
In-Reply-To: <20170704220346.29244-12-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/35] qcow2: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "open list:qcow" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>


--TmwHKJoIRFM7Mu/A
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 12:03:22AM +0200, Marc-Andr=E9 Lureau wrote:
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  block/qcow2.h         |  6 ++++--
>  block/qcow.c          |  4 +++-
>  block/qcow2-cluster.c | 11 +++++++----
>  block/qcow2.c         | 15 ++++++++++-----
>  4 files changed, 24 insertions(+), 12 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--TmwHKJoIRFM7Mu/A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZPciAAoJEJykq7OBq3PIFPQH/3txJe3ym9XNOajLnN+Tx+TB
DmsNQ58F+PwEYhXEFnEOKQmkoe1c6KYWbljvkrAggyfaSNgepaE2UUZ5lx02Zadu
bfFWhHZwWT584VIekJjiVbZf01eN4i8Kzfk7zuy+j9jDKd9eSpLxRzzXa5Y+8ihV
fFWu8AG4OATekQCRgHnnx9e9ZXrTgccUgxuJUNazqXNf3620JuxeDExYsSS2H/RN
p5HS+cFhjKrZe2YZn3wItt7td4nXdgO++Agdqm3Fyu/UC+64sl9EMgSDwJFOa6dX
wO2WKI5pvhccOv87idIDLCoFRHZzp8Az2nv8z5b8zlTlx2siBvZ4y85NL6gipP8=
=K0CJ
-----END PGP SIGNATURE-----

--TmwHKJoIRFM7Mu/A--
