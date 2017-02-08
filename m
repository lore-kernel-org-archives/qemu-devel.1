Received: from eggs.gnu.org ([2001:4830:134:3::10]:44516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbZtX-0006QK-Q4
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:35:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbZtU-0008Kd-OZ
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:35:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cbZtU-0008KA-Gc
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:35:16 -0500
References: <1486531462-13882-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1486531462-13882-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9358a09d-d65f-2b44-9bce-7027b133f1f8@redhat.com>
Date: Wed, 8 Feb 2017 15:35:13 -0600
MIME-Version: 1.0
In-Reply-To: <1486531462-13882-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hrt0FphBkSUPKul3MH3uRGn3WOHtc9OFR"
Subject: Re: [Qemu-devel] [PATCH V7 2/2] Add a new qmp command to do
 checkpoint, query xen replication status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Wen Congyang <wencongyang@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hrt0FphBkSUPKul3MH3uRGn3WOHtc9OFR
From: Eric Blake <eblake@redhat.com>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>,
 qemu devel <qemu-devel@nongnu.org>
Cc: Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>,
 Wen Congyang <wencongyang@gmail.com>
Message-ID: <9358a09d-d65f-2b44-9bce-7027b133f1f8@redhat.com>
Subject: Re: [PATCH V7 2/2] Add a new qmp command to do checkpoint, query xen
 replication status
References: <1486531462-13882-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
 <1486531462-13882-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1486531462-13882-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/07/2017 11:24 PM, Zhang Chen wrote:
> We can call this qmp command to do checkpoint outside of qemu.
> Xen colo will need this function.
>=20
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
> ---
>  migration/colo.c | 17 ++++++++++++++++
>  qapi-schema.json | 60 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 77 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--hrt0FphBkSUPKul3MH3uRGn3WOHtc9OFR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYm48RAAoJEKeha0olJ0NqgDsH/imCROHmdlf3qkZM6u3rZST7
Vfu+z/IiNgUJHNVIx1KymY0zmOL24niaWT+JkdsWLBAugGZZERQfL5r436D0KLQ3
gLTtMlvwix2rWiapC8Bpv2fOn5TQ3FGb3uPMaxwzmOw4jiSNjYm9mJitcTyZv10g
a463nXZF50kF7OF/6rThNTPYCDzLUwyGFaDNq1NYzQYsgLl+bvoxtddRAaSvUL3s
ASD201i8LkqevIoG2Y8gQDuu4vUVzo2IgZe3riGpczhK4u8+lTL8syPQ8xqMUtpg
J+IY/UQnt9nMbMx0jzfDF9cw5tE8m5tYPEjY3fw7keXRGjLwIWKd7m0oeo5c/sE=
=dyJE
-----END PGP SIGNATURE-----

--hrt0FphBkSUPKul3MH3uRGn3WOHtc9OFR--
