Received: from eggs.gnu.org ([2001:4830:134:3::10]:38935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1fuUit-00073r-GD
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 23:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1fuUip-00057R-VM
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 23:31:19 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:40165 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1fuUip-00056M-KH
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 23:31:15 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Tue, 28 Aug 2018 03:31:02 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DB0B44A6@dggeml511-mbx.china.huawei.com>
References: <1535071416-212072-1-git-send-email-longpeng2@huawei.com>
	<5B7F5688.5080007@huawei.com>
	<20180824142118-mutt-send-email-mst@kernel.org>
	<33183CC9F5247A488A2544077AF19020DB0A1B5B@dggeml531-mbs.china.huawei.com>
	<20180824155408-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180824155408-mutt-send-email-mst@kernel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v25 0/2] virtio-crypto:
 virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: longpeng <longpeng2@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "agraf@suse.de" <agraf@suse.de>, "jasowang@redhat.com" <jasowang@redhat.com>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>


> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Friday, August 24, 2018 8:54 PM
>=20
> On Fri, Aug 24, 2018 at 12:07:44PM +0000, Gonglei (Arei) wrote:
> > Hi Michael,
> >
> > > -----Original Message-----
> > > From: virtio-dev@lists.oasis-open.org
> [mailto:virtio-dev@lists.oasis-open.org]
> > > On Behalf Of Michael S. Tsirkin
> > > Sent: Friday, August 24, 2018 7:23 PM
> > > To: longpeng <longpeng2@huawei.com>
> > > Cc: xin.zeng@intel.com; Gonglei (Arei) <arei.gonglei@huawei.com>;
> > > pasic@linux.vnet.ibm.com; qemu-devel@nongnu.org;
> > > virtio-dev@lists.oasis-open.org; cohuck@redhat.com;
> stefanha@redhat.com;
> > > denglingli@chinamobile.com; Jani Kokkonen
> <Jani.Kokkonen@huawei.com>;
> > > Ola.Liljedahl@arm.com; Varun.Sethi@freescale.com;
> > > brian.a.keating@intel.com; liang.j.ma@intel.com; john.griffin@intel.c=
om;
> > > agraf@suse.de; jasowang@redhat.com; vincent.jardin@6wind.com;
> > > Huangweidong (C) <weidong.huang@huawei.com>; wangxin (U)
> > > <wangxinxin.wang@huawei.com>; Zhoujian (jay)
> <jianjay.zhou@huawei.com>
> > > Subject: [virtio-dev] Re: [PATCH v25 0/2] virtio-crypto: virtio crypt=
o device
> > > specification
> > >
> > > Is there a github issue? If not pls create one.
> > >
> >
> > I just created one issue:
> >
> > https://github.com/oasis-tcs/virtio-spec/issues/19
>=20
> All set to start voting whenever you request it.
>=20

Hi Michael,

Since no comments currently, pls help to start a ballot for virtio crypto s=
pec if you can. :)


Thanks,
-Gonglei
