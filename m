Received: from eggs.gnu.org ([2001:4830:134:3::10]:59637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfoB4-0000yt-Ki
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfoB0-0006BL-BU
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:11:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfoB0-0006Av-5I
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:11:06 -0400
References: <1502359588-29451-1-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <09d21caa-e28b-4e5f-2447-2d7c6f4f1e0d@redhat.com>
Date: Thu, 10 Aug 2017 09:11:03 -0500
MIME-Version: 1.0
In-Reply-To: <1502359588-29451-1-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TR1uUwhVrsKhUEeadmXrif1ks2cl23jIn"
Subject: Re: [Qemu-devel] [PATCH] error: Improve documentation of
 error_append_hint()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pasic@linux.vnet.ibm.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TR1uUwhVrsKhUEeadmXrif1ks2cl23jIn
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pasic@linux.vnet.ibm.com, mdroth@linux.vnet.ibm.com
Message-ID: <09d21caa-e28b-4e5f-2447-2d7c6f4f1e0d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] error: Improve documentation of
 error_append_hint()
References: <1502359588-29451-1-git-send-email-armbru@redhat.com>
In-Reply-To: <1502359588-29451-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/10/2017 05:06 AM, Markus Armbruster wrote:
> Suggested-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/error.h | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TR1uUwhVrsKhUEeadmXrif1ks2cl23jIn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmMaXcACgkQp6FrSiUn
Q2qfrggAhuvcnChnbIJlZ0lC1cxLdCALU5m2Ei/sK4m19CnG3925dU76va+TqjSO
c+TUO4sUbR9rEvHUS7rXX20yFOaXDLvQBGzcZPMs1yVCxjUlyYnaLYKoPSThl/I+
Tl+svMVA8rRGDq7NTtWBuwDDvTZzwkEhm6lozoyM6H1bZ5cvLu0xzw+SAbRxmtEx
AvHm8fLAQvqMCS24AzxaM7XPNv+O4rnP1MhN8ktObyGLpevsDskqvrIxc7nEpTK9
mSlfkUSy8r7oFSJdHVnBeWDQYalCFNUKk+jp1uHhN1DE+2r8Lv2T6zfC5G7jp2Ko
iV3J8tAa9ufFjqQbebWoMe4agRDIyA==
=DTw4
-----END PGP SIGNATURE-----

--TR1uUwhVrsKhUEeadmXrif1ks2cl23jIn--
