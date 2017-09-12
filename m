Received: from eggs.gnu.org ([2001:4830:134:3::10]:45504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drs4E-0008Vf-Hd
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 16:45:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drs4D-0005LB-Jt
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 16:45:58 -0400
References: <20170912144459.11359-1-pbonzini@redhat.com>
	<20170912144459.11359-3-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <17c3dda1-3e2d-d84b-0d97-4eaca4cfe9f6@redhat.com>
Date: Tue, 12 Sep 2017 15:45:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170912144459.11359-3-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wiKCqjh2TOe7AnNIdlGRNHqhV6CaCOgsu"
Subject: Re: [Qemu-devel] [PATCH 02/10] qemu-iotests: get rid of AWK_PROG
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
--wiKCqjh2TOe7AnNIdlGRNHqhV6CaCOgsu
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <17c3dda1-3e2d-d84b-0d97-4eaca4cfe9f6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/10] qemu-iotests: get rid of AWK_PROG
References: <20170912144459.11359-1-pbonzini@redhat.com>
 <20170912144459.11359-3-pbonzini@redhat.com>
In-Reply-To: <20170912144459.11359-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2017 09:44 AM, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/qemu-iotests/check         | 4 ++--
>  tests/qemu-iotests/common        | 2 +-
>  tests/qemu-iotests/common.config | 3 ---
>  3 files changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wiKCqjh2TOe7AnNIdlGRNHqhV6CaCOgsu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm4R3wACgkQp6FrSiUn
Q2pSOAf/ZkMiwE6yJZyhUHzwW0zgRxY0DN0x7fzcXn3qKss7ajcfNjP/aQpkaf38
kwqil0V+BT2t1e/aqHIW5aPh/kGnA94yzWNNc0fWQqpvKLt68UREnTZPFAuqvrOf
UiHKZfetqmYzkyOQpSMNKbVAr1Q3YivUaFe0CKlJtKFnUhhwxMx7X9taXDUDMdy1
iZHq1IDd5k+K3WNAuKkrISUou6i91NHo7BOlhcw9jOzi8CCUS8n6fAYmWcbh7Nvc
bcq69pGhMH2u0l1/ZyE6AzJ/dGElC7HW9mMIbrBukWg3WocMIBIwYhG4npJ/Pddi
Qs0e9Ii8y8xg0CgtyHSj9Rp0l4VM/Q==
=pfm/
-----END PGP SIGNATURE-----

--wiKCqjh2TOe7AnNIdlGRNHqhV6CaCOgsu--
