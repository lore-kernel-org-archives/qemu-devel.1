Received: from eggs.gnu.org ([2001:4830:134:3::10]:56862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRoa0-0005l1-Cd
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:14:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRoZz-0006cd-DX
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:14:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cRoZy-0006W7-TW
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:14:47 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 286F56A6C3
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 23:14:47 +0000 (UTC)
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
	<20170111172956.11255-27-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7cd4ece4-523b-30d3-f0a9-e9a5b3d8b009@redhat.com>
Date: Thu, 12 Jan 2017 17:14:45 -0600
MIME-Version: 1.0
In-Reply-To: <20170111172956.11255-27-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xSAAh0wU1kNBNe2tPgo3H8OH7LRVqC5JF"
Subject: Re: [Qemu-devel] [PATCH 26/40] char: remove unused READ_RETRIES
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
--xSAAh0wU1kNBNe2tPgo3H8OH7LRVqC5JF
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <7cd4ece4-523b-30d3-f0a9-e9a5b3d8b009@redhat.com>
Subject: Re: [PATCH 26/40] char: remove unused READ_RETRIES
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
 <20170111172956.11255-27-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-27-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 11:29 AM, Marc-Andr=C3=A9 Lureau wrote:
> Curiously unused since its introduction in commit 7b0bfdf52d69.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--xSAAh0wU1kNBNe2tPgo3H8OH7LRVqC5JF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYeA3lAAoJEKeha0olJ0NqO7UIAKPCTjSPyo5F7GPq1ofeWv8h
X0LflGVFNzJ1GLtrNVYaFximnoMHQ0YjAHbuAKJM5KIVk0LVxaijSJeu7SVDgfNC
bUMC26jH5h5FvePxuYvYwLMU/3xvkzRBx2J5BHD9eIcpvXxmJys/lqBl1lZjpsJY
lm+KFQF86vkiGRUoDu+o+4ZPKCQfIRXG9LXjwJW6NYuE0LrzdbrXRDzwqvtI9x1d
dZo+VzJWVxCXzEXDcWUJQlzHnpY9SGbk5ZXOCO0KJv1JEUg2Re6N7KDWjOpEXNvO
cm7FnryRHofYSZh/JembviBLZmEBc2KRxGKHzy27MwYWA5VsGj3F7BAdvAFy+no=
=c2us
-----END PGP SIGNATURE-----

--xSAAh0wU1kNBNe2tPgo3H8OH7LRVqC5JF--
