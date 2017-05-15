Received: from eggs.gnu.org ([2001:4830:134:3::10]:60642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAFWQ-0001e3-5X
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAFWN-0003h8-5K
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:54:46 -0400
Date: Mon, 15 May 2017 13:54:39 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170515125439.GA1201@stefanha-x1.localdomain>
References: <20170505021500.19315-1-eblake@redhat.com>
	<20170505021500.19315-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20170505021500.19315-3-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH 2/2] block: Exploit
 BDRV_BLOCK_EOF for larger zero blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 04, 2017 at 09:15:00PM -0500, Eric Blake wrote:
> When we have a BSD with unallocated clusters, but asking the status

s/BSD/BDS/

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGaUPAAoJEJykq7OBq3PI+XcH/RNCIBtn0wbdPFe3Qgmrdtzc
MWrQ9tBufeuAEDWa7WIQqF9iDr7r1btBPfGrN8P9YcpBK+ItGtRivTcpgSPKg34v
d0Jv3AnoT+vyDhQlp568ajNheFqj866S80TB295IfZFmN2Ye/J1eXWO+3LTXrpHU
CENW9SlYxELJ2FxyPG1Q28930UCBmnCPfeH0xYragwPj74tyqbuKbqyUMMa01ey1
1N16J512YWTZj646Ki+zR1VdMUdosbNDbFZj7pivTEjNoNYLJCAENXTPUw6gX87E
lF0mqB/j9E/XDL4WY2iJkIFDOuPLsxnub+GQVnXySnmmCppxyAfqnFSx8oGg8QI=
=w1PG
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
