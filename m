Received: from eggs.gnu.org ([2001:4830:134:3::10]:36943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fRCD3-0007tY-3b
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 03:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fRCD0-00068H-Nt
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 03:53:21 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fRCD0-00067g-F2
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 03:53:18 -0400
Received: by mail-wr0-x244.google.com with SMTP id l10-v6so12362887wrn.2
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 00:53:18 -0700 (PDT)
Date: Fri, 8 Jun 2018 08:53:15 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180608075315.GE29183@stefanha-x1.localdomain>
References: <CAJSP0QURm0Y6FBByzY=kgf7JmDDyt5PLkkxk+ODi21uQKUGq5A@mail.gmail.com>
	<CAJSP0QWELqGP56Dm5qyS7zGe_xdPwB5t6CZXkqhdmX16RKM9nw@mail.gmail.com>
	<CAG7hfcJxiPYou5dNaWcL8p9uQxHUX1Qa7PDaku_z80Qx-S=yGg@mail.gmail.com>
	<CAJSP0QW4dDpifDJgyuLKo3Ar53OGwUMP16e++HnDe69NA3-Mmw@mail.gmail.com>
	<CAG7hfcLvhTgz2497-wDD0e02U7hX4eeRPuzqwaL+ugxemPSkzg@mail.gmail.com>
	<20180607103628.GE19032@stefanha-x1.localdomain>
	<CAG7hfcLE7jJgsAmmOD0TQSN42kPg8ixJ_RQnpmZk-NNJ2MuZ_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+SfteS7bOf3dGlBC"
Content-Disposition: inline
In-Reply-To: <CAG7hfcLE7jJgsAmmOD0TQSN42kPg8ixJ_RQnpmZk-NNJ2MuZ_Q@mail.gmail.com>
Subject: Re: [Qemu-devel] Cortex M0 emulation tasks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liviu Ionescu <ilg@livius.net>
Cc: Julia Suvorova <jusual@mail.ru>, qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>, Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>


--+SfteS7bOf3dGlBC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 07, 2018 at 06:46:26AM -0400, Liviu Ionescu wrote:
> On 7 June 2018 at 13:36:30, Stefan Hajnoczi (stefanha@gmail.com) wrote:
>=20
> > If you do want to upstream the code you linked, please let us know
> > the
> > details of how you want to do it and how long it might take. Maybe
> > there is a way to work together on it...
>=20
> yes, I considered this, but I do not have a schedule yet, probably in Q4.
>=20
> I first=A0plan to upgrade from 2.8 and only later to re-evaluate the
> entire project, to bring it closer to the upstream version.
>=20
>=20
> the main change I envision is to untangle the Cortex-M code from the
> current ARM code. maybe now the status is better, but when I did my
> changes I had lots of problems.

Thanks for the info.  We'll CC you on Cortex M0 patches.

Stefan

--+SfteS7bOf3dGlBC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbGjXrAAoJEJykq7OBq3PIl7sH/3YdVDkkDuUYlOQdI1e+Pbn/
gX8RxTB+9NmBgzFyaC0X56J0s1zXFpFBrnrM786CwKs9eTaQyl/+FHzEPjpZu5+3
zMcm8ead1JILX1Y4ggzjicqki7YfzbWwYSEo8CMzQuH/bInJokUdrRP6w2woQviT
eREA/dBzC3RIjhF6CwBK1BEqrif6rnvwzFrAeAcVrxaYZe3xxC5o3ZlfHTV57SLP
uEVE9tJx/AJmdC9Xn6kPS0EjYLYFUHyjsNfXrNwzlKNiJ+aQk0ByyPeNv/zY0qf0
TV5WJr23ojbpUd9ENC/bHXOZYTcpQakYnQN3Haqw21SyQ6sxqFdo6TccKInrX9Y=
=2n/K
-----END PGP SIGNATURE-----

--+SfteS7bOf3dGlBC--
