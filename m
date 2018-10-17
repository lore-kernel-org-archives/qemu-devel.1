Received: from eggs.gnu.org ([2001:4830:134:3::10]:46089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gCiHD-0000Df-Ms
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gCiH7-0003EK-Mz
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:38:02 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gCiH7-0003Cc-F1
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:37:57 -0400
Received: by mail-wr1-x444.google.com with SMTP id e4-v6so28863669wrs.0
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 02:37:57 -0700 (PDT)
Date: Wed, 17 Oct 2018 10:37:54 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181017093754.GI22755@stefanha-x1.localdomain>
References: <20181016112232.23241-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a7XSrSxqzVsaECgU"
Content-Disposition: inline
In-Reply-To: <20181016112232.23241-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] pckbd: Convert DPRINTF->trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org


--a7XSrSxqzVsaECgU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 12:22:32PM +0100, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/input/pckbd.c      | 19 ++++++-------------
>  hw/input/trace-events |  7 +++++++
>  2 files changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--a7XSrSxqzVsaECgU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbxwLyAAoJEJykq7OBq3PIK2sH/j/pBEeiVgvwcsk1KUmIdD//
Lpe7bdXhEWnMpIwOTnWLEWoEPUkzxaJlW/HuHCMuJj58KqmctCmVrHl8njVXOG/v
T+v65k9gPpxQs/ZDWLD6b1IXRsvGMiKwC4+ys35/OozCipHQohTnEXRNcWO0iZ8h
GWAgDl3TgKueeykBsbbsRoOdTPnZrhCm1BwJUp8pSvi7mbABm2bnnPDz6SiywNz7
qU+Jk9twYNb3vI0A+OFSKro2P9UbjJoTqq20Y8WN46SloDNFYG/r0v5hXfpdpYGa
LxINBtHFKL658qzF53Rd//s5FDz7VGle6SX0cj4gRCGfeYm16nq00dVFLCCLNd8=
=+Q9Y
-----END PGP SIGNATURE-----

--a7XSrSxqzVsaECgU--
