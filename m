Received: from eggs.gnu.org ([2001:4830:134:3::10]:51624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkj5c-0004VF-Cg
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 23:45:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkj5Z-0007CI-A0
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 23:45:52 -0400
Received: from ozlabs.org ([103.22.144.67]:54727)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dkj5Y-00076u-J9
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 23:45:49 -0400
Date: Thu, 24 Aug 2017 13:01:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170824030116.GC5379@umbus.fritz.box>
References: <3f0dc918-0f55-e2f4-bf47-fe4abf5453bb@redhat.com>
	<CAFEAcA_ezKWweEuUB-cXTer0LLaeuiGDkSdfhApedhw4ykDT0Q@mail.gmail.com>
	<20170822112046.GC12356@umbus.fritz.box>
	<20170822134815.77020eb8.cohuck@redhat.com>
	<20170823002907.GC5379@umbus.fritz.box>
	<20170823091650.48e7c44e.cohuck@redhat.com>
	<54526d47-b436-79d5-7a38-9516eaa727a6@redhat.com>
	<5b0ff74a-08d6-558d-4c79-a93758e6302a@redhat.com>
	<0bb344a3-f8f8-3365-cef1-1c68cf7d160d@redhat.com>
	<85908531-fc26-5647-9b62-38485f77d11c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e7WmlSfQJTtHfSol"
Content-Disposition: inline
In-Reply-To: <85908531-fc26-5647-9b62-38485f77d11c@redhat.com>
Subject: Re: [Qemu-devel] make check speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>


--e7WmlSfQJTtHfSol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2017 at 11:33:55AM +0200, Paolo Bonzini wrote:
> On 23/08/2017 10:35, Thomas Huth wrote:
> >> If you have a many-core machine, of course, there's no simpler solution
> >> than throwing more CPUs at it. :)
> > Is it safe nowadays to run "make check -j4" for example? Last time I
> > tried (maybe 1 or 2 years ago), there were still issues since some tests
> > were using hard-coded temporary file names, so the parallel tests were
> > disturbing each other, for example...
>=20
> I run -j18 all the time. :)

Nice for those that have 18-way machines at their regular disposal...

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--e7WmlSfQJTtHfSol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmeQXwACgkQbDjKyiDZ
s5I80w/8DCFngCGcjy+7P4Ld3bWTpSWsTklG5SqOE/zu6yqGn7txcoX8FwQyP69E
hlo0xf6PBtBHsrOhdW1wahNG1K9xrz0TamoSIoS8YKP4Fft6Z8jdjkC06Bbf3Aox
XJ7g+zquFyFWh2gcgj/PYmgFa2laHOi2rk9wbWf2pPpjCljVnuSiR5xIOQKGCjZl
0YYICCipRjxcl50Sy7lQKAUmnjX0j39LEkhiB2LBie1d4HcWaDU3dHONtH4i/8GD
7ODHfxDySIS0B7qIb0yBP9tG7NpgZM2Tz1WHkh942up/ecXhtXvrluCULpWMd8ul
fuQOnFstbXfzFGGzOTpWO2VUmrNcPr4pLzxrGks+ue5fyhlmr04rUYt6OySEYMF6
iMsDEcQnX8Sej1yY8gkTqpPbkf40eCGh4AkUEPsfJHRhviallzVSasaTJpEpHR3n
XCuN3eDOcs2Vp02GR866JiXTcAGqG9YxDZd7q/ppqCuB05PbS3MoySw8ajbPB+dT
fR4A51WBVpgbEfYFwu7eZx5ta+CBs9JUYy/mCPCcoY7aE2F1AP79L3kYOoMn7gAn
SMQYdfn3UbuozyCHfBdgkoR2QjbgUko9tNDgsy8qbVQukgyJcJvviSjx6Q5oh+pJ
3ek4LO/JIEtJMvkEeCDlWCh4oXSBhnR2VydRhRK2AfJGoGPzo8Y=
=x7pE
-----END PGP SIGNATURE-----

--e7WmlSfQJTtHfSol--
