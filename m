Received: from eggs.gnu.org ([2001:4830:134:3::10]:52493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIuSu-0000UY-Rj
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIuSt-0006Qp-Dc
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:14:56 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dIuSt-0006P8-6h
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:14:55 -0400
Received: by mail-wm0-x232.google.com with SMTP id x70so74195137wme.0
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 03:14:55 -0700 (PDT)
Date: Thu, 8 Jun 2017 11:14:52 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170608101452.GC4145@stefanha-x1.localdomain>
References: <CAJSP0QVzoN=2rv_HUNf0oR_FQg=5xJ9UQbLqq0rj8OuYb8ZByw@mail.gmail.com>
	<CAFEAcA-AjqsFnk8O3vVO-zhWwowfgZuJi0PWgezPO6K-Ye2cqw@mail.gmail.com>
	<87zidtrr5a.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
In-Reply-To: <87zidtrr5a.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC] QEMU 2.10 release schedule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2017 at 04:18:41PM +0100, Alex Benn=E9e wrote:
>=20
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
> > On 30 May 2017 at 11:11, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >> Here is a first stab at the next release schedule:
> >>
> >> Beginning of development phase: 2017-04-20
> >> Soft feature freeze: 2017-07-18
> >> -rc0: 2017-07-25
> >> -rc1: 2017-08-01
> >> -rc2: 2017-08-08
> >> -rc3: 2017-08-15
> >> -rc4: 2017-08-22
> >
> > Are we going with the same definitions of soft/hard freeze
> > as last time around?
> >
> > (I thought last release was a complete mess in terms of
> > getting code in in an orderly manner for the freeze,
> > personally...)
>=20
> Do we want to have a broad plan for the order things need to go in
> before the feature freeze or stick to a first to the gate approach?
>=20
> Obviously we don't want to stall the process waiting for delayed series
> that might end up getting dropped but having the broad sketches might
> make it easier for developers to prioritise what patches queues to drain
> first?

Any further thoughts on this?  Otherwise we can default to the way
things were done in previous releases.

Stefan

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZOSOcAAoJEJykq7OBq3PIT6QH/RDtw5dgFA7xzkOdkk0+ssb5
KbnYNyHZnSiP6tz3wmeF/uDLU6dL+fWbFCFUSOzG8bavLkzhGZanedm4i4mj6cqa
CoiyIoVQEYdy91SKDD6xr8YxXoXV4MmVrMHMkuHMcieOlGRTsFTyAd9o6b9ywEQZ
r2oX7pknox/h0236U4y4nPK1PQj2cokAchCbMLW8ozDbEonOMjpx1QUV/vBxab7V
UjhfhhyD/JXAvx0BOqnHDYq1Awh+fPYREFA9cynAo0bUuEgQEUSAfm4yh+gELgtb
9b6JQN+fj1MBwsbyffDNrZkWAlGEGzJA7A8+3viCliECI+r8929F9kw2rZMDCfU=
=rLbu
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
