Received: from eggs.gnu.org ([2001:4830:134:3::10]:34471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daKL0-0003CE-JE
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daKKz-0006LP-L0
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:18:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1daKKz-0006L0-BC
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:18:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F262C04B92A
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 11:18:44 +0000 (UTC)
References: <20170726111049.18030-1-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <655b8383-e59d-644c-60f4-a2ac8d5b87b5@redhat.com>
Date: Wed, 26 Jul 2017 06:18:42 -0500
MIME-Version: 1.0
In-Reply-To: <20170726111049.18030-1-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QOQcbPlDMHIc3L6vPD7w1UFxoVTlsaR5q"
Subject: Re: [Qemu-devel] [qemu-web PATCH] move bug reporting instructions
 from wiki to www
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QOQcbPlDMHIc3L6vPD7w1UFxoVTlsaR5q
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com
Message-ID: <655b8383-e59d-644c-60f4-a2ac8d5b87b5@redhat.com>
Subject: Re: [qemu-web PATCH] move bug reporting instructions from wiki to www
References: <20170726111049.18030-1-pbonzini@redhat.com>
In-Reply-To: <20170726111049.18030-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/26/2017 06:10 AM, Paolo Bonzini wrote:
> The bug reporting instructions are pretty static, and it is nicer if bu=
g
> reporters stay within the familiar QEMU web site layout.  Move the page=

> to qemu.org.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  _includes/footer.html      |  2 +-
>  contribute.md              |  2 +-
>  contribute/report-a-bug.md | 19 +++++++++++++++++++
>  3 files changed, 21 insertions(+), 2 deletions(-)
>  create mode 100644 contribute/report-a-bug.md

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--QOQcbPlDMHIc3L6vPD7w1UFxoVTlsaR5q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll4epIACgkQp6FrSiUn
Q2oc7AgAkuKrdn/1/5ShLLXLZkmT0BaKnY7TqQeagPzEmfesUxYqR4fFG2TGABKP
K1NA5TYTsSwQrO41AmSgFiON1WR/hf0c9lZzbKatKwIKnoAQkyxBTKhIfGsLoaVR
jG6gSN7oSItgYNX/T6LuxxTuH1CwvGoLDjDGjgbcTRDtGwRgIxsII7XImHjkUeYD
f7aFzpAhp0oYyf2ii4UFXE4ThRRZ5PDxVIhBOULgoS7xC9zjRxGAr1uO0ZVA3mUF
khx5KlczIdvsUzNFOYNmL3PzjlsC1J/fdIL8xVvEa7awGclhIZiTHsFgzrSEadBC
s2ODVbe7OEDOXWgKRi0i23yUIf2klw==
=qRWB
-----END PGP SIGNATURE-----

--QOQcbPlDMHIc3L6vPD7w1UFxoVTlsaR5q--
