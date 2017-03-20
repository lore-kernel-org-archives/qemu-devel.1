Received: from eggs.gnu.org ([2001:4830:134:3::10]:36646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cq3Np-0006vN-Le
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 15:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cq3No-0000Fo-UV
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 15:54:25 -0400
References: <1490014548-15083-1-git-send-email-armbru@redhat.com>
	<1490014548-15083-3-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9204a8a2-d820-fc66-b65c-c6275e512d85@redhat.com>
Date: Mon, 20 Mar 2017 14:54:16 -0500
MIME-Version: 1.0
In-Reply-To: <1490014548-15083-3-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5fL6xQXETkXtDXb4qgnJSQwN2xXxENVpk"
Subject: Re: [Qemu-devel] [PATCH for-2.9 2/5] keyval: Improve some comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5fL6xQXETkXtDXb4qgnJSQwN2xXxENVpk
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <9204a8a2-d820-fc66-b65c-c6275e512d85@redhat.com>
Subject: Re: [PATCH for-2.9 2/5] keyval: Improve some comments
References: <1490014548-15083-1-git-send-email-armbru@redhat.com>
 <1490014548-15083-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1490014548-15083-3-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/20/2017 07:55 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  util/keyval.c | 47 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 16 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--5fL6xQXETkXtDXb4qgnJSQwN2xXxENVpk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0DNoAAoJEKeha0olJ0NqMRkIAJQumf/ze60Ke4jV33x2SFKH
ElW4YEM/GiTGJtrI1jOyR047MwCLaE3HCg9CjkBNyiI1/QyHDD1d9wCMLzskIPWl
ZFodL0FVgAK9HwFMO6+3PiPJ/ow1+h2nBGpNT1l4FYXT2jJOOVZsQAu7Aa46tCK3
sZnfjgQaKuOLkNUNM2yqkwnHJmrmjyFya/XZx0hthfRbeDUscOCvq5YeXSgj0Kab
UDnttWP/4kOyUUoP2ofpgkakBjPOjZBAvfOLIixhsTyk4C28jkemI608u/cMeW4r
G8Dsyg0BLXLcQ3+dlDufhmvBoj2BjZFWCKE6az4YzgmAkh9XgHWh+mgpc35kSX4=
=rwOy
-----END PGP SIGNATURE-----

--5fL6xQXETkXtDXb4qgnJSQwN2xXxENVpk--
