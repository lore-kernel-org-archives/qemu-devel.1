Received: from eggs.gnu.org ([2001:4830:134:3::10]:51715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ2cH-0005EJ-Fp
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 17:43:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ2cD-00071X-EY
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 17:43:33 -0500
References: <20171129152510.25833-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <00beb02b-c86a-092c-e496-738164d87a4a@redhat.com>
Date: Tue, 9 Jan 2018 16:43:24 -0600
MIME-Version: 1.0
In-Reply-To: <20171129152510.25833-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wGGpmEdtlYQDXaJfcYGAepKEB7k0lZ4kH"
Subject: Re: [Qemu-devel] [PATCH] maint: Mention web site maintenance in
 README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, qemu-trivial <qemu-trivial@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wGGpmEdtlYQDXaJfcYGAepKEB7k0lZ4kH
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com,
 qemu-trivial <qemu-trivial@nongnu.org>
Message-ID: <00beb02b-c86a-092c-e496-738164d87a4a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] maint: Mention web site maintenance in
 README
References: <20171129152510.25833-1-eblake@redhat.com>
In-Reply-To: <20171129152510.25833-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/29/2017 09:25 AM, Eric Blake wrote:
> Now that we have a website that accepts patches on the list, the
> main project should make it easier to find information about that
> process.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> Doc only, so it could go in -rc3 if we have a reason to slip it
> in this late; but I'm also fine if it waits for 2.12.

It's now 2.12 material. Ping!
CC: qemu-trivial

>=20
>  README | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/README b/README
> index b92a07a61a..2c8e1c8cc4 100644
> --- a/README
> +++ b/README
> @@ -68,6 +68,10 @@ the QEMU website
>    https://qemu.org/Contribute/SubmitAPatch
>    https://qemu.org/Contribute/TrivialPatches
>=20
> +The QEMU website is also maintained under source control.
> +
> +  git clone git://git.qemu.org/qemu-web.git
> +  https://www.qemu.org/2017/02/04/the-new-qemu-website-is-up/
>=20
>  Bug reporting
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wGGpmEdtlYQDXaJfcYGAepKEB7k0lZ4kH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpVRYwACgkQp6FrSiUn
Q2pryQf8DAbz1HiRqsGbYPBZhMSunfIXrGjkrulWG15fbf5tTZNVCQH6HthoHWhT
U9hR521ACBKPgziR6Dp8auiqKTb7Uitk2n6TIxapqrRBwTRcU8aYL211a9gi7COq
a1MwmmsyMgkDv6XfURtYcgbykCndARgFKaWtmv5wC6wYb6cqfvIOAQvKGGMUsajl
wO4EBJlVGWzm+7gnDXm7N0BCcAIaru99kxaaxZD4PPsPYLgeaw/agGYc9r5g5YvZ
Fp1L7+TGNpMhxGHAMv3LfsKc9S8j7HqDzDkR4iurFsMHuIP9X63mpms7245JSkgh
ueumtXgZodPhRL7vq2tL9JbP5fauhQ==
=6gZ+
-----END PGP SIGNATURE-----

--wGGpmEdtlYQDXaJfcYGAepKEB7k0lZ4kH--
