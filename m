Received: from eggs.gnu.org ([2001:4830:134:3::10]:55384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkv3e-0001Ea-Cy
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkv3b-0007lq-AS
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dkv3b-0007lK-0W
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:35 -0400
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
	<1503564371-26090-2-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <09db4afe-7fa3-97fc-9eef-a58b4d453193@redhat.com>
Date: Thu, 24 Aug 2017 11:32:29 -0500
MIME-Version: 1.0
In-Reply-To: <1503564371-26090-2-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nDWkxAg3GxG8J2WL5rp9jV07ljaUStmVd"
Subject: Re: [Qemu-devel] [PATCH 01/16] qapi: Update qapi-code-gen.txt
 examples to match current code
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
--nDWkxAg3GxG8J2WL5rp9jV07ljaUStmVd
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <09db4afe-7fa3-97fc-9eef-a58b4d453193@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/16] qapi: Update qapi-code-gen.txt
 examples to match current code
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
 <1503564371-26090-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1503564371-26090-2-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 03:45 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/devel/qapi-code-gen.txt | 47 +++++++++++++++++++++++++++++++++++-=
--------
>  1 file changed, 38 insertions(+), 9 deletions(-)

Might be nice to call out which commit(s) failed to update the docs when
they tweaked the generated output.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nDWkxAg3GxG8J2WL5rp9jV07ljaUStmVd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlme/50ACgkQp6FrSiUn
Q2oITAf/TUBpFDZpMYe+M5qV4XqvLSkBf42I4jE//buRWt/RjFfdhbhcPb+Kevc8
YeJYi3Zqr8f/u4Cz4VwOurUTtFNwS4kFGbmvh5KgVzOdbeM5jr2k8bM5IR/EoSef
NOLrXVfWkVSQQBWGIUA64iD7kXx9pPF+f4eGHyZ4ypB3tCaLR6fWlfpirWT73rBk
WFbPkcIgMylaVIKa4OoXHhk+KkUlsNkv3ObkMGc+N7fYkuXDnL+1BCQE6Z2HcAGT
k7jvVfVHVcGfdSdp98d+h/XCKruD4uKOHEnoLLtk3NJ6QU92tkB+QG3lT0jLskRR
6rEKesul9CGAsk0VwMNGfNvxxAmhfQ==
=Zlt/
-----END PGP SIGNATURE-----

--nDWkxAg3GxG8J2WL5rp9jV07ljaUStmVd--
