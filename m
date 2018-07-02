Received: from eggs.gnu.org ([2001:4830:134:3::10]:42959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fZz0H-0002i7-R7
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fZz0E-0004VU-Mc
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:36:29 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:44876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fZz0E-0004VC-FJ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:36:26 -0400
Received: by mail-wr0-x243.google.com with SMTP id p12-v6so15581941wrn.11
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 06:36:26 -0700 (PDT)
Date: Mon, 2 Jul 2018 14:36:23 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180702133623.GG2155@stefanha-x1.localdomain>
References: <20180629135447.29100-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RMedoP2+Pr6Rq0N2"
Content-Disposition: inline
In-Reply-To: <20180629135447.29100-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] update Linux headers to 4.18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org


--RMedoP2+Pr6Rq0N2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 29, 2018 at 03:54:47PM +0200, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/standard-headers/linux/virtio_config.h | 16 ++++++++++++----
>  linux-headers/asm-mips/unistd.h                | 18 ++++++++++++------
>  linux-headers/asm-powerpc/kvm.h                |  1 +
>  3 files changed, 25 insertions(+), 10 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--RMedoP2+Pr6Rq0N2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbOipXAAoJEJykq7OBq3PIeNoH/1M9Tm4zIrDc2/RP2qYfgTq4
Q4pJ5WlzJNyp/ZA+oHu3mzMbou4vMPFeACrvYup+5CdZLq8HD4M3MHlj/pUrC3kn
ePAkenoNyuNaoFBwpVApUcdKpoL4wuMeqJW9763v2htimX63PWYtBLArw1zefQvj
DEBveu90/gAFtcfRZuZ7imUZNVH5X8QZdxIQLHtJLuUCrZ8yu6G+3gV+x3zwX3q3
Vkj316q5PHpHBHDpjYhzc7XpumOMiYqAwjYF8wc8KS1eBvfznXfPi5HZkUrvUSB6
FnT2M6aHCjMfdh7EAt57TbR9mKU1+Hg4RM89CMYTYRjCktCCkxDhiAfEdqKCkH8=
=GGV+
-----END PGP SIGNATURE-----

--RMedoP2+Pr6Rq0N2--
