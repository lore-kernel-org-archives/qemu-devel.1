Received: from eggs.gnu.org ([2001:4830:134:3::10]:44061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cm8YQ-00019o-Ez
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 19:37:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cm8YN-00021R-DH
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 19:37:10 -0500
Received: from ozlabs.org ([103.22.144.67]:46411)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cm8YM-0001zK-Hz
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 19:37:07 -0500
Date: Fri, 10 Mar 2017 11:29:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170310002945.GR19967@umbus.fritz.box>
References: <20170308124955.35623-1-aik@ozlabs.ru>
	<CAFEAcA_pq6cUVVqzg0in-QTKngsf2cSpzpaGnP=gH5X2GnzOQQ@mail.gmail.com>
	<4c8ab05b-9e6d-10db-6480-e6b58d3ca390@ozlabs.ru>
	<20170309013150.GK19967@umbus.fritz.box>
	<CAFEAcA9QzBASyBELx7fxp1pexVaZfLRP6fKaZX63LTOzV=hZjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+bDoS+V4AJZnUgoC"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9QzBASyBELx7fxp1pexVaZfLRP6fKaZX63LTOzV=hZjQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH qemu] dtc: Allow compiling with old gcc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>


--+bDoS+V4AJZnUgoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 09, 2017 at 07:43:07AM +0100, Peter Maydell wrote:
> On 9 March 2017 at 02:31, David Gibson <david@gibson.dropbear.id.au> wrot=
e:
> > Yes.  I've now fixed this in upstream libfdt, at Paolo's suggestion.
> > Unfortunately, it came just after the 1.4.3 release.  I was just leery
> > about making a new release and qemu pull so soon after the last one.
> > Should I do that anyway?
>=20
> Yes, I would go ahead and do that.

Ok, release tagged.  I'll send the qemu update once it's mirrored to qemu.o=
rg.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+bDoS+V4AJZnUgoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYwfN4AAoJEGw4ysog2bOSvNMP/3pirTN8c95OM3QWXaDaqNnU
aOlw+g4dpvYawMQBDYAWIP04XEEO9Rwzjiq53ROQ/q/fSHEJlu3VxQaXXQqM0EsE
JhWZR0GI9+0yjTWdc0K7tQkTCyBZ73Gvd+vcoSOhm/ZLjCKPnWWVhYKY34KkeXYs
bI2wm0eDy7gTV6M0AG0q8Xxdp26ylwHTvHLos48XMpykwIb9d3meKWx/QGhCK1se
2qtl3Zz5pNpkK7XEpSkF5Q8hyzSOYjKRDfVLVp5Cee9g/jLvc03NmiwlrNl4tD6c
MQVkdc9Hd3pa34bN5lR49SoN12a2L9emfuRxRVT2q10EVW6STK2zOaFbEqflC/xD
cXd1TvVWg96EO0huSM4Bds4xeVX1BbCEFBfmliBNysc9HdD6a5TCmUynmsgpHGIm
FdCCvhaUcMShmdWVXbo8SiE1d44Mv7V5iusiAy7kK6qjqtyIi2+Hoy8FBlaWmDjy
fxPpGZCyByWnApzhoEJDEoOs2vXZLA4/a1uZYp67AMoaXiOgpLjL1ceu73uBTA+r
JRmv/Qt8ik+SRvCTP5GzsJ+Epxmp7dfJEZ4u6TZB5O7h19A0Dh7Yx5KUHYjzjcHd
IPecoTWVUze7VbH11rqGLvJHZsgnoBwlR8ysTrsh4jB0+tYj7M1EQT2hrVnt7HsW
S6J6jmxb2e5ZdjgJFpOm
=IgPJ
-----END PGP SIGNATURE-----

--+bDoS+V4AJZnUgoC--
