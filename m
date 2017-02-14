Received: from eggs.gnu.org ([2001:4830:134:3::10]:42718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdmIk-0001yL-1R
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 18:14:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdmIg-0007y1-3S
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 18:14:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cdmIf-0007xg-TV
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 18:14:22 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2EF09C0567B3
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 23:14:22 +0000 (UTC)
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-14-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <01cc1459-b4dc-3da1-0f3d-19cdc723fe09@redhat.com>
Date: Tue, 14 Feb 2017 17:14:19 -0600
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-14-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="08gN7XX4uOxDbJqJoJXofJ4ddaa1jWJMg"
Subject: Re: [Qemu-devel] [PATCH 13/24] tests/test-cutils: Cover
 qemu_strtosz() around range limits
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
--08gN7XX4uOxDbJqJoJXofJ4ddaa1jWJMg
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <01cc1459-b4dc-3da1-0f3d-19cdc723fe09@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 13/24] tests/test-cutils: Cover
 qemu_strtosz() around range limits
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
 <1487067971-10443-14-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-14-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:26 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-cutils.c | 61 +++++++++++++++++++++++++++++++++++++++++++++=
++++++--
>  1 file changed, 59 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--08gN7XX4uOxDbJqJoJXofJ4ddaa1jWJMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYo49LAAoJEKeha0olJ0NqKggH/isDcy64fIFLaG+4NzePSgNB
D/SRc6jJI/AfkUL55JAgis7+V7ZURc/qfrALCG6Fpyw0boWJmpS3l+4P4S4iNLEi
HqoTqKX3fIpA4A4Fe4JMUPNOxOTC+PgH0diwzZbyItz8fa6J5PIkIEiVRxwbYSeX
m4nugxyaID8GLPjpCvhAZczWEP9FSq95Ut98rWDB4PdZhG1NnnuuSpnPiEmvH/gv
4GxF2oOkKtdKpgy1ZMIirag8uW06Il+ZccrxrWi3S0Lg4ejUxGfbPp7oY1yEmaZF
e3BmsldtvZNjLrP7xU60XCm85oXhhdSkOdof/oLg0zt3JdRknEgvYY04dosGX7Q=
=wC7C
-----END PGP SIGNATURE-----

--08gN7XX4uOxDbJqJoJXofJ4ddaa1jWJMg--
