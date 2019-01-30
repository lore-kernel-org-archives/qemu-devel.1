Received: from eggs.gnu.org ([209.51.188.92]:51822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gozMW-0004AA-4W
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 18:33:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gozMV-0005RQ-2J
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 18:33:44 -0500
Date: Thu, 31 Jan 2019 09:54:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190130225400.GF1771@umbus.fritz.box>
References: <20190128212157.424-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MZf7D3rAEoQgPanC"
Content-Disposition: inline
In-Reply-To: <20190128212157.424-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 0/2] qemu-macppc patches
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


--MZf7D3rAEoQgPanC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 09:21:55PM +0000, Mark Cave-Ayland wrote:
> Here's the contents of my qemu-macppc branch: just two minor patches cons=
isting of
> an update to MAINTAINERS, plus bringing in updated binaries containing bu=
gfixes
> for Ben's MacOS NDRV VGA driver.

Applied to ppc-for-4.0, thanks.

Sorry for the delay, I had been intending to merge this in from your
git tree as discussed, but hit some conflicts that I didn't get around
to resolving.

> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>=20
> Mark Cave-Ayland (2):
>   MAINTAINERS: add myself as maintainer for Mac Old World and New World
>     machines
>   QemuMacDrivers: update qemu_vga.ndrv to 90c488d built from submodule
>=20
>  MAINTAINERS           |   6 ++++--
>  pc-bios/qemu_vga.ndrv | Bin 14752 -> 18752 bytes
>  roms/QemuMacDrivers   |   2 +-
>  3 files changed, 5 insertions(+), 3 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MZf7D3rAEoQgPanC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxSKwcACgkQbDjKyiDZ
s5LdIRAAguV39oLc6uCp/0DIJj2WhReys5tsJunkPCGIrO2BCR17Wqz20amKngT5
2p9ycsDK8TuSY2hKTyegUC88wcGMM871Wld8MK0vzsXV7hc9LLST4gTEZz27wQVN
4fBbCYZkgCB3V5WFugt992xfRcJ51d/ZM95h+zxC9EaWrbrzie6gff0fIh7O6GgX
eSmf6PzxbxvjHAZ+A++PDd0umZjljeicKuc5hFuas6nkiEQ0PmrmYUX6xDy1PeXA
XlEiYlW+JdntmXZfURNQqrPTOiscWVcIyRCQ5AHLeFGZ7c0s4T4v1Fw6pts74hDe
k4ObuZcKTIVs7bF6K9L/UHyxCrwAo2gqB756vtrVNy3UkuYPOn88PFS6rezutKBy
bnczbdVgXx4f9tTM+gkRrgQ+xtHlR1XEU4r1FywFu6Rqdf4+wpI+0HxyLacUVeLQ
/8TUwUDjc/AxsNnJzdq3lp29h0WA4rkWIsvoIO8YN3c+WSVbDFbFfZebGvo5Ltof
gmExu8gGepQYo9XshR5dsROBTWGZrueyKz/0Hac4cPVdKK3ymjA4ifQ30pYCT1EF
iJUb4Al31CXTHTbxahnAcTuE9OeT6bMLYlFc6KFxTD3cj9JwWg8aIHHB5PwCYQ+e
QbyNSshoFBb+d2QDnM9ABEXoAYgQZYXVUtjb2DlUGTw7jFHW/U8=
=JTX0
-----END PGP SIGNATURE-----

--MZf7D3rAEoQgPanC--
