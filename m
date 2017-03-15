Received: from eggs.gnu.org ([2001:4830:134:3::10]:50164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1coAOr-000823-26
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1coAOo-00014g-0u
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:59:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1coAOn-000144-Nm
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:59:37 -0400
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
	<1489582656-31133-31-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4fcba618-90f0-3635-8103-f335ef5f3ccf@redhat.com>
Date: Wed, 15 Mar 2017 09:59:34 -0500
MIME-Version: 1.0
In-Reply-To: <1489582656-31133-31-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bhkI9sa2id5lcRcpU8NkexuEhTL9JlXj9"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.9 30/47] tests/qapi-schema:
 Improve doc / expression mismatch coverage
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
--bhkI9sa2id5lcRcpU8NkexuEhTL9JlXj9
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <4fcba618-90f0-3635-8103-f335ef5f3ccf@redhat.com>
Subject: Re: [PATCH v2 for-2.9 30/47] tests/qapi-schema: Improve doc /
 expression mismatch coverage
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
 <1489582656-31133-31-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-31-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/15/2017 07:57 AM, Markus Armbruster wrote:
> New tests doc-before-include.json and doc-before-pragma.json show we
> fail to reject a misplaced expression comment.
>=20
> New test doc-no-symbol.json shows a bad error message.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--bhkI9sa2id5lcRcpU8NkexuEhTL9JlXj9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyVbWAAoJEKeha0olJ0NqyAEH/jFv+yNFYMDAx0JcvFHLeBA3
Xaac2UuFp0rY46L8oR8gZtUEcnKKY8KJXnWPEizLcXssMSgAEU7vtP5IeGhXYTA0
XB8HxQUPCpq53S7qyXU/GjW8Yv+p+RisAzl0F1bN/0RO4P++hNAUIDu2ANBbivQr
kDzlY+uyJxrfPylv7bQJciNKydgxZudtS6nCoMsFlzNtFS02c3Vb4laVrL+K/NLy
jyWwLT9y0HT/gKI3ovr2VY5lUBFKdVCkLt6GJ29q4dMQ0UIIgMoJXM1VQ8WfBEaH
BqSV9teWbDn7NmTWSrlylwWJcwOFzFK8po9O5TnyBuieJEKxq3TAdZ8ULnw1roo=
=b8u3
-----END PGP SIGNATURE-----

--bhkI9sa2id5lcRcpU8NkexuEhTL9JlXj9--
