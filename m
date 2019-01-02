Received: from eggs.gnu.org ([208.118.235.92]:37660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geqr6-000558-6M
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 19:27:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geqr1-0005Fh-DH
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 19:27:24 -0500
Date: Thu, 3 Jan 2019 10:45:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190102234544.GC10853@umbus.fritz.box>
References: <20190102102243.28822-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
In-Reply-To: <20190102102243.28822-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: add qemu_vga.ndrv file entry
 for Mac machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 10:22:43AM +0000, Mark Cave-Ayland wrote:
> The VGA driver built from Ben's QemuMacDrivers repository is used exclusi=
vely
> by the Mac machines.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied, thanks.

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 344cb2d7fd..3da3d103b1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -965,6 +965,7 @@ F: include/hw/misc/macio/
>  F: include/hw/misc/mos6522.h
>  F: include/hw/ppc/mac_dbdma.h
>  F: include/hw/pci-host/uninorth.h
> +F: pc-bios/qemu_vga.ndrv
> =20
>  Old World
>  M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> @@ -976,6 +977,7 @@ F: hw/pci-host/grackle.c
>  F: hw/misc/macio/
>  F: hw/intc/heathrow_pic.c
>  F: include/hw/intc/heathrow_pic.h
> +F: pc-bios/qemu_vga.ndrv
> =20
>  PReP
>  M: Herv=E9 Poussineau <hpoussin@reactos.org>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwtTScACgkQbDjKyiDZ
s5I67BAAq1paFctLz47PY3huMIuyj2dlJWqThE71gD3TxunMHoDLGPDEpBYq2kXE
HYNLhmQLZO2CsE2MDIXUlB3YgGa9T3VPRaT0/EN5RLpILOQ0H8gpjvOxgPTCgyVY
BbGNDNYu5/4FURRLPCFnrHEmuXgpzar4xMpg0X5Zs2Q7PkSuMoWAPogfs2oPJjnJ
zlMcJUhzZhUooqiMzL5hRYpBUdcGgsdnr0cWYJh1l2wR6Z7iIdmSlvrIF+1ogcXQ
16aBOYkQgN2Sf2Ao6kok54ITPmUB/tyqbBf6aGb2Bekby8MktKZppdWiHtENt5aB
gmgkRc/yUTsELRj1P+Ug7/44cyt1cv/c9hol29uknUXzLBsV444KCotIisvlDY13
0X6mqyeTfffgNMPcr8VahX/L2VSrTNanYzp4exDlOwXqHl+R9VhTdXluFK2y577/
xIM6Z/sLsulGyFWflx+CZkdqDKNbazpuaK1TC/FTExn64kR/krcPbSfrERrguDHF
81ZA3n+EuigBhIA+0FlKRBzN9Tav7M7EWsExcqSyXHleISxh2W0y5SNradf5LOUx
kIxC0DF1SQ2yfWS7oPiWurz6ucF56dx68U2bo7DG2yTVw7QdLmXXf7wBGLh4xfIu
F5HBpWuL40c7a6cIhkPP61Eci5Rydh3y+4TpikJwt6D9o+RaiKg=
=CZw0
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
