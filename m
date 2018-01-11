Received: from eggs.gnu.org ([2001:4830:134:3::10]:57422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZdt1-0008MT-Iu
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:31:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZdsw-0000h7-VI
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:31:19 -0500
References: <20180111142125.17034-1-mjt@msgid.tls.msk.ru>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5d07939d-86f7-9599-6635-af805a47a96d@redhat.com>
Date: Thu, 11 Jan 2018 08:30:54 -0600
MIME-Version: 1.0
In-Reply-To: <20180111142125.17034-1-mjt@msgid.tls.msk.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="v8JtAoaLJtGyxbBUWipcR3dkfS0xiBD9J"
Subject: Re: [Qemu-devel] [PATCH trivial] qapi-schema.json: spelling
 (independant comparation)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v8JtAoaLJtGyxbBUWipcR3dkfS0xiBD9J
From: Eric Blake <eblake@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <5d07939d-86f7-9599-6635-af805a47a96d@redhat.com>
Subject: Re: [PATCH trivial] qapi-schema.json: spelling (independant
 comparation)
References: <20180111142125.17034-1-mjt@msgid.tls.msk.ru>
In-Reply-To: <20180111142125.17034-1-mjt@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2018 08:21 AM, Michael Tokarev wrote:
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  qapi-schema.json | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 5c06745c79..0262b9f20b 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -2023,7 +2023,7 @@
>  #
>  # @static: Expand to a static CPU model, a combination of a static bas=
e
>  #          model name and property delta changes. As the static base m=
odel will
> -#          never change, the expanded CPU model will be the same, inde=
pendant of
> +#          never change, the expanded CPU model will be the same, inde=
pendent of
>  #          independent of QEMU version, machine type, machine options,=
 and
>  #          accelerator options. Therefore, the resulting model can be =
used by
>  #          tooling without having to specify a compatibility machine -=
 e.g. when
> @@ -2102,7 +2102,7 @@
>  ##
>  # @CpuModelCompareResult:
>  #
> -# An enumeration of CPU model comparation results. The result is usual=
ly
> +# An enumeration of CPU model comparison results. The result is usuall=
y
>  # calculated using e.g. CPU features or CPU generations.
>  #
>  # @incompatible: If model A is incompatible to model B, model A is not=

>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--v8JtAoaLJtGyxbBUWipcR3dkfS0xiBD9J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpXdR8ACgkQp6FrSiUn
Q2rDoAf9ErTCIJyluIRG0CkAnYDnyivHkhTWUuJz9LdsJPAIFqgfIZSqqzrKiTtp
9dOUGabWZvFXm1+LDqqa1o8ZX0cP/SsIBlq0Igi5czONSKMgVdx+Nx/7Ud9F5M5v
X1ShFoEGfcK4BvU7xeYbwCcx+6zHXxfdKwy9nozyCwKvn7tCxePxxETZJcb6lZjR
5e35H2h5k7oyMBnuLzgOxPnSSqXGzQV3Dq78KXWHm045uC9iqHqobigXGmQa/rdm
urj7VaqzdAjBk/CyTuOBQlxk8lWZmZemRGQiH9wlzN7d3bsWZyg9b62E+9Bcu4wR
kKjHzvIJUE3FjTi6/WaciJiX2AADyQ==
=uWaO
-----END PGP SIGNATURE-----

--v8JtAoaLJtGyxbBUWipcR3dkfS0xiBD9J--
