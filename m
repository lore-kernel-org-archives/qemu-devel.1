Received: from eggs.gnu.org ([2001:4830:134:3::10]:47218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fj2lq-0002Wc-A2
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fj2lp-0007x9-G0
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:27:02 -0400
Date: Fri, 27 Jul 2018 14:26:54 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180727132654.GH28555@stefanha-x1.localdomain>
References: <20180718211256.29774-1-naravamudan@digitalocean.com>
	<a1269390-a798-9165-aaf5-a2aa6270bd54@linux.ibm.com>
	<20180723163011.GH20596@stefanha-x1.localdomain>
	<81e4d6fe-1736-b3cc-45ec-ecaa07098906@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3VRmKSg17yJg2MZg"
Content-Disposition: inline
In-Reply-To: <81e4d6fe-1736-b3cc-45ec-ecaa07098906@linux.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/file-posix: add
 bdrv_attach_aio_context callback for host dev and cdrom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Nishanth Aravamudan <naravamudan@digitalocean.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--3VRmKSg17yJg2MZg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 12:42:02PM -0400, Farhan Ali wrote:
>=20
>=20
> On 07/23/2018 12:30 PM, Stefan Hajnoczi wrote:
> > On Fri, Jul 20, 2018 at 03:11:14PM -0400, Farhan Ali wrote:
> > > I am seeing another issue pop up, in a different test. Even though it=
's a
> > > different assertion, it might be related based on the call trace.
> >=20
> > Which test case?
>=20
> This test case involved one guest with 2 disks, with an iothread for each
> disk. The guest was running a memory workload.

Please post a link to the test case.

Stefan

--3VRmKSg17yJg2MZg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbWx2eAAoJEJykq7OBq3PIiiYH/R0RiMHi17iw98fyVQAExU5j
06GMDTrs5SM2xqvmVJcmvq4cemj8HklvaRYyI87uyQfdE/+mRGEdmjaTxAwkDnAW
cUMlcm82e+I9iYNaJ2Gq+DyuNdhIkFTN/AzQpHbomB6d8EzQ2nUDARc6F9UEQf9m
+TMrcuUe18i/Kj7Zl6Ys8PrJ7IsfmWw0SkxNwqXOtA4iORhNhITJqKjCTRM8MEgU
ol8F+nPKlctJ8uTCukdJHZ4w7prgriW7j3SdeVGimQ99vxkciZ+pQuNTZmP5wovA
cRrAUtvx8cLBBoMDA+aRQsveBa23sC3Q+RkgHTiZrB4LdI9fPqJulbBemb+jPng=
=Cant
-----END PGP SIGNATURE-----

--3VRmKSg17yJg2MZg--
