Received: from eggs.gnu.org ([2001:4830:134:3::10]:49321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cne4M-0000aZ-Ez
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 00:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cne4L-000860-Il
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 00:28:22 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:48395)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cne4L-00084R-5E
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 00:28:21 -0400
Date: Tue, 14 Mar 2017 15:28:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170314042813.GF12564@umbus.fritz.box>
References: <20170308124955.35623-1-aik@ozlabs.ru>
	<CAFEAcA_pq6cUVVqzg0in-QTKngsf2cSpzpaGnP=gH5X2GnzOQQ@mail.gmail.com>
	<4c8ab05b-9e6d-10db-6480-e6b58d3ca390@ozlabs.ru>
	<20170309013150.GK19967@umbus.fritz.box>
	<CAFEAcA9QzBASyBELx7fxp1pexVaZfLRP6fKaZX63LTOzV=hZjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eNMatiwYGLtwo1cJ"
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


--eNMatiwYGLtwo1cJ
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

Ok, done.  The submodule update is in the ppc pull request I sent a
few minutes ago.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eNMatiwYGLtwo1cJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYx3FbAAoJEGw4ysog2bOS+UoP/3SJZ9DAUtVkD0o36wyyYAP1
ADU3yEq2YCOA+wWpLh/crSUjiFQxdrD/0yowmFaHTnurhb6l+fbcn4FjhFemOOS2
s1Irl9q9IQ2/fqgAyR3qh5d1BzDN6XobtGuryjxZXAaM8qMCC03Z39mmXKiF6yz1
LkEYCEQMUf72Rb/BEFJXU8cL7iOkIZWxuzRRe4n/zGUHlkdkafleR35pOWL7BqfV
n3Ow8GBDn1jUiKRYSByV2fTSn+y0q4BiLTkpJB3g9Bvg1AaPZ2L3J0CJZZpeKsqE
muUKTE18m4/BHvi6mp3D/DEzvROi138ejrfU35JEtK1zgTBCChLSBtPUKqQKq5eF
fETV88uD7vhwEcuSs1F1cVNGZNXX4w7KK4U/OyRsymBg5cxLTw92dkgtTHgpsgXV
7WTYTANCXUreO0PeDhUde3aylg20E9dLyIygJdB3E3v0hPonJkwI78nqsmI834M/
hIt2FXGSKNXrkH7GH7O3t5+mg4AiOr9cwgM47/1FL0VHc5703BIS4AmWBslu9Wmf
EbR0p6lEFRhLqkbJ4oNqabVrexDl2MSr1MBEplbp9fqV09Mt9KvDOBBQEYsaB6S7
YvPYiFrjp8WoZu1X0zzuWQU4esvhOCsvV508mzB5CcPy/9XojDr5jPHbcVQXb+RA
q/Cit9ZkrsmYU6slgoBY
=3IBp
-----END PGP SIGNATURE-----

--eNMatiwYGLtwo1cJ--
