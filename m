Received: from eggs.gnu.org ([2001:4830:134:3::10]:33038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cSD0V-0006CM-1F
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 20:19:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cSD0R-00053K-Vt
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 20:19:47 -0500
Received: from [45.249.212.187] (port=2526 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cSD0Q-0004pM-VA
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 20:19:43 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Sat, 14 Jan 2017 01:18:42 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA190403@DGGEMA505-MBX.china.huawei.com>
References: <1484324249-2991-1-git-send-email-mst@redhat.com>
In-Reply-To: <1484324249-2991-1-git-send-email-mst@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] virtio_crypto: header update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Saturday, January 14, 2017 12:18 AM
> To: qemu-devel@nongnu.org
> Cc: Gonglei (Arei)
> Subject: [PATCH] virtio_crypto: header update
>=20
> Update header from latest linux driver.  Session creation structs gain
> padding to make them same size. Formatting cleanups.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/standard-headers/linux/virtio_crypto.h | 481 +++++++++++++------=
------
>  1 file changed, 251 insertions(+), 230 deletions(-)
>=20
Tested-by: Gonglei <arei.gonglei@huawei.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
