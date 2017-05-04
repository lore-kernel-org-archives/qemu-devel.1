Received: from eggs.gnu.org ([2001:4830:134:3::10]:57146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6HKr-0001wI-M7
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:02:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6HKk-0008BZ-9E
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:02:25 -0400
Date: Thu, 4 May 2017 15:02:14 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170504140214.GO32376@stefanha-x1.localdomain>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AKkMM/tm2Mk6Yn/s"
Content-Disposition: inline
In-Reply-To: <20170420120058.28404-11-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 10/17] block: use Stat64 for
 wr_highest_offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org


--AKkMM/tm2Mk6Yn/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 20, 2017 at 02:00:51PM +0200, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/io.c                | 4 +---
>  block/qapi.c              | 2 +-
>  include/block/block_int.h | 7 ++++---
>  3 files changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--AKkMM/tm2Mk6Yn/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCzRmAAoJEJykq7OBq3PIZCIIAKGNn3ctlm7cKlOql25I06ca
qppWJRtzmRZ8pou+0g5xctDCsUO2PsjqvTTPPPe5ulPrpawSVcz+iFAos8nnt0z9
fwX1QfFarREdqIj2Dz5fU640AveSY69IDqhowz18wqAY5kDF6qEJaVGkf/ZWi/ZR
/YMV40yz8XtEnaWpRjd7coCZsJQVmztjKxqUwEh2eo7uC5pqEgOFuWruX8WCwLDI
s/RK2Tf5MY6Qac74PxEIDZjwVwO+9T758dlzQpg40E9C0bjb4hgVI4gXiAAqb+b/
arvk9RtJ7teFvxmxQnp3Spya1yuLKY9SK6DeMM2npeWa7qY0sRRShZES4x2xdTc=
=vO25
-----END PGP SIGNATURE-----

--AKkMM/tm2Mk6Yn/s--
