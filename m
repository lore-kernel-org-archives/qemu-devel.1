Received: from eggs.gnu.org ([2001:4830:134:3::10]:40672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjsAG-0004iL-Jr
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:42:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjsAF-0002uq-NH
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:42:52 -0500
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-16-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <29e69289-121d-a907-5f3b-66837a1ccfc7@redhat.com>
Date: Fri, 3 Mar 2017 12:42:42 -0600
MIME-Version: 1.0
In-Reply-To: <1488491046-2549-16-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uQaVGcDeRSq2UGGVFHRQDkQXsFnQ3Osqg"
Subject: Re: [Qemu-devel] [PATCH 15/15] sheepdog: Support blockdev-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, qemu-block@nongnu.org, namei.unix@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uQaVGcDeRSq2UGGVFHRQDkQXsFnQ3Osqg
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com,
 qemu-block@nongnu.org, namei.unix@gmail.com
Message-ID: <29e69289-121d-a907-5f3b-66837a1ccfc7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 15/15] sheepdog: Support blockdev-add
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
 <1488491046-2549-16-git-send-email-armbru@redhat.com>
In-Reply-To: <1488491046-2549-16-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/02/2017 03:44 PM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/block-core.json | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--uQaVGcDeRSq2UGGVFHRQDkQXsFnQ3Osqg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYubkjAAoJEKeha0olJ0NqTGgH/As00syVEFbIC/wULg6Bvrix
44YQjlj+d7cQHyhSOrgVuy3Te/MQ9VQMepEmOTKOQSqud9S/kMSgNERbSO8wEuM/
SHcM5j5IxdI+zBNU/TG8aBDWjaLJGhTKTdx/Cp3br+cH397eiUBVlaHYEp6AF9Dj
H6V/rljWMH7eWBjRv7UKGzdcsP4NXvf3AB8F8cHSbkIvfBVUsSAPIeAJhjfnsIuO
NDmlU7sEPuh/QSvWi/JDrnwg45H/aIywQICURq9jVCRfHfEalgE9v2FynpfW2wOH
4uPGVBgK0EmF0tmp+3I0lIbRYjOnMJOnkUd31i4J3+i53VkyXh38DMQJ0BoJ6OA=
=/Lei
-----END PGP SIGNATURE-----

--uQaVGcDeRSq2UGGVFHRQDkQXsFnQ3Osqg--
