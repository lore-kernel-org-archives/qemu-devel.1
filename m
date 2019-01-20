Received: from eggs.gnu.org ([209.51.188.92]:42131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1glN1P-0001bP-Gw
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 19:01:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1glN1O-0006FD-M1
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 19:00:59 -0500
Date: Mon, 21 Jan 2019 10:57:02 +1300
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190120215702.GC2423@umbus>
References: <20190114081454.9991-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
In-Reply-To: <20190114081454.9991-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [GIT PULL for qemu-pseries] pseries: Update SLOF
 firmware image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2019 at 07:14:54PM +1100, Alexey Kardashevskiy wrote:
> The following changes since commit 27df21ca3886fff4dd3d70e515517667963a52=
f1:
>=20
>   Merge remote-tracking branch 'remotes/kraxel/tags/misc-20190111-pull-re=
quest' into staging (2019-01-11 16:45:59 +0000)
>=20
> are available in the Git repository at:
>=20
>   git@github.com:aik/qemu.git tags/qemu-slof-20190114
>=20
> for you to fetch changes up to c4560a5144a01ebda98830cfa3203ce26a020386:
>=20
>   pseries: Update SLOF firmware image (2019-01-14 18:06:53 +1100)

Merged, thanks.

>=20
> ----------------------------------------------------------------
> qemu-slof-20190114 signed update
>=20
> ----------------------------------------------------------------
> Alexey Kardashevskiy (1):
>       pseries: Update SLOF firmware image
>=20
>  pc-bios/README   |   2 +-
>  pc-bios/slof.bin | Bin 974544 -> 926392 bytes
>  roms/SLOF        |   2 +-
>  3 files changed, 2 insertions(+), 2 deletions(-)
>=20
>=20
> *** Note: this is not for master, this is for pseries
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxE7qwACgkQbDjKyiDZ
s5LPyBAAo0CWpz1CRiNn40z/QDaIOG9ln2Sqn6Lcts3bsIAR+oOamYoXvRwMhmCv
g4YVZHV1QBJGAflOQk9oy8YHaqB6c+620sF5SU3Et/sXZe3Ydim1s7DVuMqFjvFq
We3Xj+03Qp5r9WtYIAs0ZAhhZ7CdoPiT0yrSu4sc2ercq3Hf2t+N8fQqgCrqY/43
dq0TkqsFVqV6TGP5pl/l3NY85M9Cx8pQSXuEDzpoF8JoRZWGOPtt7RrNdUabRjMs
5Vh5dVr2eE9xK+HM2CeqmWHUl8SvoyHlZt/kighaELtkbAN2QdRCqPOhL8TwCy9F
KLcdRRwBaj5BUCsy0p6yi6b5YjP70e3nA5WTqHEsTtbUT9oKQGUyBoqI3HMsEfF0
QYJtxgoKK9UnKuyqkICUAILgm2Y8gZVEpyo0WXZpfLDv3vclmLAWrkI7jbc4H/UE
xQP1cvXTg4Ryv2xxpOQdBK8ExY9j1sXrtqQj13m0WuBm6eUBppKjgHtVwhV8REVi
zxjsuDui2HpQiL8Ri/LEffCKB3Gqet0ZUekIuGFYtVPtZmefGBmZl7kAFHDWPBzv
x7sAtQIFEC0GeHc1TmgSXsitkRpTmGuLbCmDmkdFek2kJ9NWO7Gc4FMgn9T89bUD
Zrx6b7nSkxhUUQH0fON3cZWkDQ2JPUHKk5fdIDtlIVJOlS3fuMc=
=KnTk
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
