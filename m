Received: from eggs.gnu.org ([2001:4830:134:3::10]:56111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1di0VW-0003RR-Fj
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 11:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1di0VT-0003ux-CW
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 11:45:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1di0VT-0003sn-3c
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 11:45:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 104C08B137
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 15:45:18 +0000 (UTC)
References: <20170802201900.11890-1-eblake@redhat.com>
	<1325195018.65415326.1501711642675.JavaMail.zimbra@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <981ecc11-57f4-3f6a-3ee6-d829d60edfb1@redhat.com>
Date: Wed, 16 Aug 2017 10:45:10 -0500
MIME-Version: 1.0
In-Reply-To: <1325195018.65415326.1501711642675.JavaMail.zimbra@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MqlEo467m0ImOevsxC97SBdgFqMCqL17O"
Subject: Re: [Qemu-devel] [PATCH] test-qga: Kill broken and dead
 QGA_TEST_SIDE_EFFECTING code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MqlEo467m0ImOevsxC97SBdgFqMCqL17O
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Message-ID: <981ecc11-57f4-3f6a-3ee6-d829d60edfb1@redhat.com>
Subject: Re: [PATCH] test-qga: Kill broken and dead QGA_TEST_SIDE_EFFECTING
 code
References: <20170802201900.11890-1-eblake@redhat.com>
 <1325195018.65415326.1501711642675.JavaMail.zimbra@redhat.com>
In-Reply-To: <1325195018.65415326.1501711642675.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/02/2017 05:07 PM, Marc-Andr=C3=A9 Lureau wrote:

>>
>> Rather than leave this untested time-bomb in place, rip it out.

>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> I think it used to work in a vm (as qemu-ga user), but I don't mind to =
revert it if we need it back:
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Should this be R-b instead of S-o-b?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MqlEo467m0ImOevsxC97SBdgFqMCqL17O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmUaIYACgkQp6FrSiUn
Q2qWGwgAk0HAX8eLOc8qzE2eAQPuJ/ZuHGWOM95wJvqLutCoXqGin7BDObF1kpBa
e5KYnF0s2KDHZUUsxJCGluz8DGv4Luv3qGM+4laIxuuRIyG8heD0BNIYuZnVSmXn
Lx5RMpTObv3ZIRPD11ZaVxRAs+g/IbMZm5apPnW1l6prdMlpgA7ny2V2fBaTkNwN
SngK1hYoPyTYANJPWQ0NjvhsgjacGLSazpzHCX8eLzUlJyfrKaG09MIXqXU0Wi2m
wFyBP6vu3IauoiSUTsl8a48KHRkLHdyGqOQcyKJ62EWgh1o/h+U0IJPs8PhINVVx
G7/SCY+ANtJLCTqMIbduZLGw+3rk7g==
=9Fn8
-----END PGP SIGNATURE-----

--MqlEo467m0ImOevsxC97SBdgFqMCqL17O--
