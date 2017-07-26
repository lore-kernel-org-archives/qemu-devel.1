Received: from eggs.gnu.org ([2001:4830:134:3::10]:43932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daOM8-00053T-3j
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daOM4-00082z-Sv
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:36:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1daOM4-00082d-Mg
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:36:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 498D161D18
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 15:36:07 +0000 (UTC)
References: <20170726152918.11995-1-kraxel@redhat.com>
	<20170726152918.11995-5-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a9900e98-aecd-037c-8d53-63f5f973af03@redhat.com>
Date: Wed, 26 Jul 2017 10:36:02 -0500
MIME-Version: 1.0
In-Reply-To: <20170726152918.11995-5-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6MQBB4kiNWvca9sSwHOpW4ij3oHq69PA5"
Subject: Re: [Qemu-devel] [PATCH v2 4/5] ui: add multimedia keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6MQBB4kiNWvca9sSwHOpW4ij3oHq69PA5
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, Markus Armbruster <armbru@redhat.com>
Message-ID: <a9900e98-aecd-037c-8d53-63f5f973af03@redhat.com>
Subject: Re: [PATCH v2 4/5] ui: add multimedia keys
References: <20170726152918.11995-1-kraxel@redhat.com>
 <20170726152918.11995-5-kraxel@redhat.com>
In-Reply-To: <20170726152918.11995-5-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/26/2017 10:29 AM, Gerd Hoffmann wrote:
> Add multimedia keys to QKeyCodes and to the keymaps.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/input-keymap.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  qapi-schema.json  | 28 +++++++++++++++++++++++++++-
>  2 files changed, 71 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6MQBB4kiNWvca9sSwHOpW4ij3oHq69PA5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll4tuIACgkQp6FrSiUn
Q2pAtwgAp9c07/5SIQ9njWeiiUCqWsqUyZYw4xnJOWl1PkqOVD7xpVGlODNG70bb
suT8kgMo/DMeiVgQyBsJOHkXY07eJlhkE+ngKZFsmix6W2QSaetqdVu+tO5rWa5g
YIw7BniTYS1MBZbXEYsk1RYdNKAGbUQ+dcsOjuyNmy/GJJ9nOvD5uy62rrpeXr8s
cZdijV7ixAjJb4MuD74oBgflaNqAT7EoHEpL7J/4LrSndUXfvg8qmBrkd8H0+dcz
tmaR28WjaVllCRlSQH+524Zmb5cbyM/AnBPuqMCAtih9StdmpWkKFE8dbU9UQl/6
fi9RXnBd+hWO2xp9DUnxLXlYjg1xSw==
=4hDz
-----END PGP SIGNATURE-----

--6MQBB4kiNWvca9sSwHOpW4ij3oHq69PA5--
