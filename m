Received: from eggs.gnu.org ([2001:4830:134:3::10]:49453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ega8w-0004Da-CW
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:56:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ega8X-0005LR-1j
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:56:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ega8W-0005KE-I8
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:56:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E6A82822D
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 17:55:59 +0000 (UTC)
References: <20180130102202.28519-1-armbru@redhat.com>
	<20180130102202.28519-13-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9c2f9335-7c19-2c14-c620-35bf52e769b3@redhat.com>
Date: Tue, 30 Jan 2018 11:55:57 -0600
MIME-Version: 1.0
In-Reply-To: <20180130102202.28519-13-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="k9lRyvNyXeC5LrQCEDOECjz0ak8EVGoss"
Subject: Re: [Qemu-devel] [PATCH 12/18] Include qapi/qmp/qstring.h exactly
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
--k9lRyvNyXeC5LrQCEDOECjz0ak8EVGoss
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <9c2f9335-7c19-2c14-c620-35bf52e769b3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 12/18] Include qapi/qmp/qstring.h exactly
 where needed
References: <20180130102202.28519-1-armbru@redhat.com>
 <20180130102202.28519-13-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-13-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 04:21 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--k9lRyvNyXeC5LrQCEDOECjz0ak8EVGoss
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwsa0ACgkQp6FrSiUn
Q2r0Xgf/Zj4/1VKRt7j61oV9f2MnuTHEv3OyQM9x7kNWmIgP0ETDzNKVl4BygFaK
EGWunFU1Fo+fe4cPqzC67otJVuPRwDke0NZ0Gl4XEFz2ccXX5o7Rc/Yq7wZn6ZYG
pEsoX/F5WF+wKuThuEpwcR6yIrzSGRPgDsnHdnNWJ17aAsXaZ5ziOIfIeIFLk342
MUeV7gau1zFYr3DkhYsOblLXHF2jJd5ZvA3rx0EjfSDtpLvc4KL6solCMyEN7acS
4nv6g7XHWZ5JWR9RilsRElNGGLNA4NsbxQQwvto6gX0SrotSjPmA3ZRZSXbrdIMQ
Ze2IW7GxuoYVoyUxBzKbN6n2IrHtZg==
=s4VW
-----END PGP SIGNATURE-----

--k9lRyvNyXeC5LrQCEDOECjz0ak8EVGoss--
