Received: from eggs.gnu.org ([209.51.188.92]:49328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1TNH-0000G7-Bl
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:02:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1TNF-0006dD-HS
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:02:07 -0500
References: <5310bd5d152fa36c1828a7cbd19fc893739d1609.camel@gmail.com>
	<20190306095615.GG22159@stefanha-x1.localdomain>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <6b3cfcb7-747e-1dc7-6987-1ad9d1fde2a3@vivier.eu>
Date: Wed, 6 Mar 2019 11:01:43 +0100
MIME-Version: 1.0
In-Reply-To: <20190306095615.GG22159@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wHed6j1HSAw0QV7eT6VQ6HgJEMHkbcQmK"
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v4] thunk: fix of malloc to
 g_new
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Riku Voipio <riku.voipio@iki.fi>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Julia Suvorova <jusual@mail.ru>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aarushi Mehta <mehta.aaru20@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wHed6j1HSAw0QV7eT6VQ6HgJEMHkbcQmK
From: Laurent Vivier <laurent@vivier.eu>
To: Stefan Hajnoczi <stefanha@gmail.com>, Riku Voipio <riku.voipio@iki.fi>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Julia Suvorova <jusual@mail.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <6b3cfcb7-747e-1dc7-6987-1ad9d1fde2a3@vivier.eu>
Subject: Re: [Qemu-trivial] [PATCH v4] thunk: fix of malloc to g_new
References: <5310bd5d152fa36c1828a7cbd19fc893739d1609.camel@gmail.com>
 <20190306095615.GG22159@stefanha-x1.localdomain>
In-Reply-To: <20190306095615.GG22159@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/03/2019 10:56, Stefan Hajnoczi wrote:
> On Sat, Mar 02, 2019 at 01:22:29AM +0530, Aarushi Mehta wrote:
>> From 3c1cba63dc5070ab559a126e206557f27fbaea59 Mon Sep 17 00:00:00 2001=

>> From: Aarushi Mehta <mehta.aaru20@gmail.com>
>> Date: Sat, 2 Mar 2019 01:11:42 +0530
>> Subject: [PATCH v4] thunk: fix of malloc to g_new
>>
>> Note that since thunking occurs throughout the lifetime of the QEMU
>> instance, there is no matching 'free' to correct.
>>
>> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>  thunk.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Riku: Will you send a pull request?  Otherwise Peter might be willing t=
o
> merge this patch through his tree.
>=20

I can take this through the trivial patches branch.

Thanks,
Laurent



--wHed6j1HSAw0QV7eT6VQ6HgJEMHkbcQmK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEzS913cjjpNwuT1Fz8ww4vT8vvjwFAlx/mocACgkQ8ww4vT8v
vjyTJQ//dwFqbfExOnl4MfM9/d2he+DPRMcoGngG996z0VYYRue+6M85zLGHuKIp
mmHxSvwqceASMTvSuapXFw7NgYSEKQBAzHJYDpfma8/BBpVeFkYWgu6Rv6v6jzYP
4hIcLqLpA72HjM+8aNgx4ea2GkAv2LDVH0DmbiP1w68vZEVY4aMVGTviqw7HjXlh
xkc9Z10spaR02lK59sAA/bcy1E6lFSvg6NzdJnv+Ww/F/Ac3BUaMmUxhQGARVOXo
C5oezTWmVSl+NLm3QO2kbkfycy1B5etOBcqUsa2q8joaBLfeHdY9C/Smcvefgtle
2KjHNf0AaeJCsQ7B+YuN9wBY/bXLPLvc2AgqjJtRR5bOh1+zaW71TIu4M8HyTwlo
NWdwgXt0ctpI7GKAZe4RPmvFvf6spbGnl1AvFCs092wS8Q2B5Q8OtRW32ZqGKopi
d3cgsWstZzvHmTtfJXDM9EWh4rICEALW9ZaPk1J4l5HzOvYDLMe5hH9Ru9PFzSe/
AsUB7GmlRT3bgirn95bQES6+P2IOAAfZ1KlUkQ/3129zpISIseMhInlycy17qWFG
PHFmuZWedCg4FH1hqODSKqESGA1ba807HHyHft7h4vQ00OZaKtON0rRQ5tjN/ilF
jStcFSmnrpGi4VrSEPM22XnMXaLTOEQT69eMniyiKflzD7RmUB8=
=tX4C
-----END PGP SIGNATURE-----

--wHed6j1HSAw0QV7eT6VQ6HgJEMHkbcQmK--
