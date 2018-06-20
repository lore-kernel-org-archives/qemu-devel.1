Received: from eggs.gnu.org ([2001:4830:134:3::10]:50079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fVTtE-0007dU-OH
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 23:34:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fVTtB-0006c2-Jz
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 23:34:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39576 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fVTtB-0006br-Et
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 23:34:33 -0400
Date: Wed, 20 Jun 2018 06:34:24 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180620063204-mutt-send-email-mst@kernel.org>
References: <1514626559-162312-1-git-send-email-longpeng2@huawei.com>
	<1514626559-162312-2-git-send-email-longpeng2@huawei.com>
	<fcb63fc3-22eb-7f6c-2014-744ee75784eb@linux.vnet.ibm.com>
	<5A55AA45.9090004@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A55AA45.9090004@huawei.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [v23 1/2] virtio-crypto: Add
 virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng (Mike)" <longpeng2@huawei.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, luonengjun@huawei.com, cornelia.huck@de.ibm.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com

On Wed, Jan 10, 2018 at 01:53:09PM +0800, Longpeng (Mike) wrote:
> Hi Halil,
> 
> We are fixing the Intel BUG these days, so I will go through your comments after
> we're done. Thanks.

All right - are you guys done with meltdown/spectre? I'd like us
to start finally getting parts of this in the spec.
This is already used in the field - let's get into spec
whatever is already out there.

Argue about future enhancements later.


-- 
MST
