Received: from eggs.gnu.org ([2001:4830:134:3::10]:56538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egaCz-0007IU-Lu
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 13:01:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egaCO-0001V4-9J
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 13:00:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egaCN-0001Tu-QM
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 13:00:00 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E0E6F62E8D
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 17:59:58 +0000 (UTC)
References: <20180130102202.28519-1-armbru@redhat.com>
	<20180130102202.28519-16-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <47d51324-6c14-f860-bc03-9932817136e2@redhat.com>
Date: Tue, 30 Jan 2018 11:59:57 -0600
MIME-Version: 1.0
In-Reply-To: <20180130102202.28519-16-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QoB6ihhpti9xbiclEab8NtAEg5Tl2CGEY"
Subject: Re: [Qemu-devel] [PATCH 15/18] Include qapi/qmp/qnull.h exactly
 where needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QoB6ihhpti9xbiclEab8NtAEg5Tl2CGEY
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <47d51324-6c14-f860-bc03-9932817136e2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 15/18] Include qapi/qmp/qnull.h exactly where
 needed
References: <20180130102202.28519-1-armbru@redhat.com>
 <20180130102202.28519-16-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-16-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 04:21 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  target/ppc/translate.c      | 1 -
>  target/ppc/translate_init.c | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--QoB6ihhpti9xbiclEab8NtAEg5Tl2CGEY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwsp0ACgkQp6FrSiUn
Q2pKFQgAouJLD5izodsii7U78R6azvTd9Ek694zdwOWvsPhQ+y2p2VMYJSHfeDE1
WXJAaMVuyKA/taGzNCroxTMgJG2XWZRH+J+zJcdRcUoO3AtuX+MGsNWLKgpBeoIX
q6r/AOiVm583YSo9HKdAzGlCt3yfVKnBMjVDKcPAKBE1Gcam/9dOrEC/6Co+oNwY
lAjrchSlEAMnkqqlNNgcumpUKBTd6EeujNjzg/8wQlpHz9BgH+QF1X/nvEtreHEU
6wTqHVz6KhZk16ig03Pncpb7tNnPWxe21jdaGjVaQKAtjp9qO9WMhwTm5xKtVc0P
1nDVDAGRlYUul+H+LqEcSLn5mR9kCQ==
=/n6v
-----END PGP SIGNATURE-----

--QoB6ihhpti9xbiclEab8NtAEg5Tl2CGEY--
