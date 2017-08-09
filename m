Received: from eggs.gnu.org ([2001:4830:134:3::10]:35516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dfNOo-0006Vz-3S
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dfNOn-00062i-44
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:35:34 -0400
Date: Wed, 9 Aug 2017 10:35:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170809093525.GF18003@stefanha-x1.localdomain>
References: <20170808175711.12203-1-jsnow@redhat.com>
	<20170808175711.12203-3-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ChQOR20MqfxkMJg9"
Content-Disposition: inline
In-Reply-To: <20170808175711.12203-3-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/4] IDE: test flush on empty
 CDROM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, pjp@redhat.com


--ChQOR20MqfxkMJg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 01:57:09PM -0400, John Snow wrote:
> From: Kevin Wolf <kwolf@redhat.com>
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/ide-test.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ChQOR20MqfxkMJg9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZitddAAoJEJykq7OBq3PIu/YH/2Q1kqVAcDSVsNgBnu5amirL
ChnZn4ilBVcyX31VAeFXp05tJb0U5HiTR/UwBa/a4l6lme9/nC1lEi271uMdyoBM
pcReicGwIF7G54p2sJdsuBHPKVvnduFQbt0HfuTUS2av3debxJrZR7K/S7oLy37X
kV7PQO5u9PGnHh0XRbWFV39aYSL2QvDjswUzYBIKzSAUH4lLPOnXG19ChaEO0mqX
p21U+aohobXbNPqK1F7aVT+djCR/Du7Ld26PahgeJ2yOmjbWYmze5JeEZUKFtJmd
17g8i8mJot+DyXCCAd1p9P6d8mN9N1pEub/6lzYiGqvJv7uMbYYlSuTnaiV7wZw=
=w9a+
-----END PGP SIGNATURE-----

--ChQOR20MqfxkMJg9--
