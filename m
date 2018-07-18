Received: from eggs.gnu.org ([2001:4830:134:3::10]:58051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ffcF9-0001NQ-PH
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 22:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ffcF6-0008Ew-JZ
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 22:31:07 -0400
Received: from ozlabs.org ([203.11.71.1]:53255)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ffcF5-00089r-O3
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 22:31:04 -0400
Date: Wed, 18 Jul 2018 12:30:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180718023053.GD2102@umbus.fritz.box>
References: <alpine.BSF.2.21.1807151041060.88858@zero.eik.bme.hu>
	<20180716025346.GF2599@umbus.fritz.box>
	<alpine.BSF.2.21.1807162207210.15021@zero.eik.bme.hu>
	<CAFEAcA_3km1OB=7kqoZ6AvW0+G9FqfgD+go_KghFLDrgj2Xk+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d9ADC0YsG2v16Js0"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_3km1OB=7kqoZ6AvW0+G9FqfgD+go_KghFLDrgj2Xk+g@mail.gmail.com>
Subject: Re: [Qemu-devel] hw/display/sm501* status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Gerd Hoffmann <kraxel@redhat.com>, Sebastian Bauer <mail@sebastianbauer.info>, QEMU Developers <qemu-devel@nongnu.org>


--d9ADC0YsG2v16Js0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 16, 2018 at 09:43:05PM +0100, Peter Maydell wrote:
> On 16 July 2018 at 21:26, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> > I could list sm501 in the sam460ex section thus formally taking
> > sub-maintainership but this would only go as far that I'll get cc-d on
> > changes and try to review them. I still can't (and don't want to) maint=
ain
> > my own tree and send pull requests directly so I'd need someone's help =
with
> > that who can take my patches and merge them via their tree. If it's OK =
to
> > continue to use the PPC tree for that I'm fine with that if David agrees
> > (which I think he did above).
> >
> > So is it OK to add sm501 to sam460ex section so I claim responsibility =
for
> > changes and will continue sending patches cc-ing David (and maybe Gerd =
to
> > help spotting problems) then David could take these via the PPC tree?
>=20
> I think that makes sense. sh4 is pretty dead and if sm501's major
> active user is the sam460ex then listing it there seems reasonable.

Sounds good to me.

Zoltan, can you send a patch adding sm501 to the sam460ex section of
the MAINTAINERS file.  That will make you the right point of contact
for it.

On the understanding that it's just about tree logistics, rather than
review, I'll be happy to take sm501 patches from you through my tree.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--d9ADC0YsG2v16Js0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltOpl0ACgkQbDjKyiDZ
s5I+Uw//TFjZIWgl05g0MAm5nqXyc9EmHeGm1Hrlk3avZL4ILPFufV2aN72RniNx
z9e5P+Hd2z7YcSlIpUjLFfzvuAOUOpaMAw/74oUe39Q+AvvtzGNttvoYxBclPHpj
BJY7dZB96/csUhpq6GNYainfhDrJ5HZJN+NpVd1SrTO22uMdRccv1EB4Zi3Deykl
7n8fXAiOXyoRUHTY2EX2ytuU/tPrqQz0pLlCOZevt3L4U+2DKZf+Y3fNjFUYTUIY
FYBE69dzkw2Om8gmK8l65ORkXfF+LO63eOTperQdxgNZLdfiZGcdmLJnRA9s7olr
5aXkitiXWF4MlnVOg+qrMuDN/hr8ObSjIySNU1+QEUR8XrGV/fXIoOGWd7fsMqxh
keKzVW/gRz0CSVoFVLss3Z3hTox0vOTnOIXdcZhfz3bP5rljqf1bedX+frtrLoou
rrBd7EfzM0aFK+MS5TztirFGi0yRzJUKSDKzd6yz6ogQnxTH0C6KQstWNPw8+HK2
lo3unn0RJ5AAC2eebjqkiNe8uwVDAca6GFhHbsrBvm+DU3ZMU7bYlwAjAF8AZNa2
V48q8U1ltfHmfw/a85GRrrW+Hr9SrSC718B5cOSqmPOI53ZVpVASUnNK1cuupQXs
xGXCn0O0bEcZgIr6+cMeX6gS7zjddY0ysoyYRUTPPg5BI9jUjcE=
=3faF
-----END PGP SIGNATURE-----

--d9ADC0YsG2v16Js0--
