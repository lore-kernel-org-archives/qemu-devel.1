Received: from eggs.gnu.org ([2001:4830:134:3::10]:49200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cROwu-0004eQ-87
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:52:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cROwr-0003um-4i
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:52:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cROwq-0003tt-VO
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:52:41 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13D9C369C3
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 19:52:41 +0000 (UTC)
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
	<20170111172956.11255-2-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c25401a0-cae6-e351-5875-b3345f15e61a@redhat.com>
Date: Wed, 11 Jan 2017 13:52:38 -0600
MIME-Version: 1.0
In-Reply-To: <20170111172956.11255-2-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JkOKcfjIXCGAMkqncFP65dsDI2odXtUAh"
Subject: Re: [Qemu-devel] [PATCH 01/40] spice-qemu-char: convert to finalize
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
--JkOKcfjIXCGAMkqncFP65dsDI2odXtUAh
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <c25401a0-cae6-e351-5875-b3345f15e61a@redhat.com>
Subject: Re: [PATCH 01/40] spice-qemu-char: convert to finalize
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
 <20170111172956.11255-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 11:29 AM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  spice-qemu-char.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--JkOKcfjIXCGAMkqncFP65dsDI2odXtUAh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdo0GAAoJEKeha0olJ0Nqc7IIAIgsTUf3C6BWV49ND5WkAQ6h
V0MCGmx5E+aW4GtExMND6qQUGJo2u4g3cmRSwUOgKvgxf3gtU1KNEouBOwhacKPV
k8I13pELIfyQjHSgjV5p655/Vi24EphKmito2j89FF59G84mJOLGfZHVnG/gjAqZ
yEzSK+vDNHc5S5u4gCpCFNAM+QXRxTGO9Z/TjQ3GsH420noRkfVn8RUOL6IknhtP
rW4mb72LGiwyK1n/jpO9bAgoDG91RHsdM4C43NvbGanXti3IGjlEGf9G6NR10eqm
lbLfGGT/h79yRn0p6FeO2HIguA4cvAf7ro5H6l+2vAx1cVFZo/DQbRTJGlmUEaA=
=24Tq
-----END PGP SIGNATURE-----

--JkOKcfjIXCGAMkqncFP65dsDI2odXtUAh--
