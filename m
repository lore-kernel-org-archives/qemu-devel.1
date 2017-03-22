Received: from eggs.gnu.org ([2001:4830:134:3::10]:45058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cqbwI-0001fn-OR
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 04:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cqbwD-0007iZ-Rb
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 04:48:18 -0400
Received: from 17.mo6.mail-out.ovh.net ([46.105.36.150]:50075)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cqbwD-0007iI-LY
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 04:48:13 -0400
Received: from player787.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 73D7ABA2E8
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 09:48:12 +0100 (CET)
Date: Wed, 22 Mar 2017 09:48:05 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170322094805.6acc527e@bahia.lan>
In-Reply-To: <1490130086-22057-1-git-send-email-sstabellini@kernel.org>
References: <1490130086-22057-1-git-send-email-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/B+W8Tz_y4BgWgXD21y5C8Jo";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] add xen-9p-backend to MAINTAINERS under Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Stefano Stabellini <stefano@aporeto.com>, anthony.perard@citrix.com

--Sig_/B+W8Tz_y4BgWgXD21y5C8Jo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Mar 2017 14:01:26 -0700
Stefano Stabellini <sstabellini@kernel.org> wrote:

> Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> CC: groug@kaod.org
> CC: anthony.perard@citrix.com
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

> This patch is meant to be on top of
> http://marc.info/?l=3Dxen-devel&m=3D149003409510264&w=3D2
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index be79f68..bd5218e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -327,6 +327,7 @@ L: xen-devel@lists.xenproject.org
>  S: Supported
>  F: xen-*
>  F: */xen*
> +F: hw/9pfs/xen-9p-backend.c
>  F: hw/char/xen_console.c
>  F: hw/display/xenfb.c
>  F: hw/net/xen_nic.c


--Sig_/B+W8Tz_y4BgWgXD21y5C8Jo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljSOkUACgkQAvw66wEB28JgqQCgktSk+btKeg2ErqW+M+9drNuq
FWUAn0m5NiSZDLuygTNN/V+X7EfhwpSL
=HesJ
-----END PGP SIGNATURE-----

--Sig_/B+W8Tz_y4BgWgXD21y5C8Jo--
