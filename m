Received: from eggs.gnu.org ([2001:4830:134:3::10]:47759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daUFP-00031U-1f
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:53:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daUFL-0005bo-3H
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:53:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1daUFK-0005bW-Pv
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:53:35 -0400
References: <20170726214010.420-1-f4bug@amsat.org>
	<20170726214010.420-3-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a5899865-3d8b-5ac5-2375-eaced816bf13@redhat.com>
Date: Wed, 26 Jul 2017 16:53:31 -0500
MIME-Version: 1.0
In-Reply-To: <20170726214010.420-3-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fOM306hhSMteanMPbgNc1fmtpuFlWsDxl"
Subject: Re: [Qemu-devel] [PATCH for 2.10 2/4] fdt: check fdt_required
 condition can be satisfied _after_ testing libfdt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, John Arbuckle <programmingkidx@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: James Hogan <james.hogan@imgtec.com>, Juan Quintela <quintela@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Yongbok Kim <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fOM306hhSMteanMPbgNc1fmtpuFlWsDxl
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 John Arbuckle <programmingkidx@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: James Hogan <james.hogan@imgtec.com>, Juan Quintela
 <quintela@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 qemu-devel@nongnu.org, Yongbok Kim <yongbok.kim@imgtec.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <a5899865-3d8b-5ac5-2375-eaced816bf13@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.10 2/4] fdt: check fdt_required
 condition can be satisfied _after_ testing libfdt
References: <20170726214010.420-1-f4bug@amsat.org>
 <20170726214010.420-3-f4bug@amsat.org>
In-Reply-To: <20170726214010.420-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/26/2017 04:40 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  configure | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fOM306hhSMteanMPbgNc1fmtpuFlWsDxl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll5D1sACgkQp6FrSiUn
Q2qELAf+MVnyuqFPF3gmOBdDofige23j0Uplk5Wyfn7j8+5s/CfFT9ytZbasozru
fef5xhiOtZJ6pAUoRopp1BlRFEM/I+wTBnKeD3T8nE6CoR/SPPFe6l+RH+Rt0fEQ
sudca3XhW1FzcBaMGFFQ/ExE6AYFH2W2rPfRV/S4t6F1ODWcLvow7XofbhLFxHKI
rebeqjGV1lh5JTKUV/dXQCiKVUwreXNCOjxFy/4r+pprt5E5RDix2j/dqi5NkzDb
7dPFF91uEGe6CDPm61ynDSF0c4Eo3ST+DYoSpx4oZwezyOSSDtpH64Pbpv8r7W1z
xtk9JrrosJ774kDaUbMXPYtYyPPTmw==
=1VCI
-----END PGP SIGNATURE-----

--fOM306hhSMteanMPbgNc1fmtpuFlWsDxl--
