Received: from eggs.gnu.org ([2001:4830:134:3::10]:59536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drsY8-0003LT-1x
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:16:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drsY7-0007gF-2d
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:16:52 -0400
References: <20170912144459.11359-1-pbonzini@redhat.com>
	<20170912144459.11359-7-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <166503a6-1fac-2ff4-4f35-d8024b9f7d94@redhat.com>
Date: Tue, 12 Sep 2017 16:16:45 -0500
MIME-Version: 1.0
In-Reply-To: <20170912144459.11359-7-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oHATjejlE1vE49HehjbqkK3DLWwOXoUjg"
Subject: Re: [Qemu-devel] [PATCH 06/10] qemu-iotests: do not include
 common.rc in "check"
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
--oHATjejlE1vE49HehjbqkK3DLWwOXoUjg
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <166503a6-1fac-2ff4-4f35-d8024b9f7d94@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/10] qemu-iotests: do not include common.rc
 in "check"
References: <20170912144459.11359-1-pbonzini@redhat.com>
 <20170912144459.11359-7-pbonzini@redhat.com>
In-Reply-To: <20170912144459.11359-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2017 09:44 AM, Paolo Bonzini wrote:
> It only provides functions used by the test programs.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/qemu-iotests/check     |  6 ------
>  tests/qemu-iotests/common.rc | 13 +++++--------
>  2 files changed, 5 insertions(+), 14 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--oHATjejlE1vE49HehjbqkK3DLWwOXoUjg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm4Tr0ACgkQp6FrSiUn
Q2p02AgAjh+O9nnvbh2BuJB1IS6ARr28OgKfCM//j6w/Z0UjVGc1IapIw6v8voap
e9G7y/N/qvPNnScFSCJIOKmtXIpUaLxc9naTQAeuorVyeI0wsrBqZdojtif0Puf5
rPAJZrwFxP2d98vLHtwQcA/EK6f/wBwsdBGj8oZ74ZVQSXbkawAulzvcl+rhxRhH
UfgFRTNaqNnhF4YFRo1K3iarMmdCsSnn3yeQn0SSbOYLrVE3Ui4oBmXbR4/KBkBh
P+oSI3vV2WtyTwsVKRqkai8tqor5L4kRnBY0l3NIE4j/SARkS1Hu+m7MUJcVfE6m
dUNSAT0pi+iCCFumziPcEz/xMZYQdQ==
=7nEv
-----END PGP SIGNATURE-----

--oHATjejlE1vE49HehjbqkK3DLWwOXoUjg--
