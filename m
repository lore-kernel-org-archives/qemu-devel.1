Received: from eggs.gnu.org ([2001:4830:134:3::10]:34101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cj6NJ-0000U2-EW
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:41:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cj6ND-0000FE-DR
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:41:09 -0500
References: <20170301152651.16390-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8f23bbaa-06a5-0392-8017-98d635d2ba48@redhat.com>
Date: Wed, 1 Mar 2017 09:40:37 -0600
MIME-Version: 1.0
In-Reply-To: <20170301152651.16390-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3aDbDSDOSI9NfC2Ne9g5H4wtB76XMf1oK"
Subject: Re: [Qemu-devel] [PATCH] iotests: Update 049 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3aDbDSDOSI9NfC2Ne9g5H4wtB76XMf1oK
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>
Message-ID: <8f23bbaa-06a5-0392-8017-98d635d2ba48@redhat.com>
Subject: Re: [PATCH] iotests: Update 049 output
References: <20170301152651.16390-1-famz@redhat.com>
In-Reply-To: <20170301152651.16390-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/01/2017 09:26 AM, Fam Zheng wrote:
> 75cdcd155 improved the error message, which affects the reference
> output. Let's sync it up.
>=20
> Note that previously '1kilobyte' was treated like '1k', but now it's an=

> error. Looking at the commit in question, this appears to be intended.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/qemu-iotests/049.out | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--3aDbDSDOSI9NfC2Ne9g5H4wtB76XMf1oK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtut1AAoJEKeha0olJ0Nq8KsH/1iYyww4cdK4UdCdRFiopKTo
YAHFUmojmFI5Y4pNYncvv1Xd8MavdTPZi8kotyUyvufoDKMlG75x1CkNBYgf8ARp
8Kr8RmvaCfPGg8vnE5XjAmvN/doxb2ZPo5DrW75vtaRnrBQ9GLfQfxJ4XmRILI3c
7+RLtmGY+N0TRHIomttfZv0QIdsDngkWaw3Zb33Zur5Nh7Jt89zjIZ8tvan2Z+Jf
Qo3+tkmSrmcXi3M1wtsdEJFEljsI0yURGUkBn1TLAKgp65gNz8Z+ZVTdStJim3JT
tdazokk90EunjxNBJfgt1eR8vDPjPSW7tMb8XoP2i3WlBcnLXIf1ZyqOQQLtCoU=
=5if+
-----END PGP SIGNATURE-----

--3aDbDSDOSI9NfC2Ne9g5H4wtB76XMf1oK--
