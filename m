Received: from eggs.gnu.org ([2001:4830:134:3::10]:51013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dO1iy-0006fq-S3
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 09:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dO1iv-00045Q-PU
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 09:00:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dO1iv-000459-IT
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 09:00:37 -0400
Date: Thu, 22 Jun 2017 14:00:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170622130022.GB27999@stefanha-x1.localdomain>
References: <20170622033231.19344-1-f4bug@amsat.org>
	<20170622033231.19344-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <20170622033231.19344-2-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2 01/21] tests: add missing dependency to
 build QTEST_QEMU_BINARY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2017 at 12:32:11AM -0300, Philippe Mathieu-Daud=E9 wrote:
> This allow a one liner from fresh repository clone, i.e.:
>=20
>   ./configure && make -j check-qtest-aarch64
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZS79mAAoJEJykq7OBq3PId0oH/0XY9OvNQGQAU1MYXiRZ2EPh
siVbMlLjIZQm05qbm1qKd2UsSQbCW3NaefyrKpBDAJP9Jl4+YEcSVv6QfBt0/a+v
EYcMKL4qxUsEF8zdpIl7ojX77m1PL6BOfbl5OZ74gV8Td5F7j7Ant7lDxmmsJNz+
b6ZQA1nlsvbdF2qAf88ErLmVsWvlW3pwyGacfOpAKGVE10bNPipLuO4DJEnOHBz6
RBPgllX5sv5el8uTmvOScBmTQiGuSrKGAM9L8McGbEdWhSZ3/Zq40tWa2CN3TiZ9
XA28XhjpAv1W8LAJVsqKdj/qGmVmodY3LL5kiD4CCp9n8ls4/z0DY2UT3TI/AxI=
=7/we
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
