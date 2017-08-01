Received: from eggs.gnu.org ([2001:4830:134:3::10]:33937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dcTNc-00021U-F1
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 05:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dcTNY-0002XG-DY
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 05:22:20 -0400
Date: Tue, 1 Aug 2017 10:22:10 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170801092210.GB13521@stefanha-x1.localdomain>
References: <20170731162641.24160-1-stefanha@redhat.com>
	<fbe60111-cd7b-a69f-fc69-a385cd192b3c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
In-Reply-To: <fbe60111-cd7b-a69f-fc69-a385cd192b3c@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] qemu-iotests: add a "how
 to" to ./README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2017 at 12:28:44PM -0500, Eric Blake wrote:
> On 07/31/2017 11:26 AM, Stefan Hajnoczi wrote:
> > There is not much getting started documentation for qemu-iotests.  This
> > patch explains how to create a new test and covers the overall testing
> > approach.
> >=20
> > Cc: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
>=20
> >  Please send improvements to the test suite, general feedback or just
> >  reports of failing tests cases to qemu-devel@nongnu.org with a CC:
> >  to qemu-block@nongnu.org.
> > +
> >=20
>=20
> Is this adding a spurious blank line at EOF?

Yes.  Please remove when merging.

Thanks,
Stefan

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZgEhCAAoJEJykq7OBq3PISbYIALLdS+xK732hYzYo2MkvmCKe
ReLOe/Yi1Z1ILHGrViDvCPVumK/BEqKi30HJZVWNTtHvObpRL1p/S3zs/cVnjU6D
i6bTnz9HtJAkZIT+QbVTTpRRBUIwrOzdvt/CqG7X+a5AIMb31BMDLDUMY5w7zRoA
5Seyrrp7TcDlA1Csi4OXVWmAxglPvoJaR3imfO/lhxw3/6Afah7p5GQA7hN0R5Yr
QuPeZYjx5wyU3PVWMr+vGM/Mu1Q2qhu9nCfixEOtHKAvt10yowp72aQ8jj0QtnWU
Z7RSWRXZB97fWrCvh+1MJle26e2K99gqQPaFPRWb9r1orkHLNgvG1JcvhIE6w74=
=MMdH
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
