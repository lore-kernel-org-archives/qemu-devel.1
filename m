Received: from eggs.gnu.org ([2001:4830:134:3::10]:59956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfZM5-00076Z-QH
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 18:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfZM4-0004YV-Hg
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 18:21:33 -0400
References: <20170809215510.22802-1-pbonzini@redhat.com>
	<20170809215510.22802-3-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a52e488a-184b-731b-cac0-3a5be2320e22@redhat.com>
Date: Wed, 9 Aug 2017 17:21:21 -0500
MIME-Version: 1.0
In-Reply-To: <20170809215510.22802-3-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="p5EA44U8fRQ7Sme3NK32ADWi9LIk6bHGO"
Subject: Re: [Qemu-devel] [PATCH 02/12] qemu-iotests: get rid of AWK_PROG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p5EA44U8fRQ7Sme3NK32ADWi9LIk6bHGO
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <a52e488a-184b-731b-cac0-3a5be2320e22@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/12] qemu-iotests: get rid of AWK_PROG
References: <20170809215510.22802-1-pbonzini@redhat.com>
 <20170809215510.22802-3-pbonzini@redhat.com>
In-Reply-To: <20170809215510.22802-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/09/2017 04:55 PM, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/qemu-iotests/check         | 4 ++--
>  tests/qemu-iotests/common        | 2 +-
>  tests/qemu-iotests/common.config | 3 ---
>  3 files changed, 3 insertions(+), 6 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--p5EA44U8fRQ7Sme3NK32ADWi9LIk6bHGO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmLiuEACgkQp6FrSiUn
Q2qMhwgAl+aWKhwwUjFArHNP7V+cajUoN4F71l0QjFciZBiYbne+8l2OPNFmWDGj
HdKDQGqjjpHaxYN0vSZF+DE2WIujPOkH2utOmkhx9gy6G/mscBXOJno2L3TXYfl+
RDZh/9J/uSR64m3DDCIyxMYbdpFLhNACaV74s6yLV/qjgJnG5GERgFj86TSev1ZS
LPZCI5vuirs8lbrO9zjn6qIzWwL3KDYy54RsS3PZgcIi4vpbgEXKum8lwcblCsKV
3MGuq0ROs94LkxN52eGfDYTVcUnW5p1SoCcdbzeGBmeLsMnnr2cxJ/I4w1tpCJ9i
PV/0HgEr9XdvESy1MlgfbAWc6M8mYw==
=eYhG
-----END PGP SIGNATURE-----

--p5EA44U8fRQ7Sme3NK32ADWi9LIk6bHGO--
