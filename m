Received: from eggs.gnu.org ([2001:4830:134:3::10]:49907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cROzt-000747-Jk
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:55:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cROzq-0005Eg-HR
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:55:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cROzq-0005EV-AX
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:55:46 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6833781247
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 19:55:46 +0000 (UTC)
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
	<20170111172956.11255-3-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2b469f75-87d6-3177-73db-6a6b1eaa7f38@redhat.com>
Date: Wed, 11 Jan 2017 13:55:44 -0600
MIME-Version: 1.0
In-Reply-To: <20170111172956.11255-3-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MUVxSMvq9FScwqlR2rcafM4XIC5fDwMbM"
Subject: Re: [Qemu-devel] [PATCH 02/40] baum: convert to finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MUVxSMvq9FScwqlR2rcafM4XIC5fDwMbM
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <2b469f75-87d6-3177-73db-6a6b1eaa7f38@redhat.com>
Subject: Re: [PATCH 02/40] baum: convert to finalize
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
 <20170111172956.11255-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 11:29 AM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  backends/baum.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

I might have squashed multiple conversions to finalize in one patch, but
since you've already done the work of separating them, I don't mind them
that way.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--MUVxSMvq9FScwqlR2rcafM4XIC5fDwMbM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdo3AAAoJEKeha0olJ0Nq46IH/jdLKnpwg8G+GRHhA4zCXDMz
wMNzHZSAIa7X2+YPyC5RkBTC4ME8+aEmAk0PTZS6JHoIC9PMLsCEFJivUjFhuR3z
Fc5lp+w9Euis9dtHw0nRfIE0EYMmugcZbehID4BsME07b7OTgxJRCjCfxU6CK4tr
BP7Jw9P0wq6BdzD+ejjX5D3M6clVS5OGXupoY7ZHtF51nxzLwf/p4gu1UfeWsacQ
pVs0e9aowdE6BoY1GHNHaXW1Y3LY1RkcwhV+A1JEZnuHPyL2AhoHkha9V6b+jj5t
FN/2ZupqJM8XSbm5RHKLy/JpM15QSPmBMuiUNdjKyfvMasYQ2C7jPwhWjajdsh4=
=q7n7
-----END PGP SIGNATURE-----

--MUVxSMvq9FScwqlR2rcafM4XIC5fDwMbM--
