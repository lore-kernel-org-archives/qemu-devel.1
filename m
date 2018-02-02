Received: from eggs.gnu.org ([208.118.235.92]:54777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdq5-0004zt-9T
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:05:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdpz-0007jX-TF
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:05:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:24501)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehdpz-0007ip-5S
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:05:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6A738C036743
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 16:05:14 +0000 (UTC)
References: <20180202111022.19269-1-kraxel@redhat.com>
	<20180202111022.19269-11-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <57290fb5-dbc7-5dff-7686-6edaba480de9@redhat.com>
Date: Fri, 2 Feb 2018 10:05:00 -0600
MIME-Version: 1.0
In-Reply-To: <20180202111022.19269-11-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="d6skXPoXuMzrmVf6FLVH3xLseNSdBNq9L"
Subject: Re: [Qemu-devel] [PATCH v3 10/12] vl: drop full_screen variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d6skXPoXuMzrmVf6FLVH3xLseNSdBNq9L
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <57290fb5-dbc7-5dff-7686-6edaba480de9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 10/12] vl: drop full_screen variable
References: <20180202111022.19269-1-kraxel@redhat.com>
 <20180202111022.19269-11-kraxel@redhat.com>
In-Reply-To: <20180202111022.19269-11-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 05:10 AM, Gerd Hoffmann wrote:
> Not used any more, delete it.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  vl.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--d6skXPoXuMzrmVf6FLVH3xLseNSdBNq9L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0jCwACgkQp6FrSiUn
Q2q0ywf8DDKw6r4hJnbSub8PpECd6jiuAWQ5Zq/6jaiDpzYo3j1pDOHdMwaWmu20
PijWcdOux+06g+0BicBjgOliF25r1cvbPH5jxAkdbJvFXbqhOfEEmn3nYClluyMk
MBMF0OQ42FjUSqjLAYfN0UdnA9rHd8wTR+MA2cZRhC8QdD7X0/p0+SI2HH6M6rZA
5y+KvyMvSv3BneEgWG53G3BL28ss6ej4Xs151gul24MZmP18YstNdM+9xZ4mFtJC
M8EW5PLD23jkVABobYfHllx9V6oic78OrWx4B1NDwUEoqkwwpZY89xvEoaD44GJa
uQeKbJBVybgl/AA9Zu2RA1xtB5tObQ==
=PN7f
-----END PGP SIGNATURE-----

--d6skXPoXuMzrmVf6FLVH3xLseNSdBNq9L--
