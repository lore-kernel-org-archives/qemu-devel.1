Received: from eggs.gnu.org ([2001:4830:134:3::10]:59632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGRG0-0004xe-RV
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 09:07:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGRFy-0004nb-TC
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 09:07:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cGRFy-0004n4-NW
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 09:07:06 -0500
Date: Mon, 12 Dec 2016 14:07:04 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20161212140704.GF4074@stefanha-x1.localdomain>
References: <20161212111857.23399-1-pbonzini@redhat.com>
	<20161212111857.23399-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bGR76rFJjkSxVeRa"
Content-Disposition: inline
In-Reply-To: <20161212111857.23399-6-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/11] virtio: make virtio_should_notify
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
Cc: qemu-devel@nongnu.org, famz@redhat.com, mst@redhat.com, borntraeger@de.ibm.com


--bGR76rFJjkSxVeRa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 12, 2016 at 12:18:51PM +0100, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/virtio/virtio.c         | 2 +-
>  include/hw/virtio/virtio.h | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--bGR76rFJjkSxVeRa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYTq8IAAoJEJykq7OBq3PIUTgH/jwiMICjQ1ArSknuhqPvXJDi
VCNJjKTwRASWKCiWLIKKFPONrQezeOr1EcTMd5WdK9LoOr8yOCdVr76q1h3hY0Bh
mZ8S6NGBYEDpMbcj0tRMosQyfpeNRvPn7hpcuVNVH3/6EKdzX/b0pmPCPHyMYchh
BWbWm7CssRGZlcdlb7EUzZPu/zBNK+wTs2MIDNhLBDIhuU9i1onjt1ox9n5dYY8G
dVIu0mXeKZxvZBX/js6uBGUvMX2uANmgwUt9agHnx6Y+M+NO/ZT8bIwaBeqtW12J
DE3kEKii7DCsVWYLdoueFoBSv/4WRKHQWvQeNXWOq9jus3P3OmwDawokOXgYnxA=
=zt2C
-----END PGP SIGNATURE-----

--bGR76rFJjkSxVeRa--
