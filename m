Received: from eggs.gnu.org ([2001:4830:134:3::10]:37758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cq3Sp-0007md-2T
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 15:59:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cq3So-00024t-Ai
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 15:59:35 -0400
References: <1490014548-15083-1-git-send-email-armbru@redhat.com>
	<1490014548-15083-4-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8b80d9dc-4b36-ef64-4e90-4b197ef9e3f1@redhat.com>
Date: Mon, 20 Mar 2017 14:59:27 -0500
MIME-Version: 1.0
In-Reply-To: <1490014548-15083-4-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="j61XXFMcrFeshOTehrkdeqBpnQ0R1Ad9h"
Subject: Re: [Qemu-devel] [PATCH for-2.9 3/5] test-keyval: Cover alternate
 and 'any' type
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
--j61XXFMcrFeshOTehrkdeqBpnQ0R1Ad9h
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <8b80d9dc-4b36-ef64-4e90-4b197ef9e3f1@redhat.com>
Subject: Re: [PATCH for-2.9 3/5] test-keyval: Cover alternate and 'any' type
References: <1490014548-15083-1-git-send-email-armbru@redhat.com>
 <1490014548-15083-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1490014548-15083-4-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/20/2017 07:55 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/Makefile.include |  2 +-
>  tests/test-keyval.c    | 53 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 54 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--j61XXFMcrFeshOTehrkdeqBpnQ0R1Ad9h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0DSfAAoJEKeha0olJ0NqcNIH+wdDkYfG6uTHfe4dBRQTztAk
n8RakIrBQG8+kOxNZ6wdMZw7Iu+qKCkyD2HaqDLkyOuAcg84I6GzIXldzjFXxi0T
1ELm+GHulUhacAME3YijmNHrKBVcHj8LP7R5JsS5RjGowBTp0ssUmzPAnCmbKrSC
MYfzAX2m3q22c7QUN2vgrfbJrBG4br76okdlAG1KurkrIgqUvLEYtUNKZzS1ZshH
DpJHHAgn6hXypbzT0i1p/EZYVwghPQimIhB1DEePhHWweBH2VbisG2MHvotQfOd8
NRzCT28QwGIcAxDU11NMRxxHbKRbvC4C24OXC6vM6BusOCQIPBIpSyyp8QPqUEM=
=JELQ
-----END PGP SIGNATURE-----

--j61XXFMcrFeshOTehrkdeqBpnQ0R1Ad9h--
