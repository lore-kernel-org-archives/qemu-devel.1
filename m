Received: from eggs.gnu.org ([209.51.188.92]:34215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpf1R-0005lj-8i
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 15:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpf1Q-0000Do-6u
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 15:02:44 -0500
References: <20190201192935.18394-1-mreitz@redhat.com>
	<20190201192935.18394-7-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3c8e93b7-7404-10d0-46d4-aa1b9f76053d@redhat.com>
Date: Fri, 1 Feb 2019 14:02:23 -0600
MIME-Version: 1.0
In-Reply-To: <20190201192935.18394-7-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RcbjOVuNSjhOO6aFOkX8BPbWFoFzYiBcw"
Subject: Re: [Qemu-devel] [PATCH v13 06/31] iotests.py: Add filter_imgfmt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RcbjOVuNSjhOO6aFOkX8BPbWFoFzYiBcw
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <3c8e93b7-7404-10d0-46d4-aa1b9f76053d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v13 06/31] iotests.py: Add filter_imgfmt()
References: <20190201192935.18394-1-mreitz@redhat.com>
 <20190201192935.18394-7-mreitz@redhat.com>
In-Reply-To: <20190201192935.18394-7-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/1/19 1:29 PM, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--RcbjOVuNSjhOO6aFOkX8BPbWFoFzYiBcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxUpc8ACgkQp6FrSiUn
Q2o0cwf/SRBWupRqvmcRCzgaw4OcHVx9rCUX2wG8fGwnyleQhVPswPNhneuHB/s6
26yOFuNCSgNsCRmAX2QXARXqU1TeRdDiRSlYPOtO1Sr03tiQhUamyJxq9XlKb/9d
S1Kn+vc/8wnGFpC2A3mvZNqhR8qyD/T/p2125ZJOwWCipmyOWrbppibJufRxlXPQ
5NpHquYAzLyyyCsZmuUrFRKeCB4ohekAYporHCqVTKkaFyD0mNnqNlydt9IKCA23
x2D4Vb/ix+wXBGW8ZUsXVVCLLnwq7k2NNrqhc+0Yg+F5E3BSrUHUu+yv8JteoMxk
mOrwJACKidy4FXNbhMGrhitn+u1zdw==
=K4Yl
-----END PGP SIGNATURE-----

--RcbjOVuNSjhOO6aFOkX8BPbWFoFzYiBcw--
