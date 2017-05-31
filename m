Received: from eggs.gnu.org ([2001:4830:134:3::10]:56398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGAsJ-0004Ql-Hq
	for qemu-devel@nongnu.org; Wed, 31 May 2017 17:09:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGAsI-0000xB-LC
	for qemu-devel@nongnu.org; Wed, 31 May 2017 17:09:51 -0400
References: <20170531094330.1808-1-pbonzini@redhat.com>
	<20170531094330.1808-6-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d093f3e0-6bfe-adbd-a140-57f16ae63e6d@redhat.com>
Date: Wed, 31 May 2017 16:09:40 -0500
MIME-Version: 1.0
In-Reply-To: <20170531094330.1808-6-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DFQ3XQaIV1gqgBrRvQmBUdqKp0dG1i4I7"
Subject: Re: [Qemu-devel] [PATCH 05/11] vvfat: make it thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DFQ3XQaIV1gqgBrRvQmBUdqKp0dG1i4I7
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Message-ID: <d093f3e0-6bfe-adbd-a140-57f16ae63e6d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/11] vvfat: make it thread-safe
References: <20170531094330.1808-1-pbonzini@redhat.com>
 <20170531094330.1808-6-pbonzini@redhat.com>
In-Reply-To: <20170531094330.1808-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/31/2017 04:43 AM, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/vvfat.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DFQ3XQaIV1gqgBrRvQmBUdqKp0dG1i4I7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLzEUAAoJEKeha0olJ0NqjSoH/3Oz4gw03G+BpqP/Hpubb1ie
HKGW25IXjN9VIpoff1csSWFIEW6bKavSUxclxtVQyznobFlO+cRRvlm9eViwf8xF
6NvTSJf7H3G4c/y6JrGAC4ABQIPJ7ugUBKPDDWc2Xd3flWLamFZZgkoSJjcb3htD
BxFLqPkW6Qs8yUIeIBrAsEDi/1P0JDLjC8/I6Zv1SE/jP/O/ah23EJHp0N+CqEX4
BrDp3wn4BpAO3ihdKMuLHjvUK9fQWPeWVEZPHYeWgCroD3oQ/zLFHiD64MwFCtR9
B8hIMZsc9bYnZVbwSqgHdK8yPL3NN8zVl6OHWhmpT/55e47DIL46QjwG+z39cEc=
=BQUA
-----END PGP SIGNATURE-----

--DFQ3XQaIV1gqgBrRvQmBUdqKp0dG1i4I7--
