Received: from eggs.gnu.org ([2001:4830:134:3::10]:60430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGRHp-0005lB-2V
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 09:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGRHl-000619-8L
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 09:09:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cGRHl-00060b-1i
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 09:08:57 -0500
Date: Mon, 12 Dec 2016 14:08:54 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20161212140854.GG4074@stefanha-x1.localdomain>
References: <20161212111857.23399-1-pbonzini@redhat.com>
	<20161212111857.23399-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7uYPyRQQ5N0D02nI"
Content-Disposition: inline
In-Reply-To: <20161212111857.23399-7-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/11] virtio: add virtio_*_phys_cached
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


--7uYPyRQQ5N0D02nI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 12, 2016 at 12:18:52PM +0100, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/hw/virtio/virtio-access.h | 52 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--7uYPyRQQ5N0D02nI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYTq92AAoJEJykq7OBq3PIMGAH/1EGQXcNVkC3U0eZgaQkhPhI
GoKSVxY+EKGdZWm4wMl81KfCZ3L5jZE5jQnNbHSXFkWGUxQLxBHsNxQq1ojzO5WT
EiN/5VPJIJKmf08WLoUpvF+0kHog2VGe2PsW7MzrYj0CkLUqglnOwQhimljrBp0k
4hSpHJh2PXRkTGLk1m3fzs4sEm2vj/QP46hYx0IdQBN5FOdSrn59EiZbk4rzoSVg
GcQUToXTrnBz1X3rZWOHKEdklmVyVYk2uQt7uMDSeFZ6+7vHY3jurirBqETnBCL9
S4eujJzthf8zZDFm5klP1ObmsH6Zl4UFXDDYFPxz1yLUbu9Jl6uuq2REV2X3eHw=
=9Pbq
-----END PGP SIGNATURE-----

--7uYPyRQQ5N0D02nI--
