Received: from eggs.gnu.org ([2001:4830:134:3::10]:52068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIuS6-0008NV-DK
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIuS1-0005zZ-CO
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:14:06 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:33119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dIuS1-0005y0-4l
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:14:01 -0400
Received: by mail-wm0-x231.google.com with SMTP id m7so36991942wmg.0
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 03:14:01 -0700 (PDT)
Date: Thu, 8 Jun 2017 11:13:57 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170608101357.GB4145@stefanha-x1.localdomain>
References: <CAJSP0QVzoN=2rv_HUNf0oR_FQg=5xJ9UQbLqq0rj8OuYb8ZByw@mail.gmail.com>
	<eb4f47f8-ed16-f59b-4adc-1e4e94cadf7d@de.ibm.com>
	<20170531130638.GF16733@stefanha-x1.localdomain>
	<CAJ+F1CJOMMOiPqkSaSNzD6F7=DJBQVojKkz6UNkqgLbVSa5vfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJOMMOiPqkSaSNzD6F7=DJBQVojKkz6UNkqgLbVSa5vfg@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC] QEMU 2.10 release schedule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2017 at 06:24:24PM +0000, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Wed, May 31, 2017 at 5:07 PM Stefan Hajnoczi <stefanha@gmail.com> wrot=
e:
>=20
> > On Tue, May 30, 2017 at 01:21:01PM +0200, Christian Borntraeger wrote:
> > > On 05/30/2017 12:11 PM, Stefan Hajnoczi wrote:
> > > > Here is a first stab at the next release schedule:
> > > >
> > > > Beginning of development phase: 2017-04-20
> > > > Soft feature freeze: 2017-07-18
> > > > -rc0: 2017-07-25
> > > > -rc1: 2017-08-01
> > > > -rc2: 2017-08-08
> > > > -rc3: 2017-08-15
> > > > -rc4: 2017-08-22
> > > >
> > >
> > > - rc4/release or really only rc4?
> >
> > I had rc4/release in mind.
> >
>=20
> Can we put that preliminary schedule on the wiki?
> http://wiki.qemu.org/Planning/2.10

Yes, I have posted the schedule on the wiki:
http://wiki.qemu.org/Planning/2.10

No one had concerns about the dates so I think we can consider them
final.

Stefan

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZOSNlAAoJEJykq7OBq3PI0LoIALj/teHSrsBkHa6F/IDTUU4i
he+z0W1wGKC7ltjuUO/dz1TTOKEJImIQgRmP/MiZSIq3Bx/bByf77P+qUZpjB9UL
QpPTPJJRzmShBlDTRK44pDJ11aVOmv85Kka8NTBf5qnvDV+x1ay1A3VxLI7tgyVl
AqQiVzgu/PntanAey+z8unylNmh376iWHyd7hjY6+uJDBlD16vqbC6VPyfk69k32
HpKp+29VCtfkWNx7skTkKLOEGB3oFV35s0kR1s2WMIcp6PQ/l3P0+5E15drcSbPt
IT2AkMm98tQYJE1J08qHxMgQpDPVSMOT8FxuHRxTFK1Ag3+sEL4oZWOTePDQYAI=
=X5jq
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
