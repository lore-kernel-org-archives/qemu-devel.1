Received: from eggs.gnu.org ([2001:4830:134:3::10]:34337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGRKm-0007r4-H9
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 09:12:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGRKl-0008CC-RK
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 09:12:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33721)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cGRKl-0008BR-Mr
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 09:12:03 -0500
Date: Mon, 12 Dec 2016 14:12:01 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20161212141201.GH4074@stefanha-x1.localdomain>
References: <20161212111857.23399-1-pbonzini@redhat.com>
	<20161212111857.23399-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dMyqICaxQaaUjrCL"
Content-Disposition: inline
In-Reply-To: <20161212111857.23399-8-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/11] virtio: use address_space_map/unmap
 to access descriptors
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


--dMyqICaxQaaUjrCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 12, 2016 at 12:18:53PM +0100, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/virtio/virtio.c | 78 +++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 60 insertions(+), 18 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--dMyqICaxQaaUjrCL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYTrAxAAoJEJykq7OBq3PIhNcH/24AQNtfQLfgk4PFGD5li4si
19zvP1uePg8X67RG94pRYvfSI2bDRYePBJxrZc0aHo5cNvEHY/8M89FIIEVIk/nx
Sk9sFWQfkXxhwCZQagUraZdfqxigScrkWF8z39zFd11Cw+shSwafOIR++wjny3pY
v/p7mjdGy8vh+FMk+Chfa0ESKukv6EttNL4aMcf9CAC1SrcBwmUfR0vTtF1YoWWB
Y+Y3LX/7JDI5hUhHydjA/WApundz2hFnANgeJMFmd74c7xXOcS4psxfAx/XRyf6I
czl5On8ZvAjRFGuxWIfNeO34D2kjds9bz8ciBlO9l8XaMXc8jiMgdLc3RZHnj7c=
=EEij
-----END PGP SIGNATURE-----

--dMyqICaxQaaUjrCL--
