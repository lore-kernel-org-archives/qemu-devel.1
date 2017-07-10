Received: from eggs.gnu.org ([2001:4830:134:3::10]:46000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUaCA-00082M-TC
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUaCA-0006m2-8r
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:01:54 -0400
Date: Mon, 10 Jul 2017 16:01:42 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170710150142.GJ14195@stefanha-x1.localdomain>
References: <20170705133635.11850-1-famz@redhat.com>
	<20170705133635.11850-7-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P6YfpwaDcfcOCJkJ"
Content-Disposition: inline
In-Reply-To: <20170705133635.11850-7-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 6/6] block: Move NVMe spec definitions
 to a separate header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Karl Rister <krister@redhat.com>


--P6YfpwaDcfcOCJkJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 05, 2017 at 09:36:35PM +0800, Fam Zheng wrote:
> diff --git a/block/nvme.h b/block/nvme.h
> new file mode 100644
> index 0000000..ed18091
> --- /dev/null
> +++ b/block/nvme.h
> @@ -0,0 +1,700 @@
> +#ifndef BLOCK_NVME_H
> +#define BLOC_NVMEK_H

s/BLOC_NVMEK_H/BLOCK_NVME_H/

--P6YfpwaDcfcOCJkJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZY5bWAAoJEJykq7OBq3PIk6MH/irnWhOGh1/2CUYE1NNyXsJz
d60+RKfZPYDdZk1AtxFeDA127snqok3XiO64MhJbID2dAy0UofFgBVgWGCxq0+Qo
C9T20oUKJw3BhYWQnB6bPmZHpqTr9ZjrPcCkxkH2ti1Yv9yjXrdfO4lZZA9zQiOR
s3Xsy9z2E2UwC6P+lrYMTtavOSn6Bc3ijyrD8jpIc+yLBROxiRH+9QfW328Lz3yX
Psh2qzuQYlq4H9qnAkAbxVSeacp6JXdCryqZD+4nXuI44b2FyHe1KtvDwlEzvjxy
YacbhFRu9RJrK8QAtnr+6mBIyJvanaLntqp555eDsQxOmKTEaAqoLuvo1tnFYv0=
=IW6a
-----END PGP SIGNATURE-----

--P6YfpwaDcfcOCJkJ--
