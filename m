Received: from eggs.gnu.org ([2001:4830:134:3::10]:59501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciVBO-0001BZ-M0
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:58:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciVBK-0002aB-QM
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:58:22 -0500
Date: Tue, 28 Feb 2017 10:21:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170227232154.GY17615@umbus.fritz.box>
References: <1488171481-21699-1-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/TIhMU+9tW3Jkwla"
Content-Disposition: inline
In-Reply-To: <1488171481-21699-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/8] POWER9 TCG enablements - part15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--/TIhMU+9tW3Jkwla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2017 at 10:27:53AM +0530, Nikunj A Dadhania wrote:
> This series contains implentation of CA32 and OV32 bits added to the=20
> ISA 3.0. Various fixed-point arithmetic instructions are updated to take
> care of the newer flags.=20
>=20
> Finally the last patch adds new instruction mcrxrx, that helps reading=20
> the carry (CA and CA32) and the overflow (OV and OV32) flags

Applied to ppc-for-2.9, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/TIhMU+9tW3Jkwla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYtLSQAAoJEGw4ysog2bOSYvkQAK18Y4nQe3y+3Jx8ZeR/cFV+
90YdqmMDDKYCF1BQ6SVNJPckL5/HM9vtsM0cqsigNcYHVdXIqMl8wYteIGB+Rl8v
U3vnpRiQaEPHYRa7fRst4blXLSO6KFUWNa888xjKeyp6l3kZLMREbOpSZc44nCw1
EFFAYh1HC3QV6TSZsS42g8YZ3VQhzQ9f4uYdmvUEZn8ko710B+12LkrnmQuYBLj0
s78oUKz/nghhkmpOPSHXvu7GQSjwdwjAb7ClF17EYuhj+kTjJ3kNVVKVf4vHGb3G
UXih765Wnkd8Sb+Q6Pcx4Y4tSV8sqvAY1kHJoCQLWtxOsk8voifLWlcBUWCA5M8p
H7YUZpV04gR8fo4MMv+bIuXLDy66U0UpffNnRlSTNFcwncLqPrLkiB762YMqw0XE
wSGHJoGI7aiapPJIuGn3zeSHyF/gZDjODITU1Ep29A8bVBV29ypOrlnZnZW3o3YG
FpwcZAkvJthw7iACD6hP7g94ivF0IFGTirIREduVEMhIf6umAU1HzUdKJApoPluC
prWx7xqmTrU2r2FsZkKreAk3JmqqhZ1sM/xoqVE5yAVF8ygy/kDSGkaC39wf5JLI
DPGBz0G+cTi6Q6vU2MjXBrxpb2Jzrtr3B3ZjmT8epkxXqembtDMIedI9isDLlti/
irRvHcujTyiUpB4nU4AB
=sEf9
-----END PGP SIGNATURE-----

--/TIhMU+9tW3Jkwla--
