Received: from eggs.gnu.org ([2001:4830:134:3::10]:59052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3NoN-0007eu-9r
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3NoK-00083v-4v
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:20:55 -0400
References: <20170426134649.9042-1-mreitz@redhat.com>
	<20170426134649.9042-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eb6ffbe4-2aa5-ea59-6bb0-d73744161b5d@redhat.com>
Date: Wed, 26 Apr 2017 09:20:39 -0500
MIME-Version: 1.0
In-Reply-To: <20170426134649.9042-4-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GgPAteq12EDSqFkVQpCT1qgcnrGBROnx0"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qemu-img: Document backing options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GgPAteq12EDSqFkVQpCT1qgcnrGBROnx0
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <eb6ffbe4-2aa5-ea59-6bb0-d73744161b5d@redhat.com>
Subject: Re: [PATCH v2 3/3] qemu-img: Document backing options
References: <20170426134649.9042-1-mreitz@redhat.com>
 <20170426134649.9042-4-mreitz@redhat.com>
In-Reply-To: <20170426134649.9042-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2017 08:46 AM, Max Reitz wrote:
> The create and convert subcommands have shorthands to set the
> backing_file and, in the case of create, the backing_fmt options for th=
e
> new image. However, they have not been documented so far, which is
> remedied by this patch.
>=20
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qemu-img-cmds.hx | 8 ++++----
>  qemu-img.texi    | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GgPAteq12EDSqFkVQpCT1qgcnrGBROnx0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAKy3AAoJEKeha0olJ0NqBMsH/1xWSG8Z5UuASo9mAKavqQke
7DxBbm46do4fxX5+Mv0UnpLzGCLZrQSqSEA5pG4aOD4wWONHRV1tNlSZIBLx4hxh
wmqsZd9RJceRlRp6l0xLwswB777OZxdY7GQjUvEgBmBnZ3WhcBack0JdINAmDpIV
ms9hstU40IyXqttVYFKWCWHyXtjw5DF9upiPeCGGII3sgMTzHFSbA/95moh7CO9I
r/0jHfJAmZAbrCZSsGTwOvvy6eN5MmSHInFuwvlxhIeJ3SUat+4h7akHLcenG3qz
tAayAmgd7OJEzij8T+GXQieNpgNQKtD0rDANhitVaPXJ287uIBIElpb2rFSrlk0=
=x6gj
-----END PGP SIGNATURE-----

--GgPAteq12EDSqFkVQpCT1qgcnrGBROnx0--
