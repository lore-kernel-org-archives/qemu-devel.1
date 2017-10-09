Received: from eggs.gnu.org ([2001:4830:134:3::10]:59113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1cHQ-0001ST-Gu
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1cHN-0001Rc-Ri
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:55:52 -0400
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-22-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <af4cb715-2015-02c4-98d4-4ec3133dc3e8@redhat.com>
Date: Mon, 9 Oct 2017 12:55:41 -0500
MIME-Version: 1.0
In-Reply-To: <20171006235023.11952-22-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="C878SmiSl60faa98soGEB6PSihBrgrqcH"
Subject: Re: [Qemu-devel] [PATCH 21/88] NBD: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C878SmiSl60faa98soGEB6PSihBrgrqcH
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu trival <qemu-trivial@nongnu.org>
Message-ID: <af4cb715-2015-02c4-98d4-4ec3133dc3e8@redhat.com>
Subject: Re: [PATCH 21/88] NBD: use g_new() family of functions
References: <20171006235023.11952-1-f4bug@amsat.org>
 <20171006235023.11952-22-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-22-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/06/2017 06:49 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  nbd/server.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

I'm fine queueing this one through my NBD tree, if it doesn't go in as
part of a larger series.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--C878SmiSl60faa98soGEB6PSihBrgrqcH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnbuB0ACgkQp6FrSiUn
Q2qmOgf9EYc0sA3DSpWR09mUmZeF/X/0YK1Pk2hOuWYtq8eSgzoRz88IHJic8Uf7
p7VU9VG7wzH6oTpfK1kHQvZQABdUkbo2jyKduiuxwF2q5aD1oeq0mVsg1eGT78OI
ytVQU3CKG8t/BYbpSJ5ZqmIJX/TlRiBjX0lVni0vVRAtTQihusy0cY8F2tqiu0d4
ea/oO2wSoyWiaDtZbcpt0O+k68abN5y40ZiEIX3ycL6O4mDVr28C03Kbn226bWNU
CyL/g0lnAQYAHz6FEdAAdM1ZLJHPEReTrqQ2ECtnQ9oxcm9OIzquZmmEuIihggLy
tStdJqhMB4ymaLHU/eI5BToU3dYNTQ==
=amnp
-----END PGP SIGNATURE-----

--C878SmiSl60faa98soGEB6PSihBrgrqcH--
