Received: from eggs.gnu.org ([2001:4830:134:3::10]:54018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db46T-0005PF-Q5
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db46S-0003dx-Je
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:10:49 -0400
Date: Fri, 28 Jul 2017 13:10:41 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170728121041.GF12364@stefanha-x1.localdomain>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-9-f4bug@amsat.org>
	<e35426ff-9c8b-1e04-bc53-e6302deee776@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z+pzSjdB7cqptWpS"
Content-Disposition: inline
In-Reply-To: <e35426ff-9c8b-1e04-bc53-e6302deee776@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/47] MAINTAINERS: add missing entry for
 virtio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org


--z+pzSjdB7cqptWpS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 09:05:13AM +0200, Thomas Huth wrote:
> On 28.07.2017 07:35, Philippe Mathieu-Daud=E9 wrote:
> > Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 69987b5e5b..6da3264d4e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1046,6 +1046,7 @@ F: hw/virtio/Makefile.objs
> >  F: hw/virtio/trace-events
> >  F: net/vhost-user.c
> >  F: include/hw/virtio/
> > +F: include/standard-headers/linux/virtio_*
>=20
> Same as for the linux-headers folder: include/standard-headers comes
> from the Linux kernel ... not sure whether it makes sense to add an
> entry in our MAINTAINERS file here...

I think it doesn't hurt for the virtio maintainer to be CCed on emails
that update the header files.  Most of the time changes are made by
mechanically importing header files using a script, but sometimes they
may be manual edits that are worth reviewing by someone familiar with
the domain.

Stefan

--z+pzSjdB7cqptWpS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZeynBAAoJEJykq7OBq3PIVMoH/3zt4LaI1gHE4t6K3VrLX1dY
3UgnW6q+c86iDD7MkUg3lP/peT2p0sVeTfAaRkAtmFCdvLZ/UNEuC9eHNYvZSNmJ
N2c+eQU5t9/g+lNMkhP+v02qNCjqQDDp6w3xqtoHWzH8T/uYzG8qu1MA7tClmS0i
C/I2RBevkcCGrdSFfqHQKme8xvBbbPNq4epnLVUC5mYxCTWONYwgDvc+unzqB+zT
CSIGyqmQLVyOgk2R0YBpWskmDdrW0IlNDC5hhGkZApFDfltbWuPhplHcDmdL32A7
fFHKiYNNwAI0RxFZSTUI9UcB9izu6l3mBQ/Xi2RDbN3f1kzHNhCpSrsBcPoeiB0=
=oR04
-----END PGP SIGNATURE-----

--z+pzSjdB7cqptWpS--
