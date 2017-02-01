Received: from eggs.gnu.org ([2001:4830:134:3::10]:33919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYxyb-00009t-0k
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 11:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYxyX-0006yI-M7
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 11:41:45 -0500
Date: Wed, 1 Feb 2017 16:41:38 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170201164138.GE12283@stefanha-x1.localdomain>
References: <1485800032-24404-1-git-send-email-hch@lst.de>
	<1485800032-24404-3-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline
In-Reply-To: <1485800032-24404-3-git-send-email-hch@lst.de>
Subject: Re: [Qemu-devel] [PATCH 2/2] nvme: Implement Write Zeroes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christoph Hellwig <hch@lst.de>
Cc: qemu-devel@nongnu.org, keith.busch@intel.com, qemu-block@nongnu.org


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2017 at 07:13:52PM +0100, Christoph Hellwig wrote:
> From: Keith Busch <keith.busch@intel.com>
>=20
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> [hch: ported over from qemu-nvme.git to mainline]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  hw/block/nvme.c | 27 ++++++++++++++++++++++++++-
>  hw/block/nvme.h |  1 +
>  2 files changed, 27 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkg/CAAoJEJykq7OBq3PIYjEIAMYi74/kxfq/fS9P/cHj23Yl
dn387/yMyznu4M+YcyiZ+kWk1DbWPLezrMpruVs7Bf33QO+JELTbzEEHz+NRk/ur
bD4iqCzsIROHokgbXv7+uJjcTVcjt9ypBOqd0NT2+TbtraXgOYUtwmm4QmKMVy/Z
8MHAYJDSd4KSG5MOWaXeXclZJHYNcVd2L5reyIsFNjebRM7DOM+5UOOqJ7Gm8lMi
eGvMwzYMKHeyYkgQr5ZNV2JUgV9xvkPHkmIF2qrcXrqoy/Vjc8zAN3NfW1rJzeiZ
3uw8ti6IhT0n5oyw/NYdjCTSaC5E5TFKC4XPLcNJVPJAtxowGLZY7SK5IxZKEm8=
=1anl
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--
