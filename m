Received: from eggs.gnu.org ([2001:4830:134:3::10]:42496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e8B6Z-0006QQ-AN
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 16:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e8B6W-0006cu-5m
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 16:19:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e8B6V-0006bd-Ss
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 16:19:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D874E356D8
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 20:19:42 +0000 (UTC)
Received: from [10.10.121.108] (ovpn-121-108.rdu2.redhat.com [10.10.121.108])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5562360472
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 20:19:42 +0000 (UTC)
References: <CAFEAcA_0S6T768-60MVkXP1Y0MpmOzTQr8p-N_W1PhbG_n2d-Q@mail.gmail.com>
	<c890a67d-2481-e946-72d5-fe5c22acd837@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <096beb48-61f2-c6f9-513f-a571827a8a93@redhat.com>
Date: Fri, 27 Oct 2017 22:19:35 +0200
MIME-Version: 1.0
In-Reply-To: <c890a67d-2481-e946-72d5-fe5c22acd837@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="a2XDF62gKTSex2Kx2c5OGD1gwfch8S1NF"
Subject: Re: [Qemu-devel] Key signing party at KVM Forum 2017
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a2XDF62gKTSex2Kx2c5OGD1gwfch8S1NF
From: Eric Blake <eblake@redhat.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <096beb48-61f2-c6f9-513f-a571827a8a93@redhat.com>
Subject: Re: [Qemu-devel] Key signing party at KVM Forum 2017
References: <CAFEAcA_0S6T768-60MVkXP1Y0MpmOzTQr8p-N_W1PhbG_n2d-Q@mail.gmail.com>
 <c890a67d-2481-e946-72d5-fe5c22acd837@redhat.com>
In-Reply-To: <c890a67d-2481-e946-72d5-fe5c22acd837@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/27/2017 09:36 PM, Eric Blake wrote:

> If you want more help running pius for signing and sending the signed
> key to a particular recipient, see a previous mail of mine on the topic=
:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2013-11/msg01477.html

Unfortunately, on Fedora 26, the current versions of pius and gpg have
an incompatibility that resulted in failure when I tried to use it, so
you may want to wait for the resolution of
https://bugzilla.redhat.com/show_bug.cgi?id=3D1507152 before trying...

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--a2XDF62gKTSex2Kx2c5OGD1gwfch8S1NF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnzlNcACgkQp6FrSiUn
Q2qK/Qf/ZYWmaOqjS07mxKgemo9NSnoEN+/NcfsJN3UUGoVtXczfU69ZertFZmWO
08VHxC2EU974Bo98lLuDc/Fgr1grsSW6YiAFcDz6iJN1zoRcgUkhcHinMDbpUYeS
/PFTiJyd09236jZ3axYmXk68Jx5RjV6ruszPyOse+7ExKD2pLZEkX9zMmf9TUHHp
iBaJiq0E5vngCg53zOTlzkJSSjfEzCKX4m7XsqrSZPGT0N5DS1/oS2At+odi9v2b
0GSGhHNlnFt1JAOq0AmPmLmTz659ZUZu9dEbSZt6MSmZ6Z/eHd/WHwWW+Nf1qEMh
YSGCHlHkTQ6WdH2zIOSkGCQiz4ZnhQ==
=pFZz
-----END PGP SIGNATURE-----

--a2XDF62gKTSex2Kx2c5OGD1gwfch8S1NF--
