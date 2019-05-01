Received: from eggs.gnu.org ([209.51.188.92]:54242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLsFc-0003eJ-Cs
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLsFV-0008JW-TB
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:38:29 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:39671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hLsFT-0008Be-UM
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:38:25 -0400
Received: by mail-it1-x143.google.com with SMTP id t200so10641106itf.4
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 09:38:23 -0700 (PDT)
Date: Wed, 1 May 2019 12:38:18 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190501163818.GG21155@stefanha-x1.localdomain>
References: <1556604614-32081-1-git-send-email-wangjie88@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zrag5V6pnZGjLKiw"
Content-Disposition: inline
In-Reply-To: <1556604614-32081-1-git-send-email-wangjie88@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] vhost: remove the dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jie Wang <wangjie88@huawei.com>
Cc: qemu-devel@nongnu.org, eric.fangyi@huawei.com, wu.wubin@huawei.com, mst@redhat.com


--Zrag5V6pnZGjLKiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2019 at 02:10:14PM +0800, Jie Wang wrote:
> remove the dead code
>=20
> Signed-off-by: Jie Wang <wangjie88@huawei.com>
> ---
>  hw/virtio/vhost.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Zrag5V6pnZGjLKiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzJy3oACgkQnKSrs4Gr
c8hBFQf/e/Fr6WTm/gXOwl2i6yZWMUavOzlvbsWS7sWINHRnV5O/nxz2mgNq9fLi
EQWHxO/1Mo2AKo8N0A/XwJgsqVw7B3xn9FA7NRKdhTZLXbNDPLRjL90rGYFLTDoQ
cPWUx/2eA68zw+2pHs43X/TU/lWkFvO/B36tgFSYTJqiTotr/FK9GnE4GDt04XJ3
hQ5dNj1qH7vTZoBCetXVpg/I5xXXxznC16P566F5zKfM+nuVfqVT3+PMsXcxunea
c2WK1ZVzzMZch+xKbGmDcSqm9Nxq8vZEP86BgHy9sr34QWguqrlVV2pzLFs2+3js
CpDHT+lBJ0x/+RX5vYzS0CeFFPqj1A==
=UKPw
-----END PGP SIGNATURE-----

--Zrag5V6pnZGjLKiw--
