Received: from eggs.gnu.org ([2001:4830:134:3::10]:51824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dNaZx-0001PS-Rk
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dNaZw-000713-RF
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:01:33 -0400
Date: Wed, 21 Jun 2017 15:26:41 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170621072641.GB12089@umbus>
References: <20170614063607.47863-1-aik@ozlabs.ru>
	<20170614063607.47863-3-aik@ozlabs.ru>
	<653b598c-d838-ee69-5848-ae7ea85f5376@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <653b598c-d838-ee69-5848-ae7ea85f5376@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v8 2/2] memory/iommu: introduce
 IOMMUMemoryRegionClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Xu <peterx@redhat.com>


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2017 at 12:05:08PM +1000, Alexey Kardashevskiy wrote:
> On 14/06/17 16:36, Alexey Kardashevskiy wrote:
> > This finishes QOM'fication of IOMMUMemoryRegion by introducing
> > a IOMMUMemoryRegionClass. This also provides a fastpath analog for
> > IOMMU_MEMORY_REGION_GET_CLASS().
>=20
>=20
> Ping?

Busy.. sick.. busy & sick..

I'll get to it eventually.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZSh+xAAoJEGw4ysog2bOSxfsQALiPSMu9EocQdEINpruimxpp
l7LXPZIreCb0zfiUxk0flky+81dbemvt8dJQKxP/4nLo36Whamht8dV4TKf7Hr36
Y7TY9tunFE4M9ZzJcmGP2lsN9cCUk0/1ugWrxzyonwdZz/gtbKlCf1+B80W2LD8l
1cCuThqmZXTNSJ3a/H98l2PEKsZpJxA2sGnLBJLFRVwbUSJHNinRaeVmOPrEoerZ
4ieZxA3M87/MN2/KuClTdOr7MicCxhcf8bCfg+URxp2P/+Uutw+2ARWrIfkK2Xcy
p25ZdPWkWQyOLQcL5VMUKh/seQ1wqvporFLMgoxteJabEzG5Wci9FLI0FFzhlDf4
xVIzo1RB36VlvkzDnTux4MFEvb+7ueHNs+e/O2kfT8I82cm6mvsvXWvgFcOSFrxR
KWsgqXcMliq6ndMuzbGiCRYUHVECfhhu8WTiSmAoMzmS786mhajMt+/n5CCJQExC
cmJYWyrBMF5Rn0gDKDsPZjGxjpDq+m8+QnyIBDVZTTfq6/fZ19H3V/0Ap0YA2pdn
aUgtYvDwf8XvkO/78mDWQBK5ERS8zQw0Q0cVehoJ/2V5JGGwFjTcQyrc6/9VHjqk
MeMO6UGGjnO+/Y/L5SJliHmWODS0TcnM6V+mUXprNFsB9NydPinjzjTRiL6w+DLX
8URmwTRM5c3VsYu8zcWv
=5Ljt
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
