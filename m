Received: from eggs.gnu.org ([2001:4830:134:3::10]:56265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cny2I-0003u2-OA
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cny2E-0003io-QJ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:47:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cny2E-0003iA-Jq
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:47:30 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-47-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a29a5317-3599-c4ee-d48c-85b0f1b40c4b@redhat.com>
Date: Tue, 14 Mar 2017 20:47:28 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-47-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VlnK7hufjcqkBrD9O9VP1m25Ei3VV1EhO"
Subject: Re: [Qemu-devel] [PATCH for-2.9 46/47] qapi: Make pylint a bit
 happier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VlnK7hufjcqkBrD9O9VP1m25Ei3VV1EhO
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <a29a5317-3599-c4ee-d48c-85b0f1b40c4b@redhat.com>
Subject: Re: [PATCH for-2.9 46/47] qapi: Make pylint a bit happier
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-47-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-47-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi-commands.py | 6 +++---
>  scripts/qapi-visit.py    | 1 -
>  scripts/qapi.py          | 8 ++++----
>  3 files changed, 7 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--VlnK7hufjcqkBrD9O9VP1m25Ei3VV1EhO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyJ0wAAoJEKeha0olJ0NqqUEIAIC33TCAbwT4jK+3ZyvD7vcM
D/O4gaGNEKaiFeXBFao7tA5dvLI+bZfUovuDsu8KLXDz7qNOqfPKAPdfYUKImOrn
lBpMxgU5aQLBRY9ui6qsELkSoBI0jcNJHeyflIFYS8tCp4u5MsrW7JUtLzPjqNGZ
ETQhUUScejC8gw3ijTAE10DIpIAwv+h99qbSC0lwQqK7V1ZqLU/O7dugfoqugPuJ
TRV8B4oQ0Wc/vS+BL3d/NhWuBXB8f4MIl9JfqD2/cxH+o8vNLa7+zGf0A1/sNSi1
+wgFRkxnz3kyQ4L6Fu6tPJhtWebKWpcdWs7+prlMFtcTjCVCdpzqqIrXvoe3wiQ=
=EdnH
-----END PGP SIGNATURE-----

--VlnK7hufjcqkBrD9O9VP1m25Ei3VV1EhO--
