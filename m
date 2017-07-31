Received: from eggs.gnu.org ([2001:4830:134:3::10]:40671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcDXE-0000GH-JR
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcDXD-0001CE-RE
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:27:12 -0400
Date: Mon, 31 Jul 2017 17:27:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170731162701.GK11830@stefanha-x1.localdomain>
References: <20170725153645.26412-1-stefanha@redhat.com>
	<20170727122802.GD4767@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdEQJo40s7ofW8iR"
Content-Disposition: inline
In-Reply-To: <20170727122802.GD4767@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2] qemu-iotests: add a "how to" to ./README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, eblake@redhat.com, Ishani Chugh <chugh.ishani@research.iiit.ac.in>


--sdEQJo40s7ofW8iR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2017 at 02:28:02PM +0200, Kevin Wolf wrote:
> Am 25.07.2017 um 17:36 hat Stefan Hajnoczi geschrieben:
> > There is not much getting started documentation for qemu-iotests.  This
> > patch explains how to create a new test and covers the overall testing
> > approach.
> >=20
> > Cc: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Do you want to address the late v1 comments from Peter (needs to be run
> from build tree) and Jeff (mention common.qemu next to Python tests)?

Done, I've sent v3!

Stefan

--sdEQJo40s7ofW8iR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZf1pVAAoJEJykq7OBq3PIFgkH/2c/ddv0CcuF0GDLrIWvGVzx
H/YQXdffuxMjrH7hnxUm26w1k1V8rUTdUy4wMV/e85DH8U5K9Yvmo/5wivzkbtVJ
e16ARNFQQvN5Hyi/GLXVsMevPMHXNfmrq16b+q3QcnGdkJp8Y3GVatyVHqnlSBZ6
LKxLI7N4hIrtPT1yeUQuGD4UJlo/DloLK3Uq6wHqPQrJ7kLxBFsDsJYZoi24G+Hu
zQ2T1/uDyludgMQDy5OOIt8fOchHq2t8oVObSUcoh9YDS20THwfo5GfHkfZp4BvM
Nd5I+ViiZ1qDHffUA5whf7idRIWOX7XXKdWFiOyTyKxiNjkusPSKGNtIzr1iAOA=
=qABa
-----END PGP SIGNATURE-----

--sdEQJo40s7ofW8iR--
