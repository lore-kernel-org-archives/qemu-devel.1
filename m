Received: from eggs.gnu.org ([2001:4830:134:3::10]:43358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cntTa-0004aX-Fh
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cntTW-0003d7-Ic
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:55:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cntTW-0003bq-DA
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:55:22 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-37-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8ec13f22-4a66-530c-e2db-2cc4234de928@redhat.com>
Date: Tue, 14 Mar 2017 15:55:19 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-37-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OGT14GvMfD0bIaojmUpFpGp0vKO52AGHj"
Subject: Re: [Qemu-devel] [PATCH for-2.9 36/47] tests/qapi-schema: Improve
 coverage of bogus member docs
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
--OGT14GvMfD0bIaojmUpFpGp0vKO52AGHj
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <8ec13f22-4a66-530c-e2db-2cc4234de928@redhat.com>
Subject: Re: [PATCH for-2.9 36/47] tests/qapi-schema: Improve coverage of
 bogus member docs
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-37-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-37-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> New test doc-bad-union-member.json shows we can fail to reject
> documentation for nonexistent members.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--OGT14GvMfD0bIaojmUpFpGp0vKO52AGHj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyFi3AAoJEKeha0olJ0NqcJMIAJMVaTU6g1IfwIKfbQ6P6RKU
rKyfqg9JIcrMG+zIoKbU73n786gHhninb8X5JTcEDnA6VOaQeuOdWULt6hR9Esc1
o011v7O8KWRbbfd6tlHudCy4MnV0Iw5RsKb+T0P0tEk6FCGKHVbPPVr2N8V+/JrA
qScHuPm+cEgkpyk743BIqWuhO7BWO5tIdSRTr+f9jHGviTDrdIevRjADUI0NuLgS
m3HWmU8liuRAr9w/wWfQsI5B/jPMpatyDuM3ROhzzI+sqO/9IFzw42IobM0sb4Wc
gmsQxwSoCKEHb1VnPvbom2EJEoSJf/OXdfC4DOP2RcT01h1mqM2mdLFkiM/M9oY=
=S2R4
-----END PGP SIGNATURE-----

--OGT14GvMfD0bIaojmUpFpGp0vKO52AGHj--
