Received: from eggs.gnu.org ([2001:4830:134:3::10]:41339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjsCa-00062K-Ew
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:45:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjsCV-0003oU-JW
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:45:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjsCV-0003ny-Dn
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:45:11 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B64B8048D
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 18:45:11 +0000 (UTC)
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
	<1488544368-30622-25-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b12059d4-6c50-454a-fb3b-92187d6998c5@redhat.com>
Date: Fri, 3 Mar 2017 12:45:08 -0600
MIME-Version: 1.0
In-Reply-To: <1488544368-30622-25-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D4eaF0x1DDoKuSJTLxjeJWgT1Utnn87Ae"
Subject: Re: [Qemu-devel] [PATCH v4 24/28] test-qobject-input-visitor: Cover
 missing nested struct member
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D4eaF0x1DDoKuSJTLxjeJWgT1Utnn87Ae
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <b12059d4-6c50-454a-fb3b-92187d6998c5@redhat.com>
Subject: Re: [PATCH v4 24/28] test-qobject-input-visitor: Cover missing nested
 struct member
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
 <1488544368-30622-25-git-send-email-armbru@redhat.com>
In-Reply-To: <1488544368-30622-25-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2017 06:32 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-qobject-input-visitor.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--D4eaF0x1DDoKuSJTLxjeJWgT1Utnn87Ae
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYubm0AAoJEKeha0olJ0Nq6JcH/A1N4vRj58L/JbITw491HYXU
Zi5CliITyVHYteV6zJw8f90EQkRGVGFLRFCl8LbswSMHccZeIie2t08reEes3MDs
D6zFhgxNQXvld8YXJo7rVkSQyQgdLNexdzRtYRX1fojYXizGhVFr8MvdKvAj2hNa
5ewCppEjmwYW5rVa63L/7NKCNBth9Fii9mKj7Slle9Z89uxWBHjIVLkTT6dbuAbK
wSSgfegi++M/+ZIVWqMu9JafgxPJWRP24AJarawmYjvuvWSMdC3do7gD1H74gspw
97vx+3FWjwzUtzEs3VdO2w5XCBvMxGSonaUTnjWVa9XdSrdgnDO49PQyhsmu5ws=
=pcr9
-----END PGP SIGNATURE-----

--D4eaF0x1DDoKuSJTLxjeJWgT1Utnn87Ae--
