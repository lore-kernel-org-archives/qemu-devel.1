Received: from eggs.gnu.org ([2001:4830:134:3::10]:54801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRPNr-0006JF-8G
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRPNn-0000th-6N
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cRPNm-0000tW-Rg
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:31 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 00571C057FA6
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 20:20:31 +0000 (UTC)
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
	<20170111172956.11255-12-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <635bf9a5-0899-de95-ea53-3810ea7f2c01@redhat.com>
Date: Wed, 11 Jan 2017 14:20:27 -0600
MIME-Version: 1.0
In-Reply-To: <20170111172956.11255-12-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="v0WK7Cdf6KdEVjoAI0JWCbUDcLvPdBSpp"
Subject: Re: [Qemu-devel] [PATCH 11/40] char-win-stdio: convert to finalize
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
--v0WK7Cdf6KdEVjoAI0JWCbUDcLvPdBSpp
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <635bf9a5-0899-de95-ea53-3810ea7f2c01@redhat.com>
Subject: Re: [PATCH 11/40] char-win-stdio: convert to finalize
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
 <20170111172956.11255-12-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-12-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 11:29 AM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qemu-char.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Patches 3-11: Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--v0WK7Cdf6KdEVjoAI0JWCbUDcLvPdBSpp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdpOLAAoJEKeha0olJ0NqTCMH/3ymuXoKvolwrimVtW2/4jk6
a0bbOe8R21+MfxWbLDVibpXmGNI/AIlPECevBO45U+Ltmc43xs0BlNgBCkuMFkBi
pAMSGCMDQAahQZRSRUM83khMpdOjSldNsZQbChygdXpiBitnwQkvgZNXNzp4qVRo
9nWJe3/jj60UHgN6KT7sWoZQJwf3THFyxaZjzwPa7YrtWQH2SfoSzvhIPAyPhFBg
STSGzAhUH3dN59sRPTcmk/UFvL57njOyFqh23QxRild6IhorYSVOZ23wO2Ws6OZT
Wa8kAz+U+pmswx/Hha++AtjZwVvzBHYB9+2Jj5cGMqxIPeXl3P53CfE0C5Z+hT4=
=p+pD
-----END PGP SIGNATURE-----

--v0WK7Cdf6KdEVjoAI0JWCbUDcLvPdBSpp--
