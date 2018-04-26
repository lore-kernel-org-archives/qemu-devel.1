Received: from eggs.gnu.org ([2001:4830:134:3::10]:42622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBmc4-0000rZ-Ur
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 15:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBmc1-00051d-Qk
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 15:31:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49104 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBmc1-00050e-L0
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 15:31:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 437DA400786D
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 19:31:25 +0000 (UTC)
References: <20180426183404.3756-1-lersek@redhat.com>
	<20180426183404.3756-4-lersek@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <acbbf6d6-9cce-f02c-bfa4-7ded2abe3e72@redhat.com>
Date: Thu, 26 Apr 2018 14:31:24 -0500
MIME-Version: 1.0
In-Reply-To: <20180426183404.3756-4-lersek@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UpCKPvVpq5Xj2Ut0aiiOhU6PTNLh0lWH3"
Subject: Re: [Qemu-devel] [PATCH v2 3/4] qapi: change the type of
 TargetInfo.arch from string to enum SysEmuTarget
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UpCKPvVpq5Xj2Ut0aiiOhU6PTNLh0lWH3
From: Eric Blake <eblake@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <acbbf6d6-9cce-f02c-bfa4-7ded2abe3e72@redhat.com>
Subject: Re: [PATCH v2 3/4] qapi: change the type of TargetInfo.arch from
 string to enum SysEmuTarget
References: <20180426183404.3756-1-lersek@redhat.com>
 <20180426183404.3756-4-lersek@redhat.com>
In-Reply-To: <20180426183404.3756-4-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2018 01:34 PM, Laszlo Ersek wrote:
> Now that we have @SysEmuTarget, it makes sense to restrict
> @TargetInfo.@arch to valid sysemu targets at the schema level.
>=20
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UpCKPvVpq5Xj2Ut0aiiOhU6PTNLh0lWH3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlriKQwACgkQp6FrSiUn
Q2qWZQf+OwbqxwNt+bLEiYGNjCbQ9U+cRbyrAXHQeLgrP1S9IE9eBu9qaKhEa09r
ZDd5ChSu2Tnj+v3frZUsTZk2w8LDAF/7ZuKLE3uHrW4lVMyrtoZ/zc7kJpO7RD3d
7XWgYP2I9W8pBLUlTvwQ9n0CBz+1MjEAo2qQUWeeH+fiocg1MdvghsvtzkPWT1og
QnO70NNS8NnKVxVhskvITLrjEoinXng50vcVl8HtF9rmMHbMhMM4Sz//yYgdtBlz
gw/d+vEcb3W6ORVaHzE5nMdQS4IzteANm6dyz2PECdyP620G8oXBy+32wCyzuZoU
y1JqRblsSy3QA3j6sUdv6k/Fn+nqoQ==
=JY5o
-----END PGP SIGNATURE-----

--UpCKPvVpq5Xj2Ut0aiiOhU6PTNLh0lWH3--
