Received: from eggs.gnu.org ([2001:4830:134:3::10]:46084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1exxb2-0003pG-SM
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1exxay-000709-Un
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:25:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33472 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1exxay-0006yW-QE
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:25:12 -0400
Date: Mon, 19 Mar 2018 16:25:02 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180319162502.GA21259@stefanha-x1.localdomain>
References: <20180319131743.3885-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20180319131743.3885-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-2.12] gitmodules: Use the QEMU mirror
 of qemu-palcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Richard Henderson <rth@twiddle.net>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 19, 2018 at 01:17:43PM +0000, Peter Maydell wrote:
> We have a mirror of the qemu-palcode repository on
> git.qemu.org; use that instead of the upstream github,
> in line with our general policy of keeping and using
> a mirror for submodules.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> We also currently have two submodules we don't have mirroring
> for: seabios-hppa and u-boot-sam460ex.
>=20
>  .gitmodules | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The git.qemu.org mirror appears up-to-date:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJar+ReAAoJEJykq7OBq3PItXIIAJvhXrvSbsg1f14nv9812XX5
kHmQRUC9CkPMQl26wjAaecDKHlwsqayXB2b3Wf3mhZq1ZwhNwGL8KHWP/h4pS6ZC
KkNa3mDJVcS5DrKn70zyg6rki+ed4aOYqMC6x0XnxxBbX0wUO4RJz3y2OaU2RRii
7eSMZDGgfILGJTnbJSc0e/gddhtSbUwqR4ftYb+Cnn4gWP1KYXiubXQfh4z330Us
KQ87e4YDV88a70KKjUv1w95wQ8MBX4/tnKAN98I9GNsAyvtUCfugEw5J5pW/YEgs
ZP4xFiZLW8MXmzB4/rDtJlBx52cDpbC8Zf3Av9imsFcIVMjPl0kDhKNlLgYSGec=
=Giu1
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
