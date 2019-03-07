Received: from eggs.gnu.org ([209.51.188.92]:44277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1pwj-0004tb-TJ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:08:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1pwi-0007rT-BZ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:08:13 -0500
Date: Thu, 7 Mar 2019 10:07:57 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190307100757.GA2843@stefanha-x1.localdomain>
References: <20190227172256.30368-1-kwolf@redhat.com>
	<20190227172256.30368-4-kwolf@redhat.com>
	<20190301161724.GB18260@stefanha-x1.localdomain>
	<d6ba8e66-5ddf-9091-ff44-5024a53240a8@redhat.com>
	<20190306095147.GF22159@stefanha-x1.localdomain>
	<ec417842-c9f4-7a7e-e49f-4d509115e540@redhat.com>
	<20190306150633.GK6818@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <20190306150633.GK6818@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 03/20] qcow2: Extend spec for
 external data files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 04:06:33PM +0100, Kevin Wolf wrote:
> Maybe add a new section "String header extensions" that covers both?
>=20
> If this remains the only patch in the series that would need a
> significant change, I'd prefer a follow-up patch indeed.

A follow-up patch sounds good.

Stefan

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcgO19AAoJEJykq7OBq3PIilsH/0NeeIKTH1cdfowtM32H7CRy
S9nal1qgxK4jbX4U+m8AsBYhjJOdcFACu8SyX5SAcfdetG1o3hgRLh9KKe30eYEI
WWAVQfDfffANtCTACALSuZQ3YF5a19e/GtY4tJT3jGomClzuBrwhG3bTBoi+uUlm
3bTYVTFe4e5MZvf0wq3M1wwO4pq77jGfuMktve4apldlN8NFFG+hRmAbX6USx6pm
+bAuy19/MWdQUsFx3xtuRx6rR5iU8DXHQOWY0yVerO/DC1xTRzZC+QzFiJd7IsEx
eJS9IE/mSIqTfWbvoQ1eAQokddolYNti3iLu4zfLHt4751XqZYDD8iCwHfAYc+0=
=lfkp
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
