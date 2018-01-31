Received: from eggs.gnu.org ([2001:4830:134:3::10]:56826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egtzc-0000oQ-CO
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:08:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egtzS-0002mQ-PQ
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:08:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egtzS-0002m1-Iq
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:07:58 -0500
References: <20180131144846.31697-1-armbru@redhat.com>
	<20180131144846.31697-4-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c2c9faa7-6697-4bb3-7d0b-969a74a3d88a@redhat.com>
Date: Wed, 31 Jan 2018 09:07:55 -0600
MIME-Version: 1.0
In-Reply-To: <20180131144846.31697-4-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2nntnCjD7mOStrr6t8yq90Z4U9AeRvqyH"
Subject: Re: [Qemu-devel] [PATCH v2 03/19] Drop superfluous includes of
 qapi-types.h and test-qapi-types.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2nntnCjD7mOStrr6t8yq90Z4U9AeRvqyH
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, f4bug@amsat.org
Message-ID: <c2c9faa7-6697-4bb3-7d0b-969a74a3d88a@redhat.com>
Subject: Re: [PATCH v2 03/19] Drop superfluous includes of qapi-types.h and
 test-qapi-types.h
References: <20180131144846.31697-1-armbru@redhat.com>
 <20180131144846.31697-4-armbru@redhat.com>
In-Reply-To: <20180131144846.31697-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2018 08:48 AM, Markus Armbruster wrote:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

>  35 files changed, 36 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2nntnCjD7mOStrr6t8yq90Z4U9AeRvqyH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpx28sACgkQp6FrSiUn
Q2qxWwf+Nz9qTgKZaAdb2htq35WMMWG7Q0y21LeJGYj6+LMsAFElqX+NAr/m3rsy
7K54xzmueH0AtNhRv4gMa+SGXwTtsBIyKTrMARss23r2Te4D9dahhAU0/04q0pvS
+6a1I9JXtLD89NUyj6PqWgDvuYvS1ITWhXWFhsoWtqjQruazGxDn3gytShKqJy5Y
ao1M/6clpWPKpaToBdWwwBEcUHFC0cmjVKrIAN0BLqfhic3iAG/wqFqZPzlGaoLN
Ys9+PfvDLHKecWpfTU+dkq3xt5N+ZAVXfuZN6EDDX7yyNwdku5Kn1Usz3+eR4BuE
UlIQUZkW+Ut7FYI8Y31MNFqfIjfe4w==
=FeN0
-----END PGP SIGNATURE-----

--2nntnCjD7mOStrr6t8yq90Z4U9AeRvqyH--
