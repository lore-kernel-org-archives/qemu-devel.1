Received: from eggs.gnu.org ([2001:4830:134:3::10]:48172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYCqJ-0000t9-KJ
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:22:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYCqG-0002Og-F9
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:22:03 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cYCqG-0002OV-8R
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:22:00 -0500
Received: by mail-wm0-x244.google.com with SMTP id r18so6143272wmd.3
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 06:22:00 -0800 (PST)
Date: Mon, 30 Jan 2017 14:21:57 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170130142157.GK2118@stefanha-x1.localdomain>
References: <mailman.205.1485450031.31314.qemu-devel@nongnu.org>
	<E8A8BF62-0E39-4401-B330-2E27CFA3A83F@gmail.com>
	<8ae107ad-0f3f-46ef-e734-2f88b14bad9a@redhat.com>
	<265EAA01-0C75-45D5-A55D-481DAC288AE5@gmail.com>
	<d95139a6-0e38-75b5-b8df-b4e12391e032@redhat.com>
	<CAFEAcA9N41fGAuVScUXOMorKHmvzzOoNKppEP6eniQEivVT_jg@mail.gmail.com>
	<87wpdh9er8.fsf@dusky.pond.sub.org>
	<CAFEAcA8zGt-HUjEgVTdCvGhhqHqxWDO4_FrCyxRX1UVFycT0MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P7Tqkd/m/Jnohiaz"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8zGt-HUjEgVTdCvGhhqHqxWDO4_FrCyxRX1UVFycT0MQ@mail.gmail.com>
Subject: Re: [Qemu-devel] Qemu-devel] Poll on QEMU documentation project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel qemu-devel <qemu-devel@nongnu.org>, G 3 <programmingkidx@gmail.com>


--P7Tqkd/m/Jnohiaz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 27, 2017 at 10:08:49AM +0000, Peter Maydell wrote:
> On 27 January 2017 at 06:51, Markus Armbruster <armbru@redhat.com> wrote:
> > "What can we cut" is the wrong question.  The right one is "what are our
> > requirements".  Here's my try:
> >
> > HTML: required
> > nroff with an macros: required
> > PDF: wanted (try printing a website)
> > plain text: nice to have (for me personally, more than that)
> > info: nice to have
> >
> > If a solution we like can't provide something that's nice to have, we
> > can decide to take it anyway.
> >
> > If a solution we like can provide something that's nice to have, we
> > should let it provide, unless it turns out to be a drag.
>=20
> Well, every extra documentation format:
>  * increases the build time
>  * increases the chances of makefile bugs
>  * may require extra tooling to produce
>  * either requires us to check it for problems or increases
>    the chance of confusing users because that output format
>    has a formatting problem that doesn't happen in the doc
>    formats most people use
>  * may require significant extra work to produce something
>    that's actually useful: a manpage and an info doc aren't
>    just the same content in a different file format, they
>    should have definitely different contents and structure
>    to fit what people expect a manpage or an info doc to be
>=20
> So my list is:
>  * HTML: required
>  * PDF: nice-to-have

We also need to produce man pages for the command-line tools.

Stefan

--P7Tqkd/m/Jnohiaz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYj0wFAAoJEJykq7OBq3PIIhYIALl/aFls5m32AkPHwc3faRAe
REXHMRjV2RPlVnIJrUQUAHFiEIRNRJG5mf/ZpZAP3qT8fM9ooI3ITs6PAT08i3Cy
jZxtUoo+hZKsGvJ6heagiPf1krs5POt52A9XIwAUuxcFUebX20GhDYS1/bTHH9r/
RNpu2FHvuZ2u/SLZ6YQBdnE+bOmRwtgEgwiYc4NRQfLowyGhdRjnxxN+clCLyhbf
JsaAwKFVjxKB8sP+uh7J0pAuf6CZidOtwRQtwunmEYKIzYLlBKIlG09aC7mFFRqK
WzQAVQyW5H7J7SJkB48VJCefxQjWzpKDAUxqFqBsoGnLvubTMm+hQ0sqZ1BmuPI=
=Nb3v
-----END PGP SIGNATURE-----

--P7Tqkd/m/Jnohiaz--
