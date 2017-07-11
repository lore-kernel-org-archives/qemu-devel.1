Received: from eggs.gnu.org ([2001:4830:134:3::10]:43220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUxh7-0005Cx-TH
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:07:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUxh3-0003kN-0C
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:07:25 -0400
Date: Tue, 11 Jul 2017 17:06:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170711160612.GH31231@stefanha-x1.localdomain>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-13-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1EKig6ypoSyM7jaD"
Content-Disposition: inline
In-Reply-To: <20170704220346.29244-13-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 12/35] raw: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "open list:raw" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>


--1EKig6ypoSyM7jaD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 12:03:23AM +0200, Marc-Andr=E9 Lureau wrote:
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  block/raw-format.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--1EKig6ypoSyM7jaD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZPd0AAoJEJykq7OBq3PIJaQIAJ5EXh8E+LyAbfI2oED6fW2B
4IpntTk1Pgoa7MwUXFWZp+j1kYtpdFHkLHrpUJOemxurKdqt1zf4oK3jIt5NzMm3
hPHbd9kBRrTMV56XMLYa384/8ZSPuCUdqh8Os1gL2r+AVawn7kos+XgVHsGpStWD
02JiUUjygbuxt5oun5wPSmuFsHyJ5rEpQI12rdbKEsc9V2v2f+Em1EhW98HjZXj1
qAJU8ffz4VFslWmytSrMoiaLk9RqRNVcgZO0nqLI0pBUKD9zhOzrjii3Mcs7jcOR
sH3u576gpfg9FpioHBxDhG7oUnfPCnb4LzNubfoOxucMsVe3QH/Xd1AmjxlKQPg=
=8dQh
-----END PGP SIGNATURE-----

--1EKig6ypoSyM7jaD--
