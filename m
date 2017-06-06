Received: from eggs.gnu.org ([2001:4830:134:3::10]:55892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dIF6A-0003Fl-95
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dIF67-0005vZ-4q
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:04:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dIF66-0005vE-VZ
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:04:39 -0400
Date: Tue, 6 Jun 2017 15:04:35 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170606140435.GA25890@stefanha-x1.localdomain>
References: <20170606110556.12922-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20170606110556.12922-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Document deprecated features &
 support lifecycle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2017 at 12:05:54PM +0100, Daniel P. Berrange wrote:
> This is a followup to
>=20
>   v1: https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg02390.html
>=20
> The goal is to clarify to users & app developers what they can expect
> from QEMU in terms of feature lifecycle & any deprecation policy should
> it be neccessary to remove features.
>=20
> Changed in v2:
>=20
>  - Split into 2 patches so we can consider each suggested addition
>    independantly.
>=20
> Daniel P. Berrange (2):
>   docs: document deprecated features in appendix
>   docs: document support lifetime for features
>=20
>  qemu-doc.texi | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>=20
> --=20
> 2.9.3
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZNrZzAAoJEJykq7OBq3PIZRsH/iVF3BCNAovyeqhODDmHvOPV
9drcrwuSHtrq8ffL/P6c8fhzlYLcHB2RIfc2MPjnQjieFD8W7kon0RLuEAKM2QT+
CvLSi3Sr14kSK6tL1p3rrdi6u080ejm6xTQACS92SOeXWRI9wpstGk5s/fwYC9Fy
WeP4rjkHktzhL4Zlv6WeDX1T8e7Vmqa3WvL8cuTGLAsLUcDYsNDw3wJVwm+b4Mvz
aF17ryBI3AbZ4rkxIxDFwHSNLwlJyKFgeS0XWaP4r7U+IrHm/lkZCVF4pKVxdvhs
rkPi7jSdeT8mUWchY7S88N8oqASl138eS/WBweT/yEvkGbCgjp7wa8GhlZ+0OuE=
=Fv/b
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
