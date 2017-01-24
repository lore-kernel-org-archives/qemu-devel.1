Received: from eggs.gnu.org ([2001:4830:134:3::10]:57323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cW0RI-00018e-UW
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:43:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cW0RD-0003k5-SO
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:43:08 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cW0RD-0003jg-Mp
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:43:03 -0500
Received: by mail-wm0-x243.google.com with SMTP id d140so34519410wmd.2
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 04:43:03 -0800 (PST)
Date: Tue, 24 Jan 2017 12:43:00 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170124124300.GI17221@stefanha-x1.localdomain>
References: <20170120170757.30308-1-pbonzini@redhat.com>
	<20170120170757.30308-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OfrWf2Fun5Ae4m0Y"
Content-Disposition: inline
In-Reply-To: <20170120170757.30308-3-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/7] virtio: add virtio_*_phys_cached
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com


--OfrWf2Fun5Ae4m0Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 20, 2017 at 06:07:52PM +0100, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/hw/virtio/virtio-access.h | 52 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--OfrWf2Fun5Ae4m0Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYh0vUAAoJEJykq7OBq3PImG0IAIQgZrhFLduYw1KgxJaTjYBf
RBh+XkibDKGBYgd6d7opQ++O088ibUf8HE7OzD0+TXjoDltnMkA9DDp5rzWWQHJS
QC9qqglc9m3GvEQWEAmKZn0g1Fy6Rsq5u2KCS0h1ImR3EhE8Bofi4YeRfftZdW0Z
6jrrYt2fk0tBK4AgRMc4/srdgak0PB3+mo+2bKVcfzBcwfHm8ahGvPO86AVMcjlA
azc0i3yAcS9yTjqHamcsSnfppYD+F4Bl5kmgFM55EnRRppUC8vspU3g2/Km8KNuQ
oF/L6bm08oCwrWIPIZll4cOObmLDj/WB6frxvKFWi4rajdsrKNw8jQqPwqkP1do=
=Tl5F
-----END PGP SIGNATURE-----

--OfrWf2Fun5Ae4m0Y--
