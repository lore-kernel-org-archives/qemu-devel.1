Received: from eggs.gnu.org ([2001:4830:134:3::10]:44382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cGbfO-00080a-AJ
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 20:14:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cGbfM-0007YG-F4
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 20:14:02 -0500
Received: from [45.249.212.189] (port=2373 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cGbfL-0007XF-LC
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 20:14:00 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Tue, 13 Dec 2016 01:13:25 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA15BDD8@DGGEMA505-MBX.china.huawei.com>
References: <1481171829-116496-1-git-send-email-arei.gonglei@huawei.com>
	<1481171829-116496-3-git-send-email-arei.gonglei@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA15A07C@DGGEMA505-MBX.china.huawei.com>
	<20161212105407.GA3033@gondor.apana.org.au>
	<20161212234941-mutt-send-email-mst@kernel.org>
In-Reply-To: <20161212234941-mutt-send-email-mst@kernel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 2/2] crypto: add virtio-crypto driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, Luonengjun <luonengjun@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "Wubin (H)" <wu.wubin@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "davem@davemloft.net" <davem@davemloft.net>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, "Hanweidong (Randy)" <hanweidong@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "Xuquan (Quan Xu)" <xuquan8@huawei.com>, longpeng <longpeng2@huawei.com>, "Wanzongshun (Vincent)" <wanzongshun@huawei.com>

>
> Subject: Re: [PATCH v6 2/2] crypto: add virtio-crypto driver
>=20
> On Mon, Dec 12, 2016 at 06:54:07PM +0800, Herbert Xu wrote:
> > On Mon, Dec 12, 2016 at 06:25:12AM +0000, Gonglei (Arei) wrote:
> > > Hi, Michael & Herbert
> > >
> > > Because the virtio-crypto device emulation had been in QEMU 2.8,
> > > would you please merge the virtio-crypto driver for 4.10 if no other
> > > comments? If so, Miachel pls ack and/or review the patch, then
> > > Herbert will take it (I asked him last week). Thank you!
> > >
> > > Ps: Note on 4.10 merge window timing from Linus
> > >  https://lkml.org/lkml/2016/12/7/506
> > >
> > > Dec 23rd is the deadline for 4.10 merge window.
> >
> > Sorry but it's too late for 4.10.  It needed to have been in my
> > tree before the merge window opened to make it for this cycle.
> >
> > Cheers,
>=20
>=20
> Objections to me merging this? I'm preparing my tree right now.
>=20
That's great if so since 4.11 merge window opens=20
at least three months later.

Do you agree with it Herbert? Thanks.

Regards,
-Gonglei
