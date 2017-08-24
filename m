Received: from eggs.gnu.org ([2001:4830:134:3::10]:45475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkuM1-00068j-BA
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:47:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkuM0-0007Hn-Mu
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:47:33 -0400
References: <20170822131832.20191-1-pbonzini@redhat.com>
	<20170822131832.20191-7-pbonzini@redhat.com>
	<1259373f-69cb-adcd-7f85-73930dc709bc@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5995ba84-a99f-f430-3ca6-1be3985c5d04@redhat.com>
Date: Thu, 24 Aug 2017 17:47:20 +0200
MIME-Version: 1.0
In-Reply-To: <1259373f-69cb-adcd-7f85-73930dc709bc@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wwojwaLL4K9LAapmfxanmUDTmf6Go1RhM"
Subject: Re: [Qemu-devel] [PATCH 06/10] scsi,
 file-posix: add support for persistent reservation management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wwojwaLL4K9LAapmfxanmUDTmf6Go1RhM
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org
Message-ID: <5995ba84-a99f-f430-3ca6-1be3985c5d04@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/10] scsi, file-posix: add support for
 persistent reservation management
References: <20170822131832.20191-1-pbonzini@redhat.com>
 <20170822131832.20191-7-pbonzini@redhat.com>
 <1259373f-69cb-adcd-7f85-73930dc709bc@redhat.com>
In-Reply-To: <1259373f-69cb-adcd-7f85-73930dc709bc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24/08/2017 17:37, Eric Blake wrote:
>>  #
>>  # @filename:    path to the image file
>> +# @pr-manager:  the if for the object that will handle persistent res=
ervations
> s/if/interface/ for legibility
>=20

"id" actually.

Paolo


--wwojwaLL4K9LAapmfxanmUDTmf6Go1RhM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlme9QgACgkQv/vSX3jH
roMz2wf+LlqZeAbW6qbRYHfl00Qss2ADt3/lNQyRCd+5u++S54QzCrnd2ZSaaCuK
v3hR9OvtFI1dVVD18aN4MbZ4xUt8gI1CZ3RD+Vkb8Ha8FAnUuforO1rvpcyZDp7+
Ze7aizx8t2/PgjQNDnrq9xHTjAM0CNZvHcbz8ScwOiP7m6q0MC1goLFJ6+eh05Pt
KrMs0CZSpmAMXOGWvq/7GX+/iL7L8mEPEwc+aBpsEk8wAtSYS3iJSvFDVaTRMYMZ
bUp8HRueX0+3H+7jJMHoiJLFdHRFWubj5oLdZ2msXtNxqlSE5+CEQpDiJLdmL+J+
FMoMj0Fp2rbakzgKAKL9CJqmPgyUrA==
=rZlP
-----END PGP SIGNATURE-----

--wwojwaLL4K9LAapmfxanmUDTmf6Go1RhM--
