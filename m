Received: from eggs.gnu.org ([2001:4830:134:3::10]:36856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDyUc-0006Ox-3o
	for qemu-devel@nongnu.org; Thu, 25 May 2017 15:32:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDyUb-0008Ss-6Q
	for qemu-devel@nongnu.org; Thu, 25 May 2017 15:32:18 -0400
References: <20170525163851.8047-1-berrange@redhat.com>
	<20170525163851.8047-21-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a8ecf758-efb7-6d18-2823-643a482d63c2@redhat.com>
Date: Thu, 25 May 2017 14:32:08 -0500
MIME-Version: 1.0
In-Reply-To: <20170525163851.8047-21-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NROFNLfwGjwq9XVgK49Li9iCsTHFRETkj"
Subject: Re: [Qemu-devel] [PATCH v7 20/20] docs: document encryption options
 for qcow, qcow2 and luks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NROFNLfwGjwq9XVgK49Li9iCsTHFRETkj
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Message-ID: <a8ecf758-efb7-6d18-2823-643a482d63c2@redhat.com>
Subject: Re: [PATCH v7 20/20] docs: document encryption options for qcow,
 qcow2 and luks
References: <20170525163851.8047-1-berrange@redhat.com>
 <20170525163851.8047-21-berrange@redhat.com>
In-Reply-To: <20170525163851.8047-21-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/25/2017 11:38 AM, Daniel P. Berrange wrote:
> Expand the image format docs to cover the new options for
> the qcow, qcow2 and luks disk image formats
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-doc.texi | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++----
>  1 file changed, 115 insertions(+), 8 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--NROFNLfwGjwq9XVgK49Li9iCsTHFRETkj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJzE4AAoJEKeha0olJ0NqDjgH/0AtHdsoPLcDpeZeq+u9JaD6
M/XjavX4DCPmwNb3csPlW9V48Rz/PW8kHqfkW6CN7KNxmMDNLJhsJ5NcFGRFrImc
5zQi2bPnQUy5sB2OKZWt3sWNO6RnHkD740WQiKgeo5PFBPBJ6Wp19UJ+xtnTJazx
jLxHFe0T8LaCoiknFJk3nPYn2pEvQOseoaUKwneEaItzWAib6S1+RpYNPrN7rS8M
W2zSjVxzXh0+e3eBZc3t5XoX1riuGHEzXnB+Nu3Ksg4Mh9jAWKAgDR032VIlgH74
HixobENNCpfWzTfiBjioGbsC1ZC0+sc3/c1XVj/W5yEf7btLg9kBguq0hSG1RJI=
=sPRc
-----END PGP SIGNATURE-----

--NROFNLfwGjwq9XVgK49Li9iCsTHFRETkj--
