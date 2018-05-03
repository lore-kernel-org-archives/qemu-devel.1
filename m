Received: from eggs.gnu.org ([2001:4830:134:3::10]:57257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fE8Y5-0003r0-Np
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fE8Y4-0006aF-TJ
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:21:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44794 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fE8Y4-0006Zq-Na
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:21:04 -0400
Date: Thu, 3 May 2018 08:21:00 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180503072100.GA5301@stefanha-x1.localdomain>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430103312.GH3249@redhat.com>
	<20180430132107.0a37704d.cohuck@redhat.com>
	<ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
	<20180502074403.yh5weukbjgqsvp7n@sirius.home.kraxel.org>
	<20180502080200.GG3308@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20180502080200.GG3308@redhat.com>
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 02, 2018 at 09:02:00AM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, May 02, 2018 at 09:44:03AM +0200, Gerd Hoffmann wrote:
> >   Hi,
> >=20
> > > > If we bump the major version each year anyway, why not go the whole=
 way
> > > > and use 2018.1, 2018.2, ... (or even <year>.<month>)? The nice thing
> > > > about that is that you can see at a glance when the release took pl=
ace.
> > >=20
> > > ... or simply drop the first two digits and call them 18.1, 18.2, ...?
>=20
> > We could also drop the major/minor scheme altogether (as they are
> > meaningless anyway) and just go for YYMM, i.e. 1808 (for a august
> > release).
>=20
> I don't much like that - it'll lead to a wierd progression of numbers
> where we'll be constantly the rationale re-explaining to people who
> want to know why we've jumped from 1808 to 1902 to 1905 etc

I don't see an issue with time-based numbering schemes.  Ubuntu made it
popular and other projects (like DPDK) are doing the same thing now.

The convention is YY.MM though, not YYMM.

Stefan

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa6rhcAAoJEJykq7OBq3PIgpYH/RRTvMrNf1wTdOZRUiB5UYMn
SEUDvcg2uP5zIHPYapTj87fNrzI254WPxeqcgamoSNW948+hsVsJlGqfaU1O+K1S
QkMjjat8NENi2LfyZ1sIN3txjc6kCW1b8aI3oAg6I/cC199jhxGUUtNs5dzg5YEK
m1SfkWXNEfTwml47Inc9d5qVQZN4flyk6RR6bp0WixXpXvE5KMBuH18CtUG797Dm
VNMsv75Yt7M+bZUNsFnPknniQ6PVFW9L+NzcMO/qXkoMXHQeoVve2z0Mf6jpcp2J
gqOWos3mHoTJOjtQPDb1WX04k+9aNl2mYvYN2vcFgBgFT0ruB2DhZl0ZME/g4ZE=
=pHbZ
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
