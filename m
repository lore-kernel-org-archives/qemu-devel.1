Received: from eggs.gnu.org ([2001:4830:134:3::10]:38440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fD79E-0003DR-ES
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 07:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fD799-0007SM-Gb
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 07:39:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36936 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fD799-0007Rw-Cj
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 07:39:07 -0400
Date: Mon, 30 Apr 2018 12:38:58 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180430113858.GH4002@stefanha-x1.localdomain>
References: <20180427215314.23168-1-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G44BJl3Aq1QbV/QL"
Content-Disposition: inline
In-Reply-To: <20180427215314.23168-1-ross.zwisler@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] nvdimm: fix typo in label-size
 definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, linux-nvdimm <linux-nvdimm@lists.01.org>


--G44BJl3Aq1QbV/QL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 27, 2018 at 03:53:12PM -0600, Ross Zwisler wrote:
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> Fixes: commit da6789c27c2e ("nvdimm: add a macro for property "label-size"")
> Cc: Haozhong Zhang <haozhong.zhang@intel.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/mem/nvdimm.c         | 2 +-
>  include/hw/mem/nvdimm.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--G44BJl3Aq1QbV/QL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa5wBSAAoJEJykq7OBq3PIk/kH/RoW13NFOdFjOsF/XyAMK+iO
Gs7ZV9VWu/1Mh/mR7SJkp0IXI9ugKD35Rwo+C9AWSBbecGs4FBkmgK8891OhAFLe
yN5cNNcTJX3zUFxtMV3UwhfjIcsR3v5AJNC4g3hWaB0z3XvCeN9aXh6FUTMQPH2H
6+eR3Tq3s3tTfC+BDAAMq1+xv2mlKmKa34pAWLpjrz9ui5mVVm//3cxc3HWlwErZ
ae3a4IfwcguhD1M/gclnrtrJxyQUN5ZgX8+QqFrzhtw9SYL9FycXQ46anUt11NVM
eKbux2EVi5z9kf15eP30pud2YmxkPtwDKFz50uW29jUM0lpON3Ja5741ivR5bKI=
=Q9lk
-----END PGP SIGNATURE-----

--G44BJl3Aq1QbV/QL--
