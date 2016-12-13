Received: from eggs.gnu.org ([2001:4830:134:3::10]:37260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <herbert@gondor.apana.org.au>) id 1cGdqe-0005tK-Ll
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 22:33:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <herbert@gondor.apana.org.au>) id 1cGdqb-0004R2-JV
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 22:33:48 -0500
Received: from helcar.hengli.com.au ([209.40.204.226]:36871
	helo=helcar.apana.org.au)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <herbert@gondor.apana.org.au>)
	id 1cGdqb-0004QH-2I
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 22:33:45 -0500
Date: Tue, 13 Dec 2016 11:33:22 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20161213033322.GA5601@gondor.apana.org.au>
References: <1481171829-116496-1-git-send-email-arei.gonglei@huawei.com>
	<1481171829-116496-3-git-send-email-arei.gonglei@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA15A07C@DGGEMA505-MBX.china.huawei.com>
	<20161212105407.GA3033@gondor.apana.org.au>
	<20161212234941-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161212234941-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v6 2/2] crypto: add virtio-crypto driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, Luonengjun <luonengjun@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "Wubin (H)" <wu.wubin@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "davem@davemloft.net" <davem@davemloft.net>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, "Hanweidong (Randy)" <hanweidong@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "Xuquan (Quan Xu)" <xuquan8@huawei.com>, longpeng <longpeng2@huawei.com>, "Wanzongshun (Vincent)" <wanzongshun@huawei.com>

On Tue, Dec 13, 2016 at 12:05:19AM +0200, Michael S. Tsirkin wrote:
>
> > Sorry but it's too late for 4.10.  It needed to have been in my
> > tree before the merge window opened to make it for this cycle.
> 
> Objections to me merging this? I'm preparing my tree right now.

Sure feel free to merge it through your tree.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
