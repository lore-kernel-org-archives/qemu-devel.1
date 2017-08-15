Received: from eggs.gnu.org ([2001:4830:134:3::10]:59747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dhaRs-0000mW-8k
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dhaRn-0002O6-6l
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:55:52 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:36817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dhaRm-0002M7-VV
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:55:47 -0400
Received: by mail-wm0-x235.google.com with SMTP id t201so7188252wmt.1
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 04:55:46 -0700 (PDT)
Date: Tue, 15 Aug 2017 12:55:43 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170815115543.GC22606@stefanha-x1.localdomain>
References: <20170815085732.9794-1-ldoktor@redhat.com>
	<20170815085732.9794-2-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Content-Disposition: inline
In-Reply-To: <20170815085732.9794-2-ldoktor@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 01/10] qemu.py: Pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, ehabkost@redhat.com, apahim@redhat.com, armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com, f4bug@amsat.org


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2017 at 10:57:23AM +0200, Luk=C3=A1=C5=A1 Doktor wrote:
> No actual code changes, just several pylint/style fixes and docstring
> clarifications.
>=20
> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> ---
>  scripts/qemu.py | 76 ++++++++++++++++++++++++++++++++++++++++-----------=
------
>  1 file changed, 53 insertions(+), 23 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZkuE/AAoJEJykq7OBq3PI5B0IAMDItfCKFwjhBfMPviKu5qPP
W5klEP7h1PX86l+1EEGUmkf36F1Mq6+noa/UMHvMqjqAygimk1Ty6qNsELI313UH
87BF0yBLyOdqs9TFU9UX9wUxuYlHLsf8/VelDSWozTfSlCgHrNcRnwV/KUoDyfo4
RA4Te06KISFlFhOyhW2EQyxtkyycZzGZu/1Bqxz6Uhc5mJrr6WY8ruFAxWkcZH0+
VbA4QOgKvuq9w/HkTFWpIEPsVQk7fd94EuL7TczGFg03nPrenYsDEnszPpna1e/c
/yeYg+Dh5SkL1ULjXro8uszzHq/YfVpKgk2jZ7hDp3fg4/M7+ptSMaPsFZ7wyXE=
=yUgK
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
