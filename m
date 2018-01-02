Received: from eggs.gnu.org ([2001:4830:134:3::10]:56868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWToq-0001c2-Hy
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 16:09:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWTop-0002SU-Ke
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 16:09:56 -0500
References: <20171226025247.11082-1-famz@redhat.com>
	<20171226025247.11082-2-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3c943c7a-5aa0-9584-772f-2ce1df633898@redhat.com>
Date: Tue, 2 Jan 2018 15:09:40 -0600
MIME-Version: 1.0
In-Reply-To: <20171226025247.11082-2-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="y9mUQOJAQK4qwdLj1lxAV7hd188Y7T2VT"
Subject: Re: [Qemu-devel] [PATCH v5 1/2] qemu-img.texi: Clean up parameter
 list
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
--y9mUQOJAQK4qwdLj1lxAV7hd188Y7T2VT
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, kchamart@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <3c943c7a-5aa0-9584-772f-2ce1df633898@redhat.com>
Subject: Re: [PATCH v5 1/2] qemu-img.texi: Clean up parameter list
References: <20171226025247.11082-1-famz@redhat.com>
 <20171226025247.11082-2-famz@redhat.com>
In-Reply-To: <20171226025247.11082-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/25/2017 08:52 PM, Fam Zheng wrote:
> Split options out of the "@table @var" section and create a "@table
> @option", then use whitespaces and blank lines consistently.
>=20
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  qemu-img.texi | 66 +++++++++++++++++++++++++++++++++++----------------=
--------
>  1 file changed, 39 insertions(+), 27 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--y9mUQOJAQK4qwdLj1lxAV7hd188Y7T2VT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpL9RQACgkQp6FrSiUn
Q2q7NQf/aKNkr4sKb1cyFMcHzskv3YsLyVAy97Z8DmDiL2YMMoJBwd9+Vs/EDCwE
r2+9dQsw+0T4JoyHqGyh+RbAGE0xm4Mf80bL71+wHJouKNB2IZOZzWvF2dVxdkGg
VgU7di0xf5X5DLGkvfQWiGq2K1UUXOFgqiUVK+pOuqUG7kodrMoGw2iGS+vYPVVC
ktG4B2kVcSlUGDIyH+Ph5Z3O6si/EM7wauTekuLW94s3ZXFAlaWt33yuo9buRWO2
mg2VEnzfkyqwkhpqF1CXyeZnzOUk/crJJ+E0mVvOwNLpZnHUMDWsIlzsFB0Mx8Lz
AwzTC2/lLoj9MkqniGH1BXW2KVVUdQ==
=4mOS
-----END PGP SIGNATURE-----

--y9mUQOJAQK4qwdLj1lxAV7hd188Y7T2VT--
