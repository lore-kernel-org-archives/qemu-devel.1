Received: from eggs.gnu.org ([209.51.188.92]:55269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqs5e-0000k1-PI
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 23:12:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqs5d-0004uI-TQ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 23:12:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gqs5d-0004tt-Kq
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 23:12:05 -0500
References: <154933968376.29184.4083651247596634131@ebba9967afc0>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9fb0f6e7-859b-eb06-48e7-d374de2e6e54@redhat.com>
Date: Mon, 4 Feb 2019 22:12:03 -0600
MIME-Version: 1.0
In-Reply-To: <154933968376.29184.4083651247596634131@ebba9967afc0>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pPqGnemlJYFRw0ZfZxir5YrWR6S3CalJo"
Subject: Re: [Qemu-devel] [PULL 0/8] NBD patches for 2019-02-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pPqGnemlJYFRw0ZfZxir5YrWR6S3CalJo
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net
Message-ID: <9fb0f6e7-859b-eb06-48e7-d374de2e6e54@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/8] NBD patches for 2019-02-04
References: <154933968376.29184.4083651247596634131@ebba9967afc0>
In-Reply-To: <154933968376.29184.4083651247596634131@ebba9967afc0>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/4/19 10:08 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190205035704.26014-1-eblake@red=
hat.com/
>=20
>=20
>=20
> Hi,
>=20
> This series seems to have some coding style problems. See output below =
for
> more information:
>=20

> 2/8 Checking commit bd906b01ffe8 (nbd: generalize usage of nbd_read)
> ERROR: spaces required around that '*' (ctx:WxV)
> #85: FILE: include/block/nbd.h:356:
> +                                 uint##bits##_t *val,                 =
  \
>                                                  ^
>=20
> total: 1 errors, 0 warnings, 386 lines checked
>=20
> Patch 2/8 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.

False positive. Seeing past ## pasting in a macro is not trivial to fix
in checkpatch, so I'm intentionally ignoring this one.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--pPqGnemlJYFRw0ZfZxir5YrWR6S3CalJo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxZDRMACgkQp6FrSiUn
Q2p0aAf+JweCYCMWEacrcEKYVzCP8no7oQRaqsPHMWd0LYrxhYPqwJf9BXRgT9W5
PRnu2SpfIdwqUkydlu/qCm3ijHI+7hyBrIZ17t90hcZNiUxFg9zQn7dhuvimRH9y
9lwy9InkZKxOV0VWpwUmAV+w5GQDScQ5aLui9+LbcRUUCRTPZSlBuYG68Cavi7lJ
nHEpUK0nbEVrr+bIRvW8Cq0MyLpA97K2iEnu7sgbpLs3EBxTSkqFt+AKzk8m2bun
07FgOi3n9LPvk/rnsE/f7qomCeOZah5CG6ohK5F9Cq6XepkZR0UvI498lCXXLfpd
UDMul+cHia1ESlfHCITRs3wc4o2BkQ==
=8wPs
-----END PGP SIGNATURE-----

--pPqGnemlJYFRw0ZfZxir5YrWR6S3CalJo--
