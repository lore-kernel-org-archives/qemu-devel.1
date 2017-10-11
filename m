Received: from eggs.gnu.org ([2001:4830:134:3::10]:38337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2Ooh-0007MD-OS
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 17:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2Ood-0001JV-Qr
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 17:45:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e2Ood-0001Ii-Hh
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 17:45:23 -0400
References: <1507757851-12580-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <82a444dd-3ed4-967a-d29f-e4c04170f776@redhat.com>
Date: Wed, 11 Oct 2017 16:45:20 -0500
MIME-Version: 1.0
In-Reply-To: <1507757851-12580-1-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iLvo1gsrX92Fxp35rD0stVk4apqmKEau0"
Subject: Re: [Qemu-devel] [RFC PATCH 0/4] tpm: Extend TPM with state
 migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, marcandre.lureau@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iLvo1gsrX92Fxp35rD0stVk4apqmKEau0
From: Eric Blake <eblake@redhat.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, marcandre.lureau@gmail.com
Message-ID: <82a444dd-3ed4-967a-d29f-e4c04170f776@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/4] tpm: Extend TPM with state migration
 support
References: <1507757851-12580-1-git-send-email-stefanb@linux.vnet.ibm.com>
In-Reply-To: <1507757851-12580-1-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/11/2017 04:37 PM, Stefan Berger wrote:
> This set of patches implements support for migrating the state of the
> external 'swtpm' TPM emulator. I have primarily tested this with TPM 1.=
2
> so far.
>=20
> This series of patches builds on top of the recent pull request

Just to make sure patchew knows what you mean:

Based-on:
https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg02050.html
[PULL v2 00/10] Merge tpm 2017/10/04

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--iLvo1gsrX92Fxp35rD0stVk4apqmKEau0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnekPAACgkQp6FrSiUn
Q2ruSQf9GV4ofnNRB7KzUnVg4LFMnrgtFaHGmWhd0SFY6K0CtlV+g7nb+R1P+a/z
pkzJZEJ2kJOTADCx2xpJvbCWuITkyucPwcsL+ybdJERQK6bAHCH9LfTF7jWYYHa0
6CYm5jTZl2pqbHa/W1cB1M1/4zTXaVLApsejgyqwd5UVdDkZ6Ix318AFMxjIIDin
+s8pRwvp8AFhFG1T1onmLdKrpYq4NQcYuEN15JsyCGffQD2MOVdS/HrXne94phl/
dUTa0jPDoRopAX+8+G6ZF2wlRRKvoXZdeNncnYAEkwl4JhASj349wMDMLDGyM1rg
byVK7ABsdKSs0QumvgpQ+TEv340gOg==
=lW+m
-----END PGP SIGNATURE-----

--iLvo1gsrX92Fxp35rD0stVk4apqmKEau0--
