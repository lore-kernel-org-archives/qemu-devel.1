Received: from eggs.gnu.org ([2001:4830:134:3::10]:52344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOiOV-0001Td-Pn
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOiOS-0001bP-MS
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:38:55 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fOiOS-0001ab-FC
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:38:52 -0400
Received: by mail-wr0-x244.google.com with SMTP id k16-v6so8810831wro.0
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 04:38:52 -0700 (PDT)
Date: Fri, 1 Jun 2018 12:38:49 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180601113849.GI8687@stefanha-x1.localdomain>
References: <20180522194943.24871-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gTY1JhLGodeuSBqf"
Content-Disposition: inline
In-Reply-To: <20180522194943.24871-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw: allow compiling out SCSI
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


--gTY1JhLGodeuSBqf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 22, 2018 at 09:49:43PM +0200, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/mips-softmmu-common.mak | 1 +
>  default-configs/pci.mak                 | 1 +
>  default-configs/riscv32-softmmu.mak     | 1 +
>  default-configs/riscv64-softmmu.mak     | 1 +
>  default-configs/s390x-softmmu.mak       | 1 +
>  default-configs/sparc-softmmu.mak       | 1 +
>  default-configs/usb.mak                 | 1 +
>  hw/Makefile.objs                        | 2 +-
>  8 files changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--gTY1JhLGodeuSBqf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbETBJAAoJEJykq7OBq3PIOe4IAInn4GpbibhugsRQ4MqWI1u8
n619hSGB+qCo6RBgfMQn0TSUNn9HRuzphy9DN/RjSDGsiknk3haFe53lgLt9UNzT
91j19Zr+tWekx1eyBZt9G1v+dKZ21CdnuhAgsnFNq7gqHmKT68kx/3m0JxEWq+/a
7qa1jDY/EwTCaXsPFKIpvvGv28DdvNGHM8C5ThDrqIN8QKG60ddVBMQNVeAI2Zq4
62M1r/PcTe5WyYLmDrnIud29fHk0JjN/oMB4yXI87EB/kfEbSwuOtROUH4zMm1SG
r/xUfFdDF3j9p/ALC2DO01dY0lcASeMfeLvsQFuwunwEGstBR5l33u1029hUARI=
=jZi3
-----END PGP SIGNATURE-----

--gTY1JhLGodeuSBqf--
