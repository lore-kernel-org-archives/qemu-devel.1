Received: from eggs.gnu.org ([2001:4830:134:3::10]:41471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehd8I-0006vm-Cw
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:20:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehd8B-000561-VH
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:20:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehd8B-00053W-M2
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:19:59 -0500
References: <1517582668-10923-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1517582668-10923-4-git-send-email-stefanb@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e43dcefa-51dd-80de-a4e7-77717cdf9661@redhat.com>
Date: Fri, 2 Feb 2018 09:09:50 -0600
MIME-Version: 1.0
In-Reply-To: <1517582668-10923-4-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pflEGuOvaK2XCxnb9HGpBwc5Ox8vRYhvQ"
Subject: Re: [Qemu-devel] [PATCH 3/4] MAINTAINERS: add pointer to tpm-next
 repository
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pflEGuOvaK2XCxnb9HGpBwc5Ox8vRYhvQ
From: Eric Blake <eblake@redhat.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Message-ID: <e43dcefa-51dd-80de-a4e7-77717cdf9661@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] MAINTAINERS: add pointer to tpm-next
 repository
References: <1517582668-10923-1-git-send-email-stefanb@linux.vnet.ibm.com>
 <1517582668-10923-4-git-send-email-stefanb@linux.vnet.ibm.com>
In-Reply-To: <1517582668-10923-4-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 08:44 AM, Stefan Berger wrote:
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f8deaf6..d352d16 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1593,6 +1593,7 @@ F: include/hw/acpi/tpm.h
>  F: include/sysemu/tpm*
>  F: qapi/tpm.json
>  F: backends/tpm.c
> +T: git git://github.com/stefanberger/qemu-tpm.git tpm-next
> =20
>  Checkpatch
>  S: Odd Fixes
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pflEGuOvaK2XCxnb9HGpBwc5Ox8vRYhvQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0fz4ACgkQp6FrSiUn
Q2plQAgAj2HAdi6ZygbsakZM3WxL9o7gxzNAgTwCQzBxfaOnSwF3HUFTCc22RP+O
cbQt03XiX+HIZp2twxTazd+MK1d2aNmK/cytUf4KvVeuYbd9t9jHnBDWwPk3Tdqu
UXYH4YX/KBh+odiiSp1J8DVGHwukdFOIXH0EnhhXLaQz9TLsay7xzMqkNdPiwhiU
zR4PT1VIBU0x3cdgiIb1Y/AcgmJx/YXSmh9i0JQC8qvSt8fYgcPKmu/xArcmOo6m
4Q+J655Q+i3idCk4z5vF5bN7NGdi4WrU92ilnrh2ZZBsKggHDudrKdFbqJeZ4Q5W
/gOq3kn3dFd6T14CmgT1YghdKYQk0A==
=acD4
-----END PGP SIGNATURE-----

--pflEGuOvaK2XCxnb9HGpBwc5Ox8vRYhvQ--
