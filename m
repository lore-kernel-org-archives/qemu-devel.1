Received: from eggs.gnu.org ([2001:4830:134:3::10]:50822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwwbh-0006tP-Gr
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 16:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwwbd-0008Ep-Iw
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 16:37:29 -0400
References: <20170926202512.37670-1-carenas@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <581bdcc9-6826-3fd9-f531-c37041cf34d1@redhat.com>
Date: Tue, 26 Sep 2017 15:37:20 -0500
MIME-Version: 1.0
In-Reply-To: <20170926202512.37670-1-carenas@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VVhE9VFSVK81iDHQ6KdORkUFwjWqBJ6dN"
Subject: Re: [Qemu-devel] [PATCH] gitignore: ignore check-qlit test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, marcandre.lureau@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VVhE9VFSVK81iDHQ6KdORkUFwjWqBJ6dN
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, marcandre.lureau@redhat.com
Message-ID: <581bdcc9-6826-3fd9-f531-c37041cf34d1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] gitignore: ignore check-qlit test
References: <20170926202512.37670-1-carenas@gmail.com>
In-Reply-To: <20170926202512.37670-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/26/2017 03:25 PM, Carlo Marcelo Arenas Bel=C3=B3n wrote:

Worth mentioning in the commit message body that it was introduced in
commit 382176b4.

> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  tests/.gitignore | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/tests/.gitignore b/tests/.gitignore
> index cf6d99c91e..53cb2efaee 100644
> --- a/tests/.gitignore
> +++ b/tests/.gitignore
> @@ -6,6 +6,7 @@ check-qdict
>  check-qnum
>  check-qjson
>  check-qlist
> +check-qlit
>  check-qnull
>  check-qstring
>  check-qom-interface
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--VVhE9VFSVK81iDHQ6KdORkUFwjWqBJ6dN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnKuoAACgkQp6FrSiUn
Q2rhggf9E0EZDseAZbl3AC/aP/AMMNvnotG/t7QNPpzCDzpCGOtGj68ZAOSx9NOM
c7nSX0JctWZcIegKLjW2KNYSD4KUB+Z16ehLTFcl2j4G14nH6LiPtGimJtl6JVzb
rBiWn5q7hAv9AzjPlcxHhb2FTpG4lKKq6W8BqXCTlE78d0iwWR/ZpIi6YINEUqhm
zilbxWh1Oc5wDXP5XgPaSY4Y10opXY4pJBxC3oBPVH8VrQNYgMDencpfxPF7/cb9
QBXIj3WO5EU4mMpzbxYLasa7iHkVs+LG1tEW6NAznwlA+XSLvmpYSWYd/gdFKbB1
duJV5fmsDTQyNcWCNDkglCt4t+wY6w==
=uFUY
-----END PGP SIGNATURE-----

--VVhE9VFSVK81iDHQ6KdORkUFwjWqBJ6dN--
