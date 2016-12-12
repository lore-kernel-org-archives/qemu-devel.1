Received: from eggs.gnu.org ([2001:4830:134:3::10]:33869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cGYiv-0000Qb-Mp
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:05:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cGYis-0007nP-Hf
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:05:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cGYis-0007nB-BN
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:05:26 -0500
Date: Tue, 13 Dec 2016 00:05:19 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20161212234941-mutt-send-email-mst@kernel.org>
References: <1481171829-116496-1-git-send-email-arei.gonglei@huawei.com>
	<1481171829-116496-3-git-send-email-arei.gonglei@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA15A07C@DGGEMA505-MBX.china.huawei.com>
	<20161212105407.GA3033@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161212105407.GA3033@gondor.apana.org.au>
Subject: Re: [Qemu-devel] [PATCH v6 2/2] crypto: add virtio-crypto driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, Luonengjun <luonengjun@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "Wubin (H)" <wu.wubin@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "davem@davemloft.net" <davem@davemloft.net>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, "Hanweidong (Randy)" <hanweidong@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "Xuquan (Quan Xu)" <xuquan8@huawei.com>, longpeng <longpeng2@huawei.com>, "Wanzongshun (Vincent)" <wanzongshun@huawei.com>

On Mon, Dec 12, 2016 at 06:54:07PM +0800, Herbert Xu wrote:
> On Mon, Dec 12, 2016 at 06:25:12AM +0000, Gonglei (Arei) wrote:
> > Hi, Michael & Herbert
> > 
> > Because the virtio-crypto device emulation had been in QEMU 2.8,
> > would you please merge the virtio-crypto driver for 4.10 if no other
> > comments? If so, Miachel pls ack and/or review the patch, then
> > Herbert will take it (I asked him last week). Thank you!
> > 
> > Ps: Note on 4.10 merge window timing from Linus
> >  https://lkml.org/lkml/2016/12/7/506
> > 
> > Dec 23rd is the deadline for 4.10 merge window.
> 
> Sorry but it's too late for 4.10.  It needed to have been in my
> tree before the merge window opened to make it for this cycle.
> 
> Cheers,


Objections to me merging this? I'm preparing my tree right now.

> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
