Received: from eggs.gnu.org ([2001:4830:134:3::10]:37066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecXl5-0001jw-Kp
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:35:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecXl1-0003WX-Ic
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:35:07 -0500
References: <20180119103233.26075-1-lvivier@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <35f2a7e0-7926-f3b5-017f-ad769eff854d@redhat.com>
Date: Fri, 19 Jan 2018 08:34:57 -0600
MIME-Version: 1.0
In-Reply-To: <20180119103233.26075-1-lvivier@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Hro2GlSoQ4hGMFtxKbWPtkz7ZutmTIc1r"
Subject: Re: [Qemu-devel] [PATCH] build: fix typo in error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hro2GlSoQ4hGMFtxKbWPtkz7ZutmTIc1r
From: Eric Blake <eblake@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org
Message-ID: <35f2a7e0-7926-f3b5-017f-ad769eff854d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] build: fix typo in error message
References: <20180119103233.26075-1-lvivier@redhat.com>
In-Reply-To: <20180119103233.26075-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2018 04:32 AM, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  scripts/git-submodule.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Duplicate of:
https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg04178.html
https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03875.html
https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03798.html


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Hro2GlSoQ4hGMFtxKbWPtkz7ZutmTIc1r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpiAhEACgkQp6FrSiUn
Q2qBLwgAqhHSnY/hZpEGDJpEob4YWjWGEBxviPfLntj7I5qiCAEki7SQrc9rke44
XEAtXOYKlcyGsFZ7BT8C4RcWACiLvoi5LkmLhMaNgvz/uGIlRz1pCMK7TyJbWgF9
SfXEK2fSE86PJWhwtZ9qgyRIyGmBz4sMpexRvPApm4samr84RyqsRS8ejIYV3WiW
wPnVIZuZZRkk+UfptKxUokPoCpBQtAdZi8u4UohnbkmTNYk2pM5BMxByDBCYVQBx
fDGAVZE688i/RBQnY9hRaoBos81kKNXyu36vAzoFCRPUqP9uJb3r+WAOUNCzgw66
Bww0EE9bu1v9yyI+39bE/J3vfV8fhg==
=dnkU
-----END PGP SIGNATURE-----

--Hro2GlSoQ4hGMFtxKbWPtkz7ZutmTIc1r--
