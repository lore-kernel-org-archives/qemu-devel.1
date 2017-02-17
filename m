Received: from eggs.gnu.org ([2001:4830:134:3::10]:35433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cepbR-0004vE-Dn
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:58:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cepbP-0007lK-JW
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:58:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cepbP-0007kn-Cj
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:58:03 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 768D3804EB
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 20:58:03 +0000 (UTC)
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-20-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <85f88826-0fb3-0dc7-09b4-064f7046e7a8@redhat.com>
Date: Fri, 17 Feb 2017 14:58:01 -0600
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-20-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nN9rxvj6lV8mDF9PsOndfFjO9GLFFrmjH"
Subject: Re: [Qemu-devel] [PATCH 19/24] tests/test-cutils: Drop suffix from
 test_qemu_strtosz_simple()
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
--nN9rxvj6lV8mDF9PsOndfFjO9GLFFrmjH
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <85f88826-0fb3-0dc7-09b4-064f7046e7a8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 19/24] tests/test-cutils: Drop suffix from
 test_qemu_strtosz_simple()
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
 <1487067971-10443-20-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-20-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:26 AM, Markus Armbruster wrote:
> Leave testing unit suffixes to test_qemu_strtosz_units().
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-cutils.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--nN9rxvj6lV8mDF9PsOndfFjO9GLFFrmjH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYp2PZAAoJEKeha0olJ0Nq+0IH/jgkdeA24MIfTVAobtyI4oRP
hidmIVkGEdw+WnRkjJkcZj0zbKTtvL8ZVyAqBI9cfHp4TvoU2nWmExWLlR3SAyL+
922SoBfa7l2pnmVNoc6iRZ/RYFYiYdzybtubjx9U2p5arpWk4zSIJp8x/lKPw40W
DOwZU2g9L81qB/1OUiJ6a75IJGW6oXymn/2XR4C6R4T3dlczohxp24IleA2Ft4jT
/wl8vGZ+Q50f9JPEpotCbXbXeZLMmRGJr+RQG9KvcIfkT+zTftLfEVGPa2AcnaWQ
UOL9WSQXtYR9kJC8LSLAJ6T/KGnlwZ0ctKDE6KrEJEwDOPjBjfPv4/nF+w7BB7M=
=vwtR
-----END PGP SIGNATURE-----

--nN9rxvj6lV8mDF9PsOndfFjO9GLFFrmjH--
