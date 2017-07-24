Received: from eggs.gnu.org ([2001:4830:134:3::10]:51538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZaxT-0000ck-F7
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZaxQ-0002Gc-Dj
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:51:27 -0400
Date: Mon, 24 Jul 2017 20:51:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170724105111.GA9471@umbus.fritz.box>
References: <20170724053542.6099-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20170724053542.6099-1-aik@ozlabs.ru>
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 03:35:42PM +1000, Alexey Kardashevskiy wrote:
> The following changes since commit 91939262ffcd3c85ea6a4793d3029326eea1d6=
49:
>=20
>   configure: Drop ancient Solaris 9 and earlier support (2017-07-21 15:04=
:05 +0100)
>=20
> are available in the git repository at:
>=20
>   git@github.com:aik/qemu.git tags/qemu-slof-20170724
>=20
> for you to fetch changes up to 9f581865da041772eb2e1700c30d75489fe2c971:
>=20
>   pseries: Update SLOF firmware image (2017-07-24 15:25:04 +1000)

pulled, thanks.

>=20
> ----------------------------------------------------------------
> Alexey Kardashevskiy (1):
>       pseries: Update SLOF firmware image
>=20
>  pc-bios/README   |   2 +-
>  pc-bios/slof.bin | Bin 902120 -> 905200 bytes
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

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll10R0ACgkQbDjKyiDZ
s5K0HBAAr6mYkRjs86/apZwtwzON+lv8iha67P1luDhHFZxdLw37/26pz8Ymi4ov
dT1FAiGC5rxBblDp9bimiX1KKg/xYApk9d5ZmtzMWmwZ4NTuXrLIO8zLq8YjOmS/
gB5rwR0itJRsAXdR7EfpLvZLF2JPwCXgJ5RIXVsSavhmRoXqLXlwvugzJv2He8jB
HQ2zpj39Tz+IK9Eax+Dy2pb1Ck3TRluYwFvDTNIGpf0m6zGpcPyfrocwiez09ZXQ
rjc+MnPHbKXmzBYHm0/qEnd0P4UFfTJTWA+th63Jy71ZcqQm80S92No0To8h+xXk
fLuriHRxcJtDso7omzHbt1erSJKxyYvVfHoWfc8IItNC0QGqUIH8F4aP20NEH8hi
orb3xDoCAACJzX6Ui+Ws3Tg6V4lYZi5KCNuHjNwHvSLwSVZkDwXo0BEndpwwd1ex
phWLxjdMsepfea8A7IwogarSfPENs68tqzUXCE+pd6V0hjqT1Ivx/8nhSwUZQor+
j0lFMOGWehhF2UDa0KQinI/4hBfPvmYztChjLqbz0VYUer9IXS77sVoLyUhXyyAB
gUBHor9a7O+blwkfcpXUyN+XB2BgNhY2kjPwaqTklITUkbvctXgQGDLzupIKiGED
XHwBsqDttKETamTVa5WSqxebKTbY4BWCfpcaiH/hqk3x2Nr9xdc=
=PRe1
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
