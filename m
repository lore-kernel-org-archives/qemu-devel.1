Received: from eggs.gnu.org ([209.51.188.92]:55313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqXdV-0006CA-PM
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 01:21:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqXdU-00043u-Qx
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 01:21:41 -0500
Date: Mon, 4 Feb 2019 17:14:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190204061408.GL1927@umbus.fritz.box>
References: <20190201185358.6972-1-ppandit@redhat.com>
	<20190204010904.GD2593@umbus.fritz.box>
	<nycvar.YSQ.7.76.1902041138010.9424@xnncv>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p7S+EREVcBHk3zUG"
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1902041138010.9424@xnncv>
Subject: Re: [Qemu-devel] [PATCH] ppc: add host-serial and host-model
 machine attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>


--p7S+EREVcBHk3zUG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 11:40:46AM +0530, P J P wrote:
> +-- On Mon, 4 Feb 2019, David Gibson wrote --+
> | I'm wondering if we can just ditch them entirely, or at least make
> | them default to not present without regard to machine version.
>=20
> Ie. make the default behaviour host-serial/host-model=3DNULL/none, instea=
d of=20
> 'passthrough' now?

Yes.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--p7S+EREVcBHk3zUG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxX2C4ACgkQbDjKyiDZ
s5IV8g/+On44wcYtJPcWHrC43jZIKFovXQueGkjuZqCyV9438CrCwTaztcGwc3QN
mQSEY7Iya4El0RbxaJJeznEiWj6kUld7HFEKoNSAwRn/Ebr5JGSPpZeuBjTbHHic
uXQRcVyObdeq3Xsql6E0WYRCHnPwRBidmsr99HBnai+Uc86aT3deDnH17Pq4fQ5T
KacjKX3VS/56UtKhq/mmFxS+UCqfPMLlF/Au+yKubDzTxvACfZhphhbd1q3wBjhU
N3J1K5CnP2H7SJ1WdQHBJEFwHhT0+CuNtkRleYS5v4Rc6LSdO2yFTMpUrtUlAV5h
G3nnfXXeB2EYria8cPbzKcW8ExO7bWn0tvfIJUkX3yeS4/wY0XXlcDt/WrMCwox6
xVyk+Zdss+f/Gebaj+zbCBpD7hcUbVByZhQgHlcc+jYHQWLL1OD9Tm3YKZdudoGF
H8/tfmXhD7OwWyA9IoZeJPmbifx24hKfVHLJ1Jr3yNgIjCDcVnQfAKWZaLkDaaNK
Q1BVIoLOGNAX8XeKSimllhzk6GrpXAKnmm6alKB8WEoLZRq5hhZ2fyymzO8V0fzy
ytdX9YiT6HBXt4YwctyJ2d/vz/quuKWnAHmMWX9zB0io3RGQxhMJewCjRsR8/CXL
RsIjJ9FMxdXUq5gH8AMQnkthLJPWJb/yv1pz3T0Z+Hng1MgR7ZU=
=edXJ
-----END PGP SIGNATURE-----

--p7S+EREVcBHk3zUG--
