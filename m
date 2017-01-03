Received: from eggs.gnu.org ([2001:4830:134:3::10]:39885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cORUv-0006TJ-TE
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:59:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cORUv-0007KB-8V
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:59:38 -0500
Date: Tue, 3 Jan 2017 15:59:29 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170103155929.GG14707@stefanha-x1.localdomain>
References: <CAKJ7aR7kDde_KrCMojwdU1kaSvK+zw_wM49__EcA+=kO+fT+Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V32M1hWVjliPHW+c"
Content-Disposition: inline
In-Reply-To: <CAKJ7aR7kDde_KrCMojwdU1kaSvK+zw_wM49__EcA+=kO+fT+Hw@mail.gmail.com>
Subject: Re: [Qemu-devel] Qemu NVME ubuntu 16.04 setup problems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gadre Nayan <gadrenayan@gmail.com>
Cc: qemu-discuss@nongnu.org, qemu-devel@nongnu.org, linux-nvme@lists.infradead.org


--V32M1hWVjliPHW+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 26, 2016 at 01:59:13PM +0530, Gadre Nayan wrote:
> I am trying to test SPDK on a Virtual Machine with NVME support. I do not
> have NVME cards on the Host hence wanted to simulate the Hardware, I have
> install nvmeqemu (https://github.com/nvmeqemu/nvmeqemu) for that purpose.

That repo hasn't been updated since 2012.  NVMe support has been
available in upstream QEMU since 2013.

Please try using a modern QEMU.

--V32M1hWVjliPHW+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYa8phAAoJEJykq7OBq3PIynwH/2CKtM6n5ixoVdPDeekhzjmX
eAJX6MyzPFA/46JKPcraMIOroTjoPlnruleVyNjo0tfAvYJZMxCdZkEyoCpz2ARP
GtetnsEBqNXrMvPpJt+pUEv3c88mF7ypVyDdnOKPKywHri1g+MFffeextG15UN9J
zs+RI0TGDYicCN9CMBo3Yja9p+0ycXH15OiC5O1WiJJgOvX8G0c9xKgd5/A3qYtG
PkjunybxJPUs0j+Ed60f4pu9gUaCB3OjYW84QV9SpTy6bNgDfAPalySNKLRTCemF
qcB9rkEAcRjlw2uo+8fens/07DOkeMIaFzdN/m9PLdzlN1JBITRLmQZ7UkZgj2c=
=9+e3
-----END PGP SIGNATURE-----

--V32M1hWVjliPHW+c--
