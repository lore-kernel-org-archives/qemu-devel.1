Received: from eggs.gnu.org ([2001:4830:134:3::10]:57876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <herbert@gondor.apana.org.au>) id 1cEYrv-0002yk-Nw
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:50:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <herbert@gondor.apana.org.au>) id 1cEYrq-0006i7-R0
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:50:31 -0500
Received: from helcar.hengli.com.au ([209.40.204.226]:56331
	helo=helcar.apana.org.au)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <herbert@gondor.apana.org.au>)
	id 1cEYrp-0006fj-Qp
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:50:26 -0500
Date: Wed, 7 Dec 2016 17:48:43 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20161207094843.GA19970@gondor.apana.org.au>
References: <1480595945-63656-1-git-send-email-arei.gonglei@huawei.com>
	<1480595945-63656-2-git-send-email-arei.gonglei@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA1546F2@DGGEMA505-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA1546F2@DGGEMA505-MBX.china.huawei.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/1] crypto: add virtio-crypto driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, Luonengjun <luonengjun@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "Wubin (H)" <wu.wubin@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "davem@davemloft.net" <davem@davemloft.net>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, "Hanweidong (Randy)" <hanweidong@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "Xuquan (Quan Xu)" <xuquan8@huawei.com>, longpeng <longpeng2@huawei.com>, "Wanzongshun (Vincent)" <wanzongshun@huawei.com>

On Tue, Dec 06, 2016 at 09:01:49AM +0000, Gonglei (Arei) wrote:
> 
> Would you please review and/or ack the virtio_crypto_algs.c?
> It is the realization of specified algs based on Linux Crypto Framework.

I have no issues with it.  If the virtio folks are happy with
the interface with the host then I'll take this patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
