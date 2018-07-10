Received: from eggs.gnu.org ([2001:4830:134:3::10]:59873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fcmrc-0002gH-1t
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 03:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fcmrY-0000jM-4c
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 03:15:08 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:38165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1fcmrX-0000iz-Tt
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 03:15:04 -0400
Received: by mail-it0-x241.google.com with SMTP id v71-v6so19411279itb.3
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 00:15:03 -0700 (PDT)
Date: Tue, 10 Jul 2018 17:14:53 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20180710171453.6e3eee34@aik.ozlabs.ibm.com>
In-Reply-To: <20180710064248.GM22363@umbus.fritz.box>
References: <20180702062644.48040-1-aik@ozlabs.ru>
	<20180710122244.7466489f@aik.ozlabs.ibm.com>
	<20180710064248.GM22363@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/JuN41.KSDoHRUbPnznJAMkK";
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

--Sig_/JuN41.KSDoHRUbPnznJAMkK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Jul 2018 16:42:48 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Jul 10, 2018 at 12:22:44PM +1000, Alexey Kardashevskiy wrote:
> > On Mon,  2 Jul 2018 16:26:44 +1000
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >  =20
> > > The following changes since commit edb1fb337f65f82fe32b989c4f018efe85=
c1dddb:
> > >=20
> > >   pseries: Update SLOF firmware image (2018-07-02 16:21:30 +1000)
> > >=20
> > > are available in the git repository at:
> > >=20
> > >   git@github.com:aik/qemu.git tags/qemu-slof-20180702
> > >=20
> > > for you to fetch changes up to edb1fb337f65f82fe32b989c4f018efe85c1dd=
db:
> > >=20
> > >   pseries: Update SLOF firmware image (2018-07-02 16:21:30 +1000)
> > >=20
> > > ----------------------------------------------------------------
> > >=20
> > > I just missed a couple of gcc 8.1 fixes and thought I can still squee=
ze
> > > them before the 3.0  soft freeze.
> > >=20
> > >=20
> > > *** Note: this is not for master, this is for pseries =20
> >=20
> >=20
> > Not good for 3.1 either? =20
>=20
> Ugh.. somehow I missed this SLOF update request, and now we're in 3.0
> hard freeze.
>=20
> How bad are the bugs this SLOF update fixes?

These only fix gcc 8.1 warnings and runtime errors =3D> not really
bugfixes so it is not a big deal if they miss 3.0.


--
Alexey

--Sig_/JuN41.KSDoHRUbPnznJAMkK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEECIb1sawlPgRl/px9ze7KtGKK020FAltEXO0ACgkQze7KtGKK
023FzQ//T4EWGS7ud4Ym/8EO0wKwr/SjvPIiknZgBMoraesQ5vCsZBuy18SqHRqR
DavmEaVvPMP/vnsK3NI88WcXAz4THcJwzcJjSubd+WO3DDrEww0Kl4wEBMjgWeBP
nH00fsm5sW8llU12C6EYTAm6Hzf8+20/kTg2oLiuOaUvl5O4hDZaU8k/bDA7qxuF
70Rg7mq3sf+NFS17JJ2PSeaaxn3oMOJ0XNyPz6t8pfDuiDuVIQFSEl5segMWZRUV
GmkrArQ2kZyNbiONCr2V4Ts/ZBAkAlgB3R/feISSjYdFpcFGTxNuOKsDZIUlyyBr
Kmbl+ri7mmo8FnhnoapnHXF8nqj5Xc0R5hveYAb9XqA4VxvbCF6BGTeNdXmIBTc+
hupoOrjVdrz28LSwAskan2gwjqGh+I7agOy21cjEhMe4dpQz4yGsMaYi7uSRzGKg
5Wfw4V02kTuqcePE4Jca9PEdEVUKF+8uS0EbHFyZeLQfNR+1of4Z+qM35lFDC4aC
OL2nRnnR8B0yfkeAMfYiew7HtPQshrR3hDCCpHjf/MSv2HHhTdMLKMDjV13oEWlm
lut5D0j82ApXhCMBXa/ri1ZgH84VCNJff+5HvbcJPAuvdnA84nmKxObSFrVym+Q/
z+19gWeyhBoF7HJedW8uXqraIDU7J4ENhbVyOpa9//Ry2iAK0PA=
=Bmwj
-----END PGP SIGNATURE-----

--Sig_/JuN41.KSDoHRUbPnznJAMkK--
