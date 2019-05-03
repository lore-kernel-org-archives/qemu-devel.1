Received: from eggs.gnu.org ([209.51.188.92]:37834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hMc1Y-0000NZ-P2
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hMc1X-0001Ek-7M
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:31:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40959)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hMc1X-0001Do-1L
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:31:03 -0400
Date: Fri, 3 May 2019 11:30:50 -0600
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190503173050.GA10354@stefanha-x1.localdomain>
References: <20190425133503.30847-1-stefanha@redhat.com>
	<20190503101921.GC17905@redhat.com>
	<CAFEAcA_CkUBHe1fWg9wy-+HLw8WBZrp3M_oBksCN1GQc1qp4hg@mail.gmail.com>
	<20190503103529.GD17905@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20190503103529.GD17905@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] security.rst: add Security Guide to
 developer docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Otubo <otubo@redhat.com>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2019 at 11:35:29AM +0100, Daniel P. Berrang=E9 wrote:
> On Fri, May 03, 2019 at 11:28:53AM +0100, Peter Maydell wrote:
> > On Fri, 3 May 2019 at 11:19, Daniel P. Berrang=E9 <berrange@redhat.com>=
 wrote:
> > > Everything above here is useful to QEMU devs, app devs & end users and
> > > should be made part of the main QEMU doc - convert it to texi and @in=
clude
> > > it from qemu-doc.texi, as we do for other stuff under docs/
> >=20
> > If we convert it to texi we'll have to convert it back again
> > as/when we migrate properly from texi to sphinx... (I would
> > like to make further moves in that direction during this
> > release cycle -- just need to find the time to work on it.)
>=20
> Yes, but we're only talking about 100-150 lines of simple text with
> minimal markup needs. Won't be a noticable extra burden compared to
> the pre-existing 4700 lines of texi markup for qemu-doc.texi and its
> includes.

I'm happy to split as suggested and do it in texi for now.

I am also happy to convert the file back to rst again later.

Stefan

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzMesMACgkQnKSrs4Gr
c8g2xAgAyGxJLRlE41x7CVbiPGSzQhdEyehXdUW57cAta++99bwflb2XY8+R+gJs
ygUsyZAcqUIvLVXr5fmV2fgvd9DVtwmCTAdfKbUHlS5SALGR06F6lt5srVHB57td
ZqlHCSKvPoC3DziyIThZvabSosY19m5O3R875ziA/Ze/5lX4Kj4Q4dqp8hcfNNNW
KVIi6JqhwOZXvi1Tto/S5T686QQCPplTvq9W1tjudHL4TgDQxpY3VqkR3M2YieH+
f5p0wbWzxzCVIFUn5UrzmMzPaxgA2HiNB+YFk6wH9nzlOaCig7GR1erddimUjyRw
cPsEUEbb+JXOnvw9yOnTBty4VbSyFQ==
=g2b/
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
