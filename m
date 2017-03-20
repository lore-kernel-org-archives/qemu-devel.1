Received: from eggs.gnu.org ([2001:4830:134:3::10]:49160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpvWj-0002qf-Jc
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpvWi-0004mj-QS
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:31:05 -0400
Date: Mon, 20 Mar 2017 11:30:56 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320113056.GO17887@stefanha-x1.localdomain>
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214117.27350-6-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7gLe/sNPhR777EPF"
Content-Disposition: inline
In-Reply-To: <20170313214117.27350-6-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 15/16] iotests: Add
 preallocated resize test for raw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--7gLe/sNPhR777EPF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 13, 2017 at 10:41:16PM +0100, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/106     | 92 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/106.out | 50 +++++++++++++++++++++++++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 143 insertions(+)
>  create mode 100755 tests/qemu-iotests/106
>  create mode 100644 tests/qemu-iotests/106.out

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--7gLe/sNPhR777EPF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz71wAAoJEJykq7OBq3PIeVkIAJWDc964Hql4oYTIj62Xz+ne
mOfAM9JNzLfpusYH/PooZZMhxiUEbusrNTQ4/lTHWPKsrT58TGQw5P1hsM69UPGs
053cTD5L5iDSnVVGsJPmNX+lXuuvbRUHRaNrwVG5rClB6nJCDt7f7fGHJt37OWgQ
WLdQzw1YxvYYLZe2SVX/H70HbkqiZTAteZAlH305DHUjUWg464qplhn6KtPrh3mA
7AdVLWttJepImWVMlAqQAWkpL0DeSaardJBpnpICWS2XClW4l9Feqjrs46L+usKl
oGGz309w+nLozVmdMfvvFXlwxZW2QDuNXZcOidA3GT3+kjuoJrgThVSeXBGhQ1E=
=jCTE
-----END PGP SIGNATURE-----

--7gLe/sNPhR777EPF--
