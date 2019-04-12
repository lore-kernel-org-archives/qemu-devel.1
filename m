Received: from eggs.gnu.org ([209.51.188.92]:46765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1hEvfw-0003PI-ER
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1hEvfv-0005so-Ao
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:53:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1hEvfv-0005sC-1Q
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:52:59 -0400
Date: Fri, 12 Apr 2019 14:52:52 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20190412125252.GB13589@vader>
References: <20190412113730.28828-1-otubo@redhat.com>
	<20190412113730.28828-2-otubo@redhat.com>
	<20190412114307.GK25308@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
In-Reply-To: <20190412114307.GK25308@redhat.com>
Subject: Re: [Qemu-devel] [PULL 1/1] configure: Relax check for libseccomp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, deller@gmx.de, philmd@redhat.com


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12/04/2019 - 12:43:07, Daniel P. Berrange wrote:
> On Fri, Apr 12, 2019 at 01:37:30PM +0200, Eduardo Otubo wrote:
> > From: Helge Deller <deller@gmx.de>
> >=20
> > All major distributions do support libseccomp version >=3D 2.3.0, so th=
ere
> > is no need to special-case on various architectures any longer.
> >=20
> > Signed-off-by: Helge Deller <deller@gmx.de>
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Acked-by: Eduardo Otubo <otubo@redhat.com>
>=20
> When sending pull requests the subsystem maintainer *must*
> add their Signed-off-by as this is what has legal meaning
> with respect to the developer certificate of origin.
>=20
> Acked-by is something that is used to give a different
> subsystem maintainer permission to merge a patch that
> would normally be your responsibility.
>=20
>=20

I think this issue was already raised by Peter on my last pull-request. My
appologies, I fixed the last pull request my didn't fix my script :/

Will send again after the release.
Thanks for pointing that out.

--=20
Eduardo Otubo

Red Hat GmbH,http://www.de.redhat.com/, Sitz: Grasbrunn,
Handelsregister: Amtsgericht M=C3=BCnchen, HRB 153243,
Gesch=C3=A4ftsf=C3=BChrer: Charles Cachera, Michael O'Neill, Tom Savage, Er=
ic Shander

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcsIokAAoJEN8y58Dw//mid+IH/1Z2Fd6DOW3qBCX1vFpyPyUR
iZH+5GsdbeIQ7CT36nMQStzBDSVtFk1wN03j4hEl4fuIjCQ62rc9OS4q4eeFZl1y
cye3tJcnKWwzvfyKrq5lrG1wBYkF7JEb5t+PGv7GyMncP+fMX4J9famMv8h/q+v4
gOsp+sC2pOCG1gULnu1GdXmSddLwOVGQO3aDoOy5QdpjKqVF2o3Q+NCrc0fSQrSZ
o4pUZstNLPRBNVuEzf69ioS4C9OyfwtBEs+X0OfKWHGg8uSvXznsatAGNwsRWvcb
N+VBZ2ZnuOyB63U6qF+cyPqtrRVDMoXY2OIRhultf1JRdJZgcIgMtg8Wk/v+Pgc=
=rUoV
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
