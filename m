Received: from eggs.gnu.org ([2001:4830:134:3::10]:52969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEo0y-0000tC-7a
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:00:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEo0x-0003F4-JM
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:00:52 -0500
Received: from [45.249.212.187] (port=2492 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEo0w-0003Bk-SU
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:00:51 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Thu, 8 Dec 2016 02:00:19 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA156A24@DGGEMA505-MBX.china.huawei.com>
References: <1480595945-63656-1-git-send-email-arei.gonglei@huawei.com>
	<1480595945-63656-2-git-send-email-arei.gonglei@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA1546F2@DGGEMA505-MBX.china.huawei.com>
	<20161207094843.GA19970@gondor.apana.org.au>
In-Reply-To: <20161207094843.GA19970@gondor.apana.org.au>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 1/1] crypto: add virtio-crypto driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, Luonengjun <luonengjun@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "Wubin
	(H)" <wu.wubin@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "davem@davemloft.net" <davem@davemloft.net>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, "Hanweidong (Randy)" <hanweidong@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "Xuquan (Quan Xu)" <xuquan8@huawei.com>, longpeng <longpeng2@huawei.com>, "Wanzongshun (Vincent)" <wanzongshun@huawei.com>

>
> Subject: Re: [PATCH v5 1/1] crypto: add virtio-crypto driver
>=20
> On Tue, Dec 06, 2016 at 09:01:49AM +0000, Gonglei (Arei) wrote:
> >
> > Would you please review and/or ack the virtio_crypto_algs.c?
> > It is the realization of specified algs based on Linux Crypto Framework=
.
>=20
> I have no issues with it.  If the virtio folks are happy with
> the interface with the host then I'll take this patch.
>=20
Cool, thanks!

Regards,
-Gonglei
