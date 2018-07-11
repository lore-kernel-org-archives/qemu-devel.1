Received: from eggs.gnu.org ([2001:4830:134:3::10]:52722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fdCkJ-0002Yk-AY
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 06:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fdCkG-00042G-8X
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 06:53:19 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:45637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1fdCkF-00041x-Um
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 06:53:16 -0400
Received: by mail-pf0-x242.google.com with SMTP id i26-v6so6738124pfo.12
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 03:53:15 -0700 (PDT)
Date: Wed, 11 Jul 2018 20:53:05 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20180711205305.0f3a42f1@aik.ozlabs.ibm.com>
In-Reply-To: <20180711062619.GQ22363@umbus.fritz.box>
References: <20180702062644.48040-1-aik@ozlabs.ru>
	<20180710122244.7466489f@aik.ozlabs.ibm.com>
	<20180710064248.GM22363@umbus.fritz.box>
	<20180710171453.6e3eee34@aik.ozlabs.ibm.com>
	<20180711062619.GQ22363@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/5KBUzk1s=B3gWWQNshYYyxq";
	protocol="application/pgp-signature"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

--Sig_/5KBUzk1s=B3gWWQNshYYyxq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Jul 2018 16:26:19 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Jul 10, 2018 at 05:14:53PM +1000, Alexey Kardashevskiy wrote:
> > On Tue, 10 Jul 2018 16:42:48 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > On Tue, Jul 10, 2018 at 12:22:44PM +1000, Alexey Kardashevskiy wrote:=
 =20
> > > > On Mon,  2 Jul 2018 16:26:44 +1000
> > > > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> > > >    =20
> > > > > The following changes since commit edb1fb337f65f82fe32b989c4f018e=
fe85c1dddb:
> > > > >=20
> > > > >   pseries: Update SLOF firmware image (2018-07-02 16:21:30 +1000)
> > > > >=20
> > > > > are available in the git repository at:
> > > > >=20
> > > > >   git@github.com:aik/qemu.git tags/qemu-slof-20180702
> > > > >=20
> > > > > for you to fetch changes up to edb1fb337f65f82fe32b989c4f018efe85=
c1dddb:
> > > > >=20
> > > > >   pseries: Update SLOF firmware image (2018-07-02 16:21:30 +1000)
> > > > >=20
> > > > > ----------------------------------------------------------------
> > > > >=20
> > > > > I just missed a couple of gcc 8.1 fixes and thought I can still s=
queeze
> > > > > them before the 3.0  soft freeze.
> > > > >=20
> > > > >=20
> > > > > *** Note: this is not for master, this is for pseries   =20
> > > >=20
> > > >=20
> > > > Not good for 3.1 either?   =20
> > >=20
> > > Ugh.. somehow I missed this SLOF update request, and now we're in 3.0
> > > hard freeze.
> > >=20
> > > How bad are the bugs this SLOF update fixes? =20
> >=20
> > These only fix gcc 8.1 warnings and runtime errors =3D> not really
> > bugfixes so it is not a big deal if they miss 3.0. =20
>=20
> Ok, well, if you want to resend the update, I'll queue it for 3.1.


It is still on github, why resend?



--
Alexey

--Sig_/5KBUzk1s=B3gWWQNshYYyxq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEECIb1sawlPgRl/px9ze7KtGKK020FAltF4ZEACgkQze7KtGKK
021X0Q//fFd1YcpvIwRwZR/SfIZQgv0GVB+JPkd57BIa6IauOABzILVtf6ov5FoJ
XwgYiPejYOgOeRr4ZZ4ASx/xxzWvVLYHHI8h0HrphwJ00E519bueMWk1RHPlIAga
k6iegGpfi+O0PT+90CRdFVLF1vEo/wZqUUGzE0nlv6/WXfHqSlzjUO6Yt0t3q/ku
ZQh6pNShLyc9T87WZQuzg4pNOXEc9/sYVzndQ1OL1vHF2Itj18lYdhKA20RyZo+4
EpNjkU4HcoXK8kLVBob7inrBwdKelEFqlOUqC08y4xM/xRk+PjEvpUJvlPTcCqZC
e1DRj1eFxO0yjHNp22KmKJyQYqYkICvFc1jLn/lUNTMBt+xUPI7eRNtEibH8l5do
14fJCbZq8EN2zmoE4fU0nVcDuNntu40CJ8Ctw76djC3kKHFnvZslRQxAgSlUJzVh
BBaeyaqWnpob4o7DPkP4PxGi7C4uSCAgs6PS6rfpUSxAySEbcNW14lrTuWQWtfSW
Ik7BArcDjJFxzNSrdg8K5hDJ5Pg1o+RP8LFICxeqlpZvRz64X95zN0nN0D43hhAD
66CuY3pxxyxGTjKQ+E+Fip5XGO2JMTeIlMAb+VgO2QmNYTKhNXvOWugaJv9odlQ+
vg+9I35X6d+JK+OjbLHS1ZvMGdbjiyl4DjGzWaE8r+9eOhAzWbo=
=JKk9
-----END PGP SIGNATURE-----

--Sig_/5KBUzk1s=B3gWWQNshYYyxq--
