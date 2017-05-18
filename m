Received: from eggs.gnu.org ([2001:4830:134:3::10]:36491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBMkT-0005IW-Do
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBMkQ-000369-Ct
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:49:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dBMkQ-00035y-6U
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:49:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C9DEC04B945
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 14:49:49 +0000 (UTC)
References: <20170518111837.29212-1-quintela@redhat.com>
	<20170518111837.29212-3-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f72e8205-f9a3-898d-4561-34408c51f162@redhat.com>
Date: Thu, 18 May 2017 09:49:44 -0500
MIME-Version: 1.0
In-Reply-To: <20170518111837.29212-3-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DKxQPO6mPHJhwdJQ5Iid75rrV0uFDahWL"
Subject: Re: [Qemu-devel] [PATCH 2/5] migration: Create block capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DKxQPO6mPHJhwdJQ5Iid75rrV0uFDahWL
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com,
 armbru@redhat.com
Message-ID: <f72e8205-f9a3-898d-4561-34408c51f162@redhat.com>
Subject: Re: [PATCH 2/5] migration: Create block capability
References: <20170518111837.29212-1-quintela@redhat.com>
 <20170518111837.29212-3-quintela@redhat.com>
In-Reply-To: <20170518111837.29212-3-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/18/2017 06:18 AM, Juan Quintela wrote:
> Create one capability for block migration and one parameter for
> incremental block migration.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>=20
> ---
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DKxQPO6mPHJhwdJQ5Iid75rrV0uFDahWL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZHbSJAAoJEKeha0olJ0NqGsYH/A1/vLn+Tcuy/H4/gRViftX7
kyFn+QTxfFTsLsf75hQzGJ4LRP2E/Up5ilFxpQyT3RgHHjxfmzbK2q4z4ylTuj/g
5HZBfjIBX5HdFep48XIEWgUBnOnfOjJq7XRwiTAjcqUeiZ3cZmvoyArjIZrsrkp9
m4YODT6puKevkM0P2wbq6RVpNNpjQqvTkDsXite69XXv1wGCToeoGH+fhZR2tFuy
8OT7O8Hup9X5Lmdd2KRhU+J0AYgF0Qiqq6Yju9NV4mdTED9FL0RLSR9qnOzdxhvm
CwiKsT2nHM7wMLh51nPURyZLUaB5+TnIL4rmg1pEsAEeawYYbzuaV0RtvpV6enE=
=rerW
-----END PGP SIGNATURE-----

--DKxQPO6mPHJhwdJQ5Iid75rrV0uFDahWL--
