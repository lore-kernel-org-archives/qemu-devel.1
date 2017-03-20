Received: from eggs.gnu.org ([2001:4830:134:3::10]:49454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpvXR-0003L2-Vi
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:31:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpvXR-0004vY-1P
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:31:49 -0400
Date: Mon, 20 Mar 2017 11:31:41 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320113141.GP17887@stefanha-x1.localdomain>
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214117.27350-7-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sj9mcRtP+pTWLOo"
Content-Disposition: inline
In-Reply-To: <20170313214117.27350-7-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 16/16] iotests: Add preallocated
 growth test for qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--6sj9mcRtP+pTWLOo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 13, 2017 at 10:41:17PM +0100, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/125     | 130 +++++++++++++++
>  tests/qemu-iotests/125.out | 386 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 517 insertions(+)
>  create mode 100755 tests/qemu-iotests/125
>  create mode 100644 tests/qemu-iotests/125.out

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6sj9mcRtP+pTWLOo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz72dAAoJEJykq7OBq3PIYxwH/j2oQjBg5Nem0exO38vaatkj
NXqbGZ8URY5U4l5YysrkXgcaVtNJFPSWe+MSfrO+2wtSzSWpnZ/BWquAG/l0vp7b
MRhhOXf3vXJNWFJEt0DX+/VC5rrGJu/ysb4c5EcEp2nrVH2/spTV80Q6iSBxCCB3
l/RoJ2vt/EocMWxS5NhWQPLiEyohWPPZQwuKKD2ip8UuTwqma24hkUp7usy1YVyl
U0L4zodqxPMpni5S98yzGIWz+tXI4YODTidZ05BoSK4GFyCHhUjkIpPzteNWIJnC
6Ibe2M2bHqnBveYzq9uMLajeqRmGVhTaKrmCJydxp3/iGwZ1S0Qyx4+g3EHECe0=
=NI3U
-----END PGP SIGNATURE-----

--6sj9mcRtP+pTWLOo--
