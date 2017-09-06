Received: from eggs.gnu.org ([2001:4830:134:3::10]:58523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpcLk-0003n5-I1
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpcLh-0007XC-U6
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:34:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpcLh-0007Qn-L2
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:34:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7EE4C0587C6
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 15:34:40 +0000 (UTC)
References: <cover.1504696921.git.mprivozn@redhat.com>
	<dbd61a0928821348486d0d6260be2bd3b02b6402.1504696921.git.mprivozn@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <80b71b63-9ca4-bd33-b16c-f32f1f17341b@redhat.com>
Date: Wed, 6 Sep 2017 10:34:37 -0500
MIME-Version: 1.0
In-Reply-To: <dbd61a0928821348486d0d6260be2bd3b02b6402.1504696921.git.mprivozn@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UXQKhjQdQgvMpgmFxmqkAAeVTcA46utqR"
Subject: Re: [Qemu-devel] [PATCH v4 1/3] qapi: Rename
 WatchdogExpirationAction enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UXQKhjQdQgvMpgmFxmqkAAeVTcA46utqR
From: Eric Blake <eblake@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com
Message-ID: <80b71b63-9ca4-bd33-b16c-f32f1f17341b@redhat.com>
Subject: Re: [PATCH v4 1/3] qapi: Rename WatchdogExpirationAction enum
References: <cover.1504696921.git.mprivozn@redhat.com>
 <dbd61a0928821348486d0d6260be2bd3b02b6402.1504696921.git.mprivozn@redhat.com>
In-Reply-To: <dbd61a0928821348486d0d6260be2bd3b02b6402.1504696921.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/06/2017 06:24 AM, Michal Privoznik wrote:
> The new name is WatchdogAction which is shorter,
>=20
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>  hw/watchdog/watchdog.c | 14 +++++++-------
>  monitor.c              |  4 ++--
>  qapi/run-state.json    |  6 +++---
>  3 files changed, 12 insertions(+), 12 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UXQKhjQdQgvMpgmFxmqkAAeVTcA46utqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmwFY0ACgkQp6FrSiUn
Q2oVFwgAoe9PKiNVHh1eBeaBbyFEB0Y8V/zGDG5gjYgpUB8dCE+m3ip/FnmkPQhG
rOBWNsjXbS7K+p8e9lzOBDxPo3MRzhtoDieO8fW8nS8hdp5wecfdTDpskinnX9IH
ZVJ190E/11/YZOsT5Ss/hnpMiIxQZrlyFzle6hh4Fr/0mDDH5licehOlv6uAdqLW
mBwX1/AIUD/oYMn6pn+vCbxdBZtsqejahOBp2kwRh3Qq2WxoKvfSS6q0xja08vmL
JJW12eLjPSB9QA4HXwJ+n/BPeSI7YrMIniflE5bFSEKmwXfkJNOzx9r+TkDTrkGM
VJCwAYpqIq5Z+xYJ5UM2gpns8ZTVSQ==
=S3ZF
-----END PGP SIGNATURE-----

--UXQKhjQdQgvMpgmFxmqkAAeVTcA46utqR--
