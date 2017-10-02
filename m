Received: from eggs.gnu.org ([2001:4830:134:3::10]:39605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz1HQ-0004i4-Bx
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz1HN-0002wL-6G
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:01:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dz1HM-0002vr-TY
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:01:05 -0400
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<db884cd8f27fa0144630bdb07f6d00dbf57f38ac.1506730372.git.alistair.francis@xilinx.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3ffe6032-3699-de61-e0ae-1efe7b5443a5@redhat.com>
Date: Mon, 2 Oct 2017 09:00:58 -0500
MIME-Version: 1.0
In-Reply-To: <db884cd8f27fa0144630bdb07f6d00dbf57f38ac.1506730372.git.alistair.francis@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pIDkLbHTwFwATEKm070HcwvPl72tQpeXI"
Subject: Re: [Qemu-devel] [PATCH v2 02/47] Fixes after renaming __FUNCTION__
 to __func__
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, armbru@redhat.com
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pIDkLbHTwFwATEKm070HcwvPl72tQpeXI
From: Eric Blake <eblake@redhat.com>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, armbru@redhat.com
Message-ID: <3ffe6032-3699-de61-e0ae-1efe7b5443a5@redhat.com>
Subject: Re: [PATCH v2 02/47] Fixes after renaming __FUNCTION__ to __func__
References: <cover.1506730372.git.alistair.francis@xilinx.com>
 <db884cd8f27fa0144630bdb07f6d00dbf57f38ac.1506730372.git.alistair.francis@xilinx.com>
In-Reply-To: <db884cd8f27fa0144630bdb07f6d00dbf57f38ac.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/29/2017 07:15 PM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Eric Blake <eblake@redhat.com>
> ---
>=20
>  hw/arm/omap1.c     | 4 ++--
>  hw/arm/omap2.c     | 2 +-
>  hw/block/onenand.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pIDkLbHTwFwATEKm070HcwvPl72tQpeXI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnSRpoACgkQp6FrSiUn
Q2oyuwgAmWyulWzqgeKXUcfH2RYKOlfkqTe23ck6dLDTqby4jZy50jBl2U3ufmUi
YIg1eG/g4GXK6z7wnbF4Q50wBbWfMRh6liVZfm6mA/cZFb3Bz7VsBB4TABi6ts2E
QU7MpQLFAQrCptvCqGvkrd8AyQgix4ZyLRGBiV6vH1tzOF8PLOhX5HZqaIxHhlFK
rM6CiVd6QFT5nG22RHwwIb/RO75NOlUWsC5/pkBg6jUssMuqQps6NtE36eGlAUhX
lrFbAG51gfTtdKfAC7PDzknofUX2JRepDLK7gb92/wGwAMW5HmPXsRVjHqy8IABz
FydiztOjoq/VPdfB80cphL2qRNrfpQ==
=ojV5
-----END PGP SIGNATURE-----

--pIDkLbHTwFwATEKm070HcwvPl72tQpeXI--
