Received: from eggs.gnu.org ([2001:4830:134:3::10]:40058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGhWP-0006Ki-Ns
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGhWP-0006Fq-0m
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:05:57 -0400
Date: Thu, 10 May 2018 10:05:48 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180510090548.GJ1296@stefanha-x1.localdomain>
References: <20180509145815.3330-1-famz@redhat.com>
	<20180509145815.3330-9-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fU0UwhtRbpo05rnG"
Content-Disposition: inline
In-Reply-To: <20180509145815.3330-9-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 8/9] block-backend: Add blk_co_copy_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>


--fU0UwhtRbpo05rnG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 09, 2018 at 10:58:14PM +0800, Fam Zheng wrote:
> It's a BlockBackend wrapper of the BDS interface.
>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/block-backend.c          | 18 ++++++++++++++++++
>  include/sysemu/block-backend.h |  4 ++++
>  2 files changed, 22 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--fU0UwhtRbpo05rnG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa9AtsAAoJEJykq7OBq3PIvTEH/RHxneaeU9O3lj7zM63zvbJl
IWz/05qjaws2Wyzv5z391wIUjCrldsr8Rs/IeED/NiAzvM2gxFLoSO+8RlaiEWJ1
OiRAhyL9spv3ELAiuyVkGwizgpeF7upxwxV60FXZUajq0jYYccCydW8kuOFv3kB3
6Yr275Y2N35fRbFpn7Co5ph7/oyE7CAeAI4HV3BD/1nlMoZuO1dEUE1q+cW/1C97
4kzevCZNYPNH+P6EAnMkNaNhDVplRwWxnc/fVzc7KBGjmYiwmcu/b9fEJvlYKtU4
oWfhc+ZqrIkXEZCe4z/PvitwrjSIY9Tkg5N55R305q3C+rBDZ9qwyBncWVlFJqs=
=lVT9
-----END PGP SIGNATURE-----

--fU0UwhtRbpo05rnG--
