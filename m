Received: from eggs.gnu.org ([2001:4830:134:3::10]:46775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdfQ-00017f-Fn
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdfL-00024Z-PD
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:42:20 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dFdfL-00024T-Fo
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:42:15 -0400
Received: by mail-wm0-x232.google.com with SMTP id b84so84675116wmh.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 02:42:15 -0700 (PDT)
Date: Tue, 30 May 2017 10:42:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170530094212.GL11362@stefanha-x1.localdomain>
References: <1496048740-26578-1-git-send-email-groug@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NPWyolIJAVLYbHY6"
Content-Disposition: inline
In-Reply-To: <1496048740-26578-1-git-send-email-groug@kaod.org>
Subject: Re: [Qemu-devel] [PULL 00/11] 9pfs patches for 2.10 20170525
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>


--NPWyolIJAVLYbHY6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2017 at 11:05:29AM +0200, Greg Kurz wrote:
> The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d19b=
60:
>=20
>   Merge remote-tracking branch 'jasowang/tags/net-pull-request' into stag=
ing (2017-05-23 15:01:31 +0100)
>=20
> are available in the git repository at:
>=20
>   https://github.com/gkurz/qemu.git tags/for-upstream
>=20
> for you to fetch changes up to f0a4da86cff2e600255324793daddd7ce59b9862:
>=20
>   9pfs: local: metadata file for the VirtFS root (2017-05-25 10:30:14 +02=
00)
>=20
> ----------------------------------------------------------------
> Various bugfixes and code cleanups. Most notably, it fixes metadata handl=
ing in
> mapped-file security mode (especially for the virtfs root).

Please fix the compiler warning reported by patchew.

Thanks,
Stefan

--NPWyolIJAVLYbHY6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLT50AAoJEJykq7OBq3PIuAAH/1JSL79GxpOcHIoGpu2k/aKi
gZ5M2dxZlm7EtyX+x/09Y5K6pMPXefpAjuGS15ZUANTLCxxw6g/+cSmuOaCc4Jno
AchUYV7qL0cVl+f8KDHMvsIje7OriN3sZecvkqbNAhJGd9ld6BvbPZBUKvvrZQYt
dVmJncPH+imnpK8f6j4jmO42yW9G5A5nK7gbKjN/2XdIVHIBzIlRt0++sBBrifld
uIyyWwujisf6UY8R/+yVxzqcqhB8gEbVzhg2pIVfbpjuN2Cwaop2qikgsFh9Gn7D
am6QMzi43ufKKzBlF1YjhEJzuzi/kBKFLieyNy87cP5ylQ93cAEqcQJKUzjAWhw=
=n3jr
-----END PGP SIGNATURE-----

--NPWyolIJAVLYbHY6--
