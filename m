Received: from eggs.gnu.org ([2001:4830:134:3::10]:40621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cRg97-0003S5-PE
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:14:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cRg93-0008EV-RC
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:14:29 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cRg93-0008E2-Kj
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:14:25 -0500
Received: by mail-wm0-x241.google.com with SMTP id r144so3997705wme.0
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 06:14:25 -0800 (PST)
Date: Thu, 12 Jan 2017 14:14:17 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170112141417.GB14042@stefanha-x1.localdomain>
References: <CAE519-k8poR3Qi99rg__9hYWS2ACw8a=3S+cx4s1xJW6QDFSjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <CAE519-k8poR3Qi99rg__9hYWS2ACw8a=3S+cx4s1xJW6QDFSjA@mail.gmail.com>
Subject: Re: [Qemu-devel] Question about io mode & cache mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: morgenlette madeBy <sgh8183@gmail.com>
Cc: qemu-devel@nongnu.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2017 at 01:25:35PM +0900, morgenlette madeBy wrote:
> I sent mail for question about io mode and cache mode.
>=20
> When I set VM to I/O mode =3D native and cache mode =3D none,
>=20
> Vm cannot boot and vm is turn off automatically.
>=20
> Why cannot VM boot?

You didn't provide enough information to give an answer.

What is your QEMU command-line?

What do you mean by "vm is turn off automatically"?

Stefan

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYd485AAoJEJykq7OBq3PIsJIH/1kogApYzKDal7Q5K0a2Y3Lz
62vUBOulbB/C/SsSwkhiAwy23rx+wku5IimDIdduvBpyQbnVn+Pxbrk+XTluIVyB
+SLHZ5rSgQNgY9K7kwWxlMT31Np8LJp2wGzGbOtGEZ5VFl2G4lGh4wWJen2qLn/i
pCArvS6wyHEPYulS3xsxR6sFLRUDB3pKChcUN66dh1tt0KAULzmLO8VB+z3WO96j
pp56JOUwTiyyg9m/8rLFFeA/3Gb3nDE75yZznmE7cJFTJKybO9iqJyQnXqBe9E4/
XMaDBz62sPL/5EHM/J1s+jD3OhaWLbsJdqeXs+bJj3oRa3bIhMQc5lvTU6x1vac=
=lpuI
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
