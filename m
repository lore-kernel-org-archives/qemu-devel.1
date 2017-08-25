Received: from eggs.gnu.org ([2001:4830:134:3::10]:57562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlGdb-0007LL-LH
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlGdZ-0002WN-Pf
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:35:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37113)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dlGdZ-0002Vd-GN
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:35:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83B50C058EBF
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 15:35:08 +0000 (UTC)
References: <20170825105913.4060-1-marcandre.lureau@redhat.com>
	<20170825105913.4060-14-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6413d22b-fe58-0440-9550-a501554d0e7a@redhat.com>
Date: Fri, 25 Aug 2017 10:35:02 -0500
MIME-Version: 1.0
In-Reply-To: <20170825105913.4060-14-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="noX4rrMKpPI2gLscEDTwFpVolhiScRavm"
Subject: Re: [Qemu-devel] [PATCH v2 13/14] qlit: add qobject_form_qlit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--noX4rrMKpPI2gLscEDTwFpVolhiScRavm
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com
Message-ID: <6413d22b-fe58-0440-9550-a501554d0e7a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 13/14] qlit: add qobject_form_qlit()
References: <20170825105913.4060-1-marcandre.lureau@redhat.com>
 <20170825105913.4060-14-marcandre.lureau@redhat.com>
In-Reply-To: <20170825105913.4060-14-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/25/2017 05:59 AM, Marc-Andr=C3=A9 Lureau wrote:

s/form/from/ in the subject

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qapi/qmp/qlit.h |  2 ++
>  qobject/qlit.c          | 37 +++++++++++++++++++++++++++++++++++++
>  tests/check-qlit.c      | 26 ++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--noX4rrMKpPI2gLscEDTwFpVolhiScRavm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmgQ6YACgkQp6FrSiUn
Q2rE6AgAl8ezAFot+PuwYyr+FPyQW0OsnE4zDoiBfvjXdKUP7bBhn+Ne5og6UeYd
3nlOPm1yH/n0TAz7ec53alUTIu2bcXxb2XuDAIr9awkiPylkqIPWdnZN/zWjoKFj
mcmW+4Q7PciNQ9TNfqlwh13dqfw5338eVWDoZ+KnMkz+bKdoivYjO/6yQs0R58nJ
VMXP8V+6HG5FIIhD2MNyGhI2wVrDoiG8S68395PfUqFkm+Y79Gze3pUX8ZBd8tk0
mNlrTQUso5cn7HJOiN8pVc5N8U826ybQ2Yo5qD/G9ULurW3oiDXZKldUCAi9BjOn
miA6dJLAgfTbXvmovl8l6FXo/dTppQ==
=gI13
-----END PGP SIGNATURE-----

--noX4rrMKpPI2gLscEDTwFpVolhiScRavm--
