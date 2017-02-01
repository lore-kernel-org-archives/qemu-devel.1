Received: from eggs.gnu.org ([2001:4830:134:3::10]:56691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYkPU-0003iL-M8
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 21:12:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYkPQ-00085J-Pa
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 21:12:36 -0500
Date: Wed, 1 Feb 2017 12:04:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170201010416.GH30639@umbus.fritz.box>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
	<148429054793.208.9311021714190421447@790289a7ca88>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Uu2n37VG4rOBDVuR"
Content-Disposition: inline
In-Reply-To: <148429054793.208.9311021714190421447@790289a7ca88>
Subject: Re: [Qemu-devel] [RFC PATCH 00/17] target/ppc: Implement POWER9
 pseries tcg legacy kernel support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sjitindarsingh@gmail.com, famz@redhat.com, qemu-ppc@nongnu.org, agraf@suse.de


--Uu2n37VG4rOBDVuR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2017 at 10:55:49PM -0800, no-reply@patchew.org wrote:
> Hi,
>=20
> Your series seems to have some coding style problems. See output below for
> more information:
>=20
> Message-id: 1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com
> Subject: [Qemu-devel] [RFC PATCH 00/17] target/ppc: Implement POWER9 pser=
ies tcg legacy kernel support
> Type: series

The style bot does generate a fair few false positives, but AFAICT all
the things below should be addressed.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Uu2n37VG4rOBDVuR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYkTQPAAoJEGw4ysog2bOSrYsP/1TywYXllFr+yXchAdXbWHtq
p0oyFAqYHPYCvwrEwtEI+GscPB1LyDaB/tnafv1oggQ93QgvU677FFu4cBH+DUYn
hmsQxm02j4ET5wa1e8sPCrT+p/09YOb8CSrO1WQGoiTxvflphXLOUfkJRhLq2MGe
n/Qoipl5SgRlCY6Gh7bccRiv2vfDyiYxuQxyNsdrOa3RXIwtNbjRA3T71/b9JXp7
5fMYTGNdf376/uHYhaNqjKg9nVajMZjFu4x/0sGRxP+seyy26buunXFExNY5GU/G
4snzTWMbD1Co5nm13WwnBvFxYsSP15tkMGvBSTWZQWBdyhRViZewJQX8EeZ0PUKX
DEV6feNM4+efEKsI90VYZjrnvsN37Aj5kyeIVqmST2/pUftt7pbV5YspYkHIor9F
2DFi/bl83e3IoDoc9JXp93zbbV4OseWoaEeJ/TgzwcVMIsHKizrYM5TYppIS2mxO
TWJtT3+nA+OoeSiCeeibksDJ6uD2TV4LNAbTgVcNCb/KL4PylmvIx2JUeFlnqfKA
oaWNpEoOTQbmTCK2nq2zuUe9oehcJKH5aTSh+w13ILnjmNEkdyEgQhPQEK0DGM3V
RJkkfaMBOXA97RRV9fsILPg6WquU+f/Dx67c1Fri4iiq6cBBIax6rtf3KT6/IAvd
UYJQyBsFYmMoRZ1/qPnH
=O89T
-----END PGP SIGNATURE-----

--Uu2n37VG4rOBDVuR--
