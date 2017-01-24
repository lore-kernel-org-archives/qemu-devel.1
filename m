Received: from eggs.gnu.org ([2001:4830:134:3::10]:57217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cW0R9-0000xt-NP
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:43:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cW0R9-0003ik-04
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:42:59 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cW0R8-0003if-QC
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:42:58 -0500
Received: by mail-wm0-x244.google.com with SMTP id r126so34414080wmr.3
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 04:42:58 -0800 (PST)
Date: Tue, 24 Jan 2017 12:42:55 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170124124255.GH17221@stefanha-x1.localdomain>
References: <20170120170757.30308-1-pbonzini@redhat.com>
	<20170120170757.30308-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Enx9fNJ0XV5HaWRu"
Content-Disposition: inline
In-Reply-To: <20170120170757.30308-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/7] virtio: make virtio_should_notify
 static
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


--Enx9fNJ0XV5HaWRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 20, 2017 at 06:07:51PM +0100, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/virtio/virtio.c         | 2 +-
>  include/hw/virtio/virtio.h | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Enx9fNJ0XV5HaWRu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYh0vPAAoJEJykq7OBq3PIqA4H/RYUAXDpGuRskXVAZAZXhlbq
t9rXXYYm8hNkkHlhANumiEAwEQCla7gbk/Eo65h/GfmEvPMy7oDUSepeR6TwvQcr
AbrMSAceLIRO712Iw2KNIijZ+Ts8Dc+TaWy+iqmRr1ka71igrtVu32tVJ7FnRjct
649lx9aZu5AmtqbVoOxMm5VOyE6pAk19wWyVlE78VIpESXxXBtSTsVD0WrmGsPKy
PHCDzFGmASrh/rp7EHV6DHGttruo1fhqz9Xww4s1hDlRSdJYplgVeeCAs5XZ0MJl
FvNM6SKzJSXv+TiwoOALZgYJIReUK5L6LB1FaBu5iH2khLv77j/CEaEt4UFkBXg=
=Opks
-----END PGP SIGNATURE-----

--Enx9fNJ0XV5HaWRu--
