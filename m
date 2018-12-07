Received: from eggs.gnu.org ([2001:4830:134:3::10]:52641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gV4Im-0001Yf-G4
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 19:47:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gV4Ii-00064W-5s
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 19:47:32 -0500
Date: Fri, 7 Dec 2018 11:22:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181207002221.GR768@umbus.fritz.box>
References: <20181205205827.19387-1-ehabkost@redhat.com>
	<20181205205827.19387-5-ehabkost@redhat.com>
	<20181205223035.GH768@umbus.fritz.box>
	<20181206124851.GV18284@habkost.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9lPOKfY2vCV97ybw"
Content-Disposition: inline
In-Reply-To: <20181206124851.GV18284@habkost.net>
Subject: Re: [Qemu-devel] [PATCH for-4.0 4/5] spapr: Delete instance_options
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>


--9lPOKfY2vCV97ybw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 10:48:51AM -0200, Eduardo Habkost wrote:
> On Thu, Dec 06, 2018 at 09:30:35AM +1100, David Gibson wrote:
> > On Wed, Dec 05, 2018 at 06:58:26PM -0200, Eduardo Habkost wrote:
> > > Now that all instance_options functions for spapr are empty,
> > > delete them.
> > >=20
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> >=20
> > Acked-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> Thanks!
>=20
> >=20
> > Do you want me to stage the ppc patches in my ppc-for-4.0 tree, or
> > would you prefer to keep your series together to go in via your tree?
>=20
> I wouldn't mind to get this queued through the ppc tree, but
> maybe it will be easier to get them through the machine tree
> because of the dependency on the 4.0 machine-type patch.

Sure.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9lPOKfY2vCV97ybw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwJvTkACgkQbDjKyiDZ
s5JaghAAhKcGrt7aBXNqx4UXLbb0LMsZpUMoCradgpxn4ODRk5bJ0pIS/gL+PVPK
zKBLmax+rjBe6qsZF2PykW4EEuC1alUdndLgu5hyRleB0LfSz+0U6NlQes3tggF8
GfrPser7BL5vTE3sBBgLbmePx7A+Ua6m0UFzULxLV9P9MbAsqTmIEb9RlWKWbDV/
xC83qWdcTJjV4VFDscRMBp11opjzh1FOU5gkUdF49oTViIrcgJQSOc8pKH4vkFvM
S5sqWKGl5DXA7g7p/VLSpNvqgvgG4S3OM3RfB5Z/FDcw3bEEqTSuKSDqMXaKq7+R
CeiNJGU5BE7rPFRZXLfdMGx9EQoYzudSYDosgW9RcKBe/DWt4XtpAjb++bgMdi5Y
sErPcgWy1Tebh8xBTEN0JaFEyGZM7OVjdiOSds7jjc3DNM4usJMsSY0UyI/QeJpT
IrusUuEyescCemAXJnNVrwsaAwrerRWEEAC6ZGtZWZfM3++83VLgd26W0vaTOup+
3DrPCIJUvm8oJaT55NDmiOLVeJ6PSa3nZ7KcAqNjrbniRag1C/c71yRvJmBgvCws
XdJADz57QawUAu4HSpAT3pkq85kXCDUOg7G0rLiKqrmHZBqBbkQr2AlVVYKUjQZR
2w7ReZVIJAceWZ1CHovBdxGO9zfXgNpvAoraaTbj6NA8TXknNbE=
=/+Pl
-----END PGP SIGNATURE-----

--9lPOKfY2vCV97ybw--
