Received: from eggs.gnu.org ([2001:4830:134:3::10]:60769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egWKp-00088P-Ht
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:52:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egWKm-0008U9-Eo
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:52:27 -0500
References: <20180130063433.11605-1-famz@redhat.com>
	<20180130063433.11605-3-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9fa7a4f5-181d-9e53-46f5-965dc50dac2d@redhat.com>
Date: Tue, 30 Jan 2018 07:52:00 -0600
MIME-Version: 1.0
In-Reply-To: <20180130063433.11605-3-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oHyZe8MgpXlpZ89EFmxvGIQJqo6LvbYw9"
Subject: Re: [Qemu-devel] [PATCH v6 2/2] qemu-img: Document --force-share /
 -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, kchamart@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oHyZe8MgpXlpZ89EFmxvGIQJqo6LvbYw9
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, kchamart@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <9fa7a4f5-181d-9e53-46f5-965dc50dac2d@redhat.com>
Subject: Re: [PATCH v6 2/2] qemu-img: Document --force-share / -U
References: <20180130063433.11605-1-famz@redhat.com>
 <20180130063433.11605-3-famz@redhat.com>
In-Reply-To: <20180130063433.11605-3-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 12:34 AM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qemu-img.texi | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--oHyZe8MgpXlpZ89EFmxvGIQJqo6LvbYw9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpweIAACgkQp6FrSiUn
Q2p/Agf/UhGHskfkBkqcFQfB0Y/A0kSbARcH3v78w5R6rhOTeG+9IOFSEyDYwt/b
e3+6NBBhzsCRAQ270AR49cXiEX+EEm4rvHtkvKUYPy2dQCwF1cjRw7iO5U8v27Rk
pEPiV5d6D7Y2Rl03k30UjMxeT66Kj90tiY4QnUffV3M/LzVEzCUlf+f4FJz2UFb4
+q0PYbd0BTbeX0ILmfh7X/GzOXU63JMh6H88FSXbUIV3sOZ+Re6MDT2Qf0RiAp0t
Q2UrfC4YQ1qGfnpuvYIKFzCHVK5TLKSaWfxxu2SAnw/WLB0iQhmtaxHC+toMK9yk
37pt5/s0cPtS6GFVpldZYD8NVw0w5w==
=qrUy
-----END PGP SIGNATURE-----

--oHyZe8MgpXlpZ89EFmxvGIQJqo6LvbYw9--
