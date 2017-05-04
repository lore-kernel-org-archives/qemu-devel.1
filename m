Received: from eggs.gnu.org ([2001:4830:134:3::10]:49298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6Gta-0006T0-1H
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6GtW-0006Fn-Vd
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:34:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d6GtW-0006FP-Ll
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:34:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 347C7ABB10
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 13:34:09 +0000 (UTC)
References: <20170504125432.21653-1-marcandre.lureau@redhat.com>
	<20170504125432.21653-2-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3b9591e7-bc18-4c5e-ded5-9b8fefa77080@redhat.com>
Date: Thu, 4 May 2017 08:34:00 -0500
MIME-Version: 1.0
In-Reply-To: <20170504125432.21653-2-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7wbUgKFudgAfTiqnNIvTw266QnKMlkLLe"
Subject: Re: [Qemu-devel] [PATCH 1/4] qmp-shell: add -N option to skip
 negotiate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7wbUgKFudgAfTiqnNIvTw266QnKMlkLLe
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Message-ID: <3b9591e7-bc18-4c5e-ded5-9b8fefa77080@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] qmp-shell: add -N option to skip
 negotiate
References: <20170504125432.21653-1-marcandre.lureau@redhat.com>
 <20170504125432.21653-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170504125432.21653-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/04/2017 07:54 AM, Marc-Andr=C3=A9 Lureau wrote:
> qemu-ga doesn't have negotiate phase.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qmp/qmp-shell | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7wbUgKFudgAfTiqnNIvTw266QnKMlkLLe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCy3IAAoJEKeha0olJ0NqqyUH/33JjwRkTQSVIj2kwghhtSsx
KjVd5i+YEB3HvyLuAL/cpkJFhiCUrNYBC+9fgQZpDTwEtgGt3eoaHVSkG45v67d4
5X5t7mgacboRuIznFpJ9gCpxzjrc+mkY+OFDZHCGcHB92efSyQqHde9OZSk7+QQe
H5BnAa3d09Nr2BxPNVARVXumCoV3qQgJTUdBB0XSAzmywPJsrelLVreOJE6bgo1h
Ha3A/FsJmhBGvlGFz16hv9JlMjBLaVx5a5GOk5FCP+2oJR6y5mQH4peXWoz7JibH
m/Yf0dwa5HeJ5t5xJ6M+TX1bH7Bom0y5WqrPOwLWi6pbd4NDsj74jfl64SjcgL4=
=qTH7
-----END PGP SIGNATURE-----

--7wbUgKFudgAfTiqnNIvTw266QnKMlkLLe--
