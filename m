Received: from eggs.gnu.org ([2001:4830:134:3::10]:48274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daLNP-0000A5-PL
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:25:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daLNO-0005XJ-PW
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:25:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1daLNO-0005X3-JU
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:25:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A0197D0CB
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 12:25:17 +0000 (UTC)
References: <20170726115637.21558-1-kraxel@redhat.com>
	<20170726115637.21558-4-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6b0c442b-7c63-f5a8-2f14-893cac53efd6@redhat.com>
Date: Wed, 26 Jul 2017 07:25:15 -0500
MIME-Version: 1.0
In-Reply-To: <20170726115637.21558-4-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="68jGkKmGvlTf4Qgnnmc3mxliteHLV0pCW"
Subject: Re: [Qemu-devel] [PATCH 3/5] ui: update keymaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--68jGkKmGvlTf4Qgnnmc3mxliteHLV0pCW
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Message-ID: <6b0c442b-7c63-f5a8-2f14-893cac53efd6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] ui: update keymaps
References: <20170726115637.21558-1-kraxel@redhat.com>
 <20170726115637.21558-4-kraxel@redhat.com>
In-Reply-To: <20170726115637.21558-4-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/26/2017 06:56 AM, Gerd Hoffmann wrote:
> Add recently added QKeyCodes to the keymaps.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/input-keymap.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--68jGkKmGvlTf4Qgnnmc3mxliteHLV0pCW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll4iiwACgkQp6FrSiUn
Q2peEwf+IAjVCD9VZApvm5PD8EQ+fNssQZrvHj9K4b8cXRrZUw95zrQVdVx7Cu8F
23ehv17s979t8aoCiToy7T6aqWcF+uTKLp/tmaGyOqATTUUhRkkzu4YTc0biamfq
Dn/eRqvoK4wLrZSEG6Qhjt5UG4bAtKp1g7a45GHZvjFCK7dy8rg/9UmtbBwcGq9D
lwBnZQIUI2ZAAi2l7Vr+EKIfRO2jSdrlab2mjlv52xAK6xzrLk/9/fMCOC0R799u
wiuuq42TN/+Wxl/bYquyARmWLDyAF1LOZZX0IibdVJFNWi2B4cH6FWcWNIyohzJ0
x16l8cZqOsBGx4btPCJnoxCXNDvaRg==
=QYur
-----END PGP SIGNATURE-----

--68jGkKmGvlTf4Qgnnmc3mxliteHLV0pCW--
