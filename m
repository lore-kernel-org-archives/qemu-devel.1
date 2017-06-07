Received: from eggs.gnu.org ([2001:4830:134:3::10]:40164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIcuA-0007w1-1Q
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:29:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIcu9-00034c-71
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:29:54 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:37062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dIcu9-000346-10
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:29:53 -0400
Received: by mail-wm0-x230.google.com with SMTP id d73so13767089wma.0
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 08:29:52 -0700 (PDT)
Date: Wed, 7 Jun 2017 16:29:49 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170607152949.GH21990@stefanha-x1.localdomain>
References: <20170606072229.9302-1-haozhong.zhang@intel.com>
	<20170606072229.9302-2-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6cMF9JLEeZkfJjkP"
Content-Disposition: inline
In-Reply-To: <20170606072229.9302-2-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] nvdimm: add a macro for property
 "label-size"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, Dan Williams <dan.j.williams@intel.com>


--6cMF9JLEeZkfJjkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 06, 2017 at 03:22:26PM +0800, Haozhong Zhang wrote:
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
>  hw/mem/nvdimm.c         | 2 +-
>  include/hw/mem/nvdimm.h | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6cMF9JLEeZkfJjkP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZOBvtAAoJEJykq7OBq3PINuwIAKkbnR1bus2v3ltDgTXmyS5v
/kvsH9LOJbAbCSzqhHTymFUsDJL+ogEqh7ve/s80qiQK8YPipcfaUtR0y32HxSxt
vhmY9fQEcKpw10Gm1NpkzHqmN7kw+JeFlfPQmLDSEAcSrRU3vDn0q/qdJBqkYw53
UVR2cxcoTfDZBv0enS3Kk8FVyy0OqhTyqcrNyLBL58tKUP/1pJQzeJnO1qKBwF4N
aRmq3YJ0NcEufJ6MsNU4Od4xxESXXPnD0RDPd6K7uh5/dkkaVng2fO8OdjX+5pux
X0vFbhf5pycCMgCTQamGPW8T4TxjpHd0hPKw1V/lNOzDEkDIS+9lFGCBjiPW5ow=
=SLbK
-----END PGP SIGNATURE-----

--6cMF9JLEeZkfJjkP--
