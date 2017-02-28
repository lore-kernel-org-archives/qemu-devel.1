Received: from eggs.gnu.org ([2001:4830:134:3::10]:51167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cikYC-0002Je-P8
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:22:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cikYB-00065I-Hr
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:22:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cikYB-00064n-CD
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:22:55 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9540D5147B
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 16:22:55 +0000 (UTC)
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
	<1488145424-14974-27-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6e222610-ea18-9331-e796-8e7b587552b3@redhat.com>
Date: Tue, 28 Feb 2017 10:22:53 -0600
MIME-Version: 1.0
In-Reply-To: <1488145424-14974-27-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ng067lb5VUcfdIUwdpo0D03NcxbAOwN0E"
Subject: Re: [Qemu-devel] [PATCH v2 26/26] qapi: Improve qobject visitor
 documentation
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
--ng067lb5VUcfdIUwdpo0D03NcxbAOwN0E
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <6e222610-ea18-9331-e796-8e7b587552b3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 26/26] qapi: Improve qobject visitor
 documentation
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
 <1488145424-14974-27-git-send-email-armbru@redhat.com>
In-Reply-To: <1488145424-14974-27-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2017 03:43 PM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/qobject-input-visitor.h  | 37 +++++++++++++++++++++++++++=
+++++++-
>  include/qapi/qobject-output-visitor.h | 35 +++++++++++++++++++++++++++=
++----
>  2 files changed, 67 insertions(+), 5 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ng067lb5VUcfdIUwdpo0D03NcxbAOwN0E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtaPdAAoJEKeha0olJ0NqdNUIAISK7QqP7ijwP7Rur8XMGvR3
qEQJuMI147VMWb6jHtRDu4LyBr6qcCZvzc2NHc8lDFub3CMgzN+a5jC+ijtwvYGq
ugQPiL7/zQHExGjbIXbyNo/hhGu+mf8/g4uCVelHnjFeHh5/VN3CYYqp9nqRYzaG
zGMcc5xBUwaERI/uhCwhsbGxv3cVyXwSNc5NsM5LGycYZ/Yxlk67hJAQ9WCvcwBJ
PkMYTk6B/txTrH1WeUesL6/ftlcL99s0c9Mtl944zDjx8djYOIIg4/8cgNC5Vrey
0GYJhwcRA4bi5WrEGvwymKauXP/UeH80TOSBTg6nNlTNoh4ZrCjwKOLEDJtZwDw=
=NPSJ
-----END PGP SIGNATURE-----

--ng067lb5VUcfdIUwdpo0D03NcxbAOwN0E--
