Received: from eggs.gnu.org ([2001:4830:134:3::10]:34749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRp0I-0008Ez-E5
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRp0E-0001xX-Lg
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:41:58 -0500
Date: Fri, 13 Jan 2017 10:30:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170112233031.GD13656@umbus.fritz.box>
References: <1484210849-27697-1-git-send-email-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Content-Disposition: inline
In-Reply-To: <1484210849-27697-1-git-send-email-hpoussin@reactos.org>
Subject: Re: [Qemu-devel] [PATCH] ppc/prep: update MAINTAINERS file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2017 at 09:47:29AM +0100, Herv=E9 Poussineau wrote:
> Signed-off-by: Herv=E9 Poussineau <hpoussin@reactos.org>

Merged to ppc-for-2.9.

> ---
>  MAINTAINERS | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1444b26..f4b02ab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -657,10 +657,13 @@ F: hw/misc/macio/
>  F: hw/intc/heathrow_pic.c
> =20
>  PReP
> +M: Herv=E9 Poussineau <hpoussin@reactos.org>
>  L: qemu-devel@nongnu.org
>  L: qemu-ppc@nongnu.org
> -S: Odd Fixes
> +S: Maintained
>  F: hw/ppc/prep.c
> +F: hw/ppc/prep_systemio.c
> +F: hw/ppc/rs6000_mc.c
>  F: hw/pci-host/prep.[hc]
>  F: hw/isa/pc87312.[hc]
>  F: pc-bios/ppc_rom.bin

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYeBGVAAoJEGw4ysog2bOSS/4P/3Fnm56781mlW3AjPF7o07Fe
NsqKb/TyRf2/mm9DU1YadLqO6wJ9nYG2i97x5gEl5b3raCi3fqtS3XD8mYVlD0Yh
3i7J8Ye+kiMheN05czq9T5O3suxGzhLhRybETF/3Vktelmdp3aIiTsNq3BPxuwNs
dr0YNpw7NmXBbYmGnwC/5cMkDalgOvED/7l8qaGTY6oR5fIvAXjzlCU7PreKQ+hv
uwa13CTifxXU8nta5kcgOKeSMbLDkghkPgFnWWUqKDEMrXwjtEw4MMvrAXZlM9PN
1Cg0rw6CWDUnscNtDY9OIwOVwVo0MtmHWyWzIf3As7TGNRmXn7OsTSb26xCz7FEw
oCBQqGZslREZEn5hlW5Ft3AGQ94Nt02Nny96lHTlYmPgh0E9hEaHt30+z5OKpBp2
sHj1ulS9FuarAvJ9d1Nc6W4AAmoxOIuBgWsKdqSGIPY8OUtsRQR/RfYvUuUSDzPK
ddj+D/fwbW+nCiY/sWIhBm0GMM54A1gCS0qWSp704/UDu+M/qXdQu2O5rVQjkZCO
gbT+NMcS4bF0N/E7i08HaeQplQ8XTeocOBVIxgjou42wPefIpoR7n3jTleIJ6YQO
4LcwWOdG9ExHNTOTETtK+wsizXrtQdYTY3/dcGpCvj4EsbsTHmTLFXWONdwFYvOI
xeB6W5iPIQgOeesgUBtd
=t5pz
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--
