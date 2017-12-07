Received: from eggs.gnu.org ([2001:4830:134:3::10]:40315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN4ps-0003U8-5D
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 17:40:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN4pr-0007B2-6f
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 17:40:08 -0500
References: <20171207201320.19284-1-stefanha@redhat.com>
	<20171207201320.19284-5-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2ca3535a-34d8-a47d-c87d-d7cc36a53b2c@redhat.com>
Date: Thu, 7 Dec 2017 16:39:59 -0600
MIME-Version: 1.0
In-Reply-To: <20171207201320.19284-5-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iIlETXN7DHMvPOkGIBgHvWDBB2QwfCSPt"
Subject: Re: [Qemu-devel] [PATCH v2 4/6] iotests: add VM.add_object()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iIlETXN7DHMvPOkGIBgHvWDBB2QwfCSPt
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2ca3535a-34d8-a47d-c87d-d7cc36a53b2c@redhat.com>
Subject: Re: [PATCH v2 4/6] iotests: add VM.add_object()
References: <20171207201320.19284-1-stefanha@redhat.com>
 <20171207201320.19284-5-stefanha@redhat.com>
In-Reply-To: <20171207201320.19284-5-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2017 02:13 PM, Stefan Hajnoczi wrote:
> The VM.add_object() method can be used to add IOThreads or memory
> backend objects.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 5 +++++
>  1 file changed, 5 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--iIlETXN7DHMvPOkGIBgHvWDBB2QwfCSPt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlopwz8ACgkQp6FrSiUn
Q2oVaAf9GSpdbbtLU6TJd7B4BYA64XrunVMz+6N7+5NylbYy2KVrjDnSnbaTnQev
6XZDjvM2990PyQxGjx2tqvKwTJBGmqTXuCMK70NIyk7F3pIW3qL+c3QQsRXNiYw7
mWZUVmcAFAh2M1aqkgYx5h8/ymjWY3IWPFx/q0IHJdbDko5831xSu9/Ste15XLDz
oeABTh5EWEqgMpTVlsjB54WvWI0LF22pXk8XJZYw0nfY+R6IhMFIX4dFnqWy6NGn
RS5IDvjrQjRMCQLQYYDK1ONgmtdX+vb1YK4n4Jzpgw6S+OQ0UzBXUphU7dN/Mglu
TgwMfQEqhO0UArxLlG5yvlrZaF2Lqg==
=1Zi+
-----END PGP SIGNATURE-----

--iIlETXN7DHMvPOkGIBgHvWDBB2QwfCSPt--
