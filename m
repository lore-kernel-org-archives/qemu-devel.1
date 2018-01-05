Received: from eggs.gnu.org ([2001:4830:134:3::10]:39094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eXTzE-0007Im-IG
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eXTzB-0005o9-Fg
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:32:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eXTzB-0005nU-90
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:32:45 -0500
Date: Fri, 5 Jan 2018 15:32:36 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180105153236.GG28322@stefanha-x1.localdomain>
References: <20180103214925.16677-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JbKQpFqZXJ2T76Sg"
Content-Disposition: inline
In-Reply-To: <20180103214925.16677-1-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 0/4] sdbus: testing sdcards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Thomas Huth <thuth@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--JbKQpFqZXJ2T76Sg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2018 at 06:49:21PM -0300, Philippe Mathieu-Daud=E9 wrote:
> This RFC series intends to add a sdcard test in C using the libqos.

Thanks for adding sdbus support to libqos!

Stefan

--JbKQpFqZXJ2T76Sg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaT5qUAAoJEJykq7OBq3PIZvQIAIgWBZbzoPInO/OrOwDPTd2Y
yGpNEd3AzcYOWqZC7q5qRngmwwuuNIfTHWDEW7rJ1emJTdb+y5gAiCQmIbcHi7Ca
cAo5+rZJ0g1NUDkZGwM1koldcMR3uJvHFT8Kwn7Hb1SvUfYqndhrcvVR7H9LibmE
vGt/+bPCQmwLOOT7oAkrJ3Y5nyaTHC4UmUtpxrUfJdV3+QV/uRtqdJpy2Jl0/MwZ
XlP3PsNYfybICYWCeCKwJf1bQucAW0Qdl0ZBSoDKpKZt59efPtdmFILfhngMDQ3g
5dJm6dd6NRh9/siQ3B5vdlzRlb2lQPUOBkJ9NQn3a1hVPoYzV0PNOeu6CUUlNGk=
=vjRj
-----END PGP SIGNATURE-----

--JbKQpFqZXJ2T76Sg--
