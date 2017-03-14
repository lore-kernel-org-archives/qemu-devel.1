Received: from eggs.gnu.org ([2001:4830:134:3::10]:43326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnqkQ-00062b-ON
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 14:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnqkM-00016N-1i
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 14:00:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnqkL-00015l-Qp
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 14:00:33 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-19-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9105289c-aa58-b1f8-4306-077b74cbc45b@redhat.com>
Date: Tue, 14 Mar 2017 13:00:31 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-19-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sXWHf34mOFf3dCqBguq0d8qrixedPGbrP"
Subject: Re: [Qemu-devel] [PATCH for-2.9 18/47] qapi: Use raw strings for
 regular expressions consistently
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
--sXWHf34mOFf3dCqBguq0d8qrixedPGbrP
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <9105289c-aa58-b1f8-4306-077b74cbc45b@redhat.com>
Subject: Re: [PATCH for-2.9 18/47] qapi: Use raw strings for regular
 expressions consistently
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-19-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-19-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--sXWHf34mOFf3dCqBguq0d8qrixedPGbrP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyC+/AAoJEKeha0olJ0Nq3hAH/2SITAiTUrIQGOwjXk/SXTwu
EY39IZnZNt/krfWV+4+HpI+TsCkk2ZqvKZJ/WAsPNvcS8Z3u5fP3IeLJoBOGQKyP
wgyZ4dDIcAvWVYPbPhk1vZZyOKjPJAo5tDvuCfbZH9JaYVIndbRY8xlUMlx8ptHL
Jt5IYar/hQg2TeM1f+xL2jsVAC7n5pfC1O90PuuBrJKLv72SvPmx7nGEYDqMjVFE
2MPnd/qLW6FBDS7lAhw9uqS2A/65WqvKr+9cTIuNbnSNrI9hI/CKxr6GmqnpDt34
f7h3a+Xl7u8h8iT9QDFCH477o8HHt3M3jTvlayE/mWKyAX7v2fpkRNDp+6RGfyc=
=fVo7
-----END PGP SIGNATURE-----

--sXWHf34mOFf3dCqBguq0d8qrixedPGbrP--
