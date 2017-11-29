Received: from eggs.gnu.org ([2001:4830:134:3::10]:38502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJzKu-0000r1-Jm
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:11:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJzKq-0005Ig-Kp
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:11:24 -0500
Received: from ozlabs.org ([103.22.144.67]:43801)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eJzKp-0005HQ-WC
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:11:20 -0500
Date: Wed, 29 Nov 2017 21:11:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171129101113.GL3023@umbus.fritz.box>
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<151194617493.816.13426298875361921541@bafd83ae6430>
	<20171129091847.GC12220@lemon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EEx6GiKZGZ1wKUra"
Content-Disposition: inline
In-Reply-To: <20171129091847.GC12220@lemon>
Subject: Re: [Qemu-devel] [for-2.12 0/7] PCI cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, mst@redhat.com, marcel@redhat.com, imammedo@redhat.com


--EEx6GiKZGZ1wKUra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 05:18:47PM +0800, Fam Zheng wrote:
> On Wed, 11/29 01:02, no-reply@patchew.org wrote:
> > /tmp/cc3Czn0R.s: Fatal error: can't write 3947 bytes to section .debug_=
str of hw/arm/virt-acpi-build.o because: 'No space left on device'
>=20
> Hmm, the host is shared and what I have is a normal user account, so ther=
e is no
> control over disk space availability.  Anyway this is completely unrelate=
d to
> this series. Sorry for the noise.

Yeah, I'm afraid I've mostly been ignoring these build warnings,
because s390's been failing a lot for reasons unrelated to the series.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EEx6GiKZGZ1wKUra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloeh74ACgkQbDjKyiDZ
s5LlnBAA5dhNtUw25guDV3LUuyk4iTlgXxfAk5J/BbuDIRofTUnkibMjHNiwMLz/
g02OQ4Cm/XDQ0smtfA+txukcpEqnG3H482Dl9SBfK6lzeXlslagf1qSsJRFx0JG/
VcvKHZV9mFRWDhgonzwxeoveRcbX5zbqtbYwpGselXBqM0t/AUv3tXHjL60vOniV
6R71Zi29+IlxO+XG/ozUsA8jKQhjousydosTGz4F3psc57IDqE/QlCoMPeMAfAO5
EdbSJOdZReqXUsWcB+ZbJhavwmoEOhXsIn7xaTHsz9C1JSE0oIfRC4a28xV2fGFs
cxHRKjyMp21HIBraXL59r/8UssjSMYxJ36Hw9f6XLN5+FcFLjUVKZiA1obKPSuPx
lfl/BkHclrq6RSo+bFWuMSTY6bPKPHu94R2+bykwFo6OLdyfhixjiLfZBq3zWXlN
droacxNZJ7IIBVQimv40Fp+CofpSU1jPMApQAZHPGBGfZUgvynutaJBmHCXYI/En
1xzqiU1TWhmI2EmOFZymHukf992yYt/ldoaMl6yDiXEw+t4aUyJUW/y/Eh6Dled/
YYEpciPStnTjg0X7/6sNaKCU1RMqjS/O2s1abFQEo+8lOIlThkpUeP8nTgRk7qhH
S5s9KBZtKn+YvtlXAtgEgnLuKAlHDvnrWOiomsngVHxjadDSphQ=
=C1Fl
-----END PGP SIGNATURE-----

--EEx6GiKZGZ1wKUra--
