Received: from eggs.gnu.org ([2001:4830:134:3::10]:58874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dehZ0-00080Q-Uh
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dehYw-000523-40
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:55:19 -0400
References: <cover.1502109078.git.jcody@redhat.com>
	<3f89708534aeb149ebf4a0e3e54b4c24b44a1116.1502109078.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d96c1c0d-65bd-8aa5-cbd4-4637b1fd6f21@redhat.com>
Date: Mon, 7 Aug 2017 07:54:57 -0500
MIME-Version: 1.0
In-Reply-To: <3f89708534aeb149ebf4a0e3e54b4c24b44a1116.1502109078.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ftNgaOejx4q4C828mv5KOK6OVFa42t5uo"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 3/4] block/vhdx: check error
 return of bdrv_flush()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ftNgaOejx4q4C828mv5KOK6OVFa42t5uo
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, kwolf@redhat.com
Message-ID: <d96c1c0d-65bd-8aa5-cbd4-4637b1fd6f21@redhat.com>
Subject: Re: [PATCH v2 for-2.10 3/4] block/vhdx: check error return of
 bdrv_flush()
References: <cover.1502109078.git.jcody@redhat.com>
 <3f89708534aeb149ebf4a0e3e54b4c24b44a1116.1502109078.git.jcody@redhat.com>
In-Reply-To: <3f89708534aeb149ebf4a0e3e54b4c24b44a1116.1502109078.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/07/2017 07:38 AM, Jeff Cody wrote:
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/vhdx-log.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ftNgaOejx4q4C828mv5KOK6OVFa42t5uo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmIYyEACgkQp6FrSiUn
Q2roSQf/RQ4rntIo2b0zjqfyFNshlgnjlyBCFnt88B9FMe2IqUiAdL/bxp81yFwe
vh+ApAkiYaX8i+RzwqxAcMTdbM9lrQzNsAXlIVADU8/06ff2BRIe2w5xvmKpFy7m
li1nIP3czLqEVf0zOPr1qZgxHf4a4EO2g9k+kLYqqDP9Azdc4iNYLmf6hPtvFGQp
wfDI6rmMuZC7CtgVVi1dfTi0K4BuubG2yQrabmMYAxk2VyAGYyFlfCsz91ayRDbj
hAkDs2JjlYmSOseJ5JCxqrRufCPl4wTPgDhLwzJrlNFkRPvCrJB49wNmaifv95VU
8E8GkCWjhs6Ub4uzycGMcEvJcj7mtA==
=2bpn
-----END PGP SIGNATURE-----

--ftNgaOejx4q4C828mv5KOK6OVFa42t5uo--
