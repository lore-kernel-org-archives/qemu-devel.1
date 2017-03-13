Received: from eggs.gnu.org ([2001:4830:134:3::10]:53289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnYHn-0006q5-Bh
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 18:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnYHk-0007sB-6I
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 18:17:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnYHk-0007rn-07
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 18:17:48 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-5-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <697d9842-af9c-9a0e-5a68-1f8a40aaed47@redhat.com>
Date: Mon, 13 Mar 2017 17:17:45 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-5-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HktGQ6Bu83NAcj9PhGd4ueLwrr7qE9H4F"
Subject: Re: [Qemu-devel] [PATCH for-2.9 04/47] docs/qapi-code-gen.txt: Drop
 confusing reference to 'gen'
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
--HktGQ6Bu83NAcj9PhGd4ueLwrr7qE9H4F
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <697d9842-af9c-9a0e-5a68-1f8a40aaed47@redhat.com>
Subject: Re: [PATCH for-2.9 04/47] docs/qapi-code-gen.txt: Drop confusing
 reference to 'gen'
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-5-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> Section "Commands" qualifies its rules on permitted argument and
> return types "with one exception noted below when 'gen' is used".  The
> note went away in commit 2d21291.  Clean up the dangling references.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/qapi-code-gen.txt | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--HktGQ6Bu83NAcj9PhGd4ueLwrr7qE9H4F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYxxqJAAoJEKeha0olJ0NqVw8H/1KXpDMz5Gnbjc+U3K3Q4doe
UTUVAxvOXUwbZlEbuBwTf6twNrYfbZUpwElCSZo5BllMAruVXdQ803U9XnqNqLpN
80D20/aV3mN5EgLJgHcuRP0tVGqJTirR1B50UDkmMe1JeN/SIZJzgl48ovgVnDTX
bs8gaRDsS5W6nVrLDcRgZp3Qodf+3DUbsyethvSwmi4+eEe7UxDyS5ZXOvoiUlF2
jBGi23CmJrAFBVFDJ1RjTEparT4c8KbK73iT/AX8pjsy++98WTmvgX4E/afMURRZ
XfRNblR24PNWokpCM69YtejWpWU4IuVlj4Un7rb1QMsVd9al97j8ONl10qB/IxE=
=0fTX
-----END PGP SIGNATURE-----

--HktGQ6Bu83NAcj9PhGd4ueLwrr7qE9H4F--
