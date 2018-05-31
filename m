Received: from eggs.gnu.org ([2001:4830:134:3::10]:42680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fOLEr-00056n-04
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fOLEm-0002EN-66
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:55:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57594 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fOLEm-0002Dg-1e
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:55:20 -0400
Date: Thu, 31 May 2018 11:55:17 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180531105517.GD27838@stefanha-x1.localdomain>
References: <20180530184156.15634-1-crosa@redhat.com>
	<20180530184156.15634-2-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x4pBfXISqBoDm8sr"
Content-Disposition: inline
In-Reply-To: <20180530184156.15634-2-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/5] Add functional/acceptance tests
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>


--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 30, 2018 at 02:41:52PM -0400, Cleber Rosa wrote:
> + * Donwload (and cache) remote data files, such as firmware and kernel

s/Donwload/Download/

Aside from that:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--x4pBfXISqBoDm8sr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbD9SVAAoJEJykq7OBq3PIhi4H+gMx5qmY0klniRfD8LUUFwse
27caO6iDaknI87Z/x4hXhU/d5ZuHuo7kcRcWhMj/6Jh6OUBk8MSx0McueHEZ4BJ0
NJzdKuTFF1XA1qTUzGQC+YPmmhdbSi8FJ6bTx0MEQF0i4GlSvBlYO4BrtD/WyEsQ
fHoyi4Y8ohNBD1fHOuLXcAVDuacSq0JEi2jXzSN4Kk4Y2f46dQRUJ7i2TFv5Ayv6
AuKILiGTrB98kJXVytc4BdSE1Zu67u4eDwDGa1GaHnpGaMrgk1xQFNI47uSx6vgU
ZWYTAMyct250s2arHHgubKszTe9/LZKOOakhW5rYF2C2IGQjJeYcF2uh8+/Xols=
=xGMC
-----END PGP SIGNATURE-----

--x4pBfXISqBoDm8sr--
