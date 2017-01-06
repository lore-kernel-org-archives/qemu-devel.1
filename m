Received: from eggs.gnu.org ([2001:4830:134:3::10]:38975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPUS0-0002Su-K2
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:20:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPURv-0005rK-N6
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:20:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPURv-0005rE-Ed
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:20:51 -0500
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
	<1483692945-9866-17-git-send-email-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5b50d949-c998-50cb-6cfd-27d66a74e066@redhat.com>
Date: Fri, 6 Jan 2017 07:20:49 -0600
MIME-Version: 1.0
In-Reply-To: <1483692945-9866-17-git-send-email-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xNLJf9dtA82eGNu8BbP1C42KpirELP4Ff"
Subject: Re: [Qemu-devel] [PATCH 16/17] wctablet: update file comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: avg.tolik@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xNLJf9dtA82eGNu8BbP1C42KpirELP4Ff
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: avg.tolik@gmail.com
Message-ID: <5b50d949-c998-50cb-6cfd-27d66a74e066@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 16/17] wctablet: update file comment
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
 <1483692945-9866-17-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483692945-9866-17-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/06/2017 02:55 AM, Gerd Hoffmann wrote:
> Be more specific which tablet we emulate.
> Add spec link.  Fix copyright.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  backends/wctablet.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/backends/wctablet.c b/backends/wctablet.c
> index 7263671..97f1996 100644
> --- a/backends/wctablet.c
> +++ b/backends/wctablet.c
> @@ -1,7 +1,11 @@
>  /*
> - * QEMU Wacome serial tablet emulation
> + * QEMU Wacom Penpartner serial tablet emulation
>   *
> - * Copyright (c) 2008 Lubomir Rintel
> + * some protocol details:
> + *   http://linuxwacom.sourceforge.net/wiki/index.php/Serial_Protocol_=
IV
> + *
> + * Copyright (c) 2016 Anatoli Huseu1
> + * Copyright (c) 2016 Gerd Hoffmann

What about 2017? Should this be squashed into 1/17?

>   *
>   * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
>   * of this software and associated documentation files (the "Software"=
), to
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--xNLJf9dtA82eGNu8BbP1C42KpirELP4Ff
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYb5mxAAoJEKeha0olJ0NqoCgH/j2ESPxCaIpwrh7rR8iYOcPa
LjFfVyT7ucyWVFAldcqFrkbg+luor0j+6cNi+DosyEoKpDflmIK8UG1vBTTSB9l/
5tQq1nDV4ytyYmsC2Iv4o1UFxD1rKvXM8t5lIWly3Y/SCrdbvuzyDoP2dK5gL2YU
U79W8qdSDSg+jTo8qnyCDdJCva0x9Y3AJTIesDHRun7YftpiMO4rALVvOlVcLNio
pxHLtjUdkCZmrJnJ6EziGv6Hd+bcjjuLnIu25rZNLDdy8WHb4QniIq7H8prWl9tJ
3sgypAQVgq+CIRi+zelCPCMQ4Yfh3n6tth4HkIC4reWDif7na7k9zHt1F22iY6k=
=7EqO
-----END PGP SIGNATURE-----

--xNLJf9dtA82eGNu8BbP1C42KpirELP4Ff--
