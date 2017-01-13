Received: from eggs.gnu.org ([2001:4830:134:3::10]:39137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cS7tv-0003y3-48
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 14:52:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cS7tu-0000o6-4Y
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 14:52:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cS7tt-0000nk-TU
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 14:52:38 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C74703D944
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 19:52:37 +0000 (UTC)
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
	<20170111172956.11255-41-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <790c344d-7918-ba2d-3f70-93c4007a24d6@redhat.com>
Date: Fri, 13 Jan 2017 13:52:35 -0600
MIME-Version: 1.0
In-Reply-To: <20170111172956.11255-41-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s5AvaPsdKBmXjNKfSL8qrVmviK6QanTnO"
Subject: Re: [Qemu-devel] [PATCH 40/40] char: headers clean-up
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
--s5AvaPsdKBmXjNKfSL8qrVmviK6QanTnO
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <790c344d-7918-ba2d-3f70-93c4007a24d6@redhat.com>
Subject: Re: [PATCH 40/40] char: headers clean-up
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
 <20170111172956.11255-41-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-41-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 11:29 AM, Marc-Andr=C3=A9 Lureau wrote:
> Those could probably be squashed with earlier patches, however I
> couldn't easily identify them, test them or check if there are still
> necessary on various platforms.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--s5AvaPsdKBmXjNKfSL8qrVmviK6QanTnO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYeTADAAoJEKeha0olJ0NqTnAIAKsjpWOw0ce5Gg6lRBlST8fi
kvF+l/FBDManr0R+oSs7Vnm3qWrT1TEm1w1LG1Gsul5Gyev4X6fJhuKxi8BWfc5y
xBJ5LbzS+1PIKue12IUZFBlkpZDXr+R+RvGVS9/RM3swtjuPTHLW5dTEmZihUpk9
6+WexnKOynMnUvG9btIWYwJ4O30C9iQOg5O2gvjFdVEF1rvtQBlGzZbW0ExFdt1F
R+NQTPfPkGs0EuXdMYCu7MAtmX8sYpcTrMnBbRA91iJCKN2+jJAuk9w6v7MJ9yMO
9Rt/ab9Tx9qXZ5ixKmZPaD///OA7pcJ15i8PiaBaCrs6iENYC1kUopfJQIC4l7k=
=GDdU
-----END PGP SIGNATURE-----

--s5AvaPsdKBmXjNKfSL8qrVmviK6QanTnO--
