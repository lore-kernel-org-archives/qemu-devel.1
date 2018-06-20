Received: from eggs.gnu.org ([2001:4830:134:3::10]:40652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1fVWQ7-00040t-Tr
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 02:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1fVWQ4-0005YS-PY
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 02:16:43 -0400
Received: from [45.249.212.35] (port=60125 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <longpeng2@huawei.com>)
	id 1fVWQ4-0005VI-Bf
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 02:16:40 -0400
Message-ID: <5B29F103.80603@huawei.com>
Date: Wed, 20 Jun 2018 14:15:31 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1514626559-162312-1-git-send-email-longpeng2@huawei.com>
	<1514626559-162312-2-git-send-email-longpeng2@huawei.com>
	<fcb63fc3-22eb-7f6c-2014-744ee75784eb@linux.vnet.ibm.com>
	<5A55AA45.9090004@huawei.com>
	<20180620063204-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180620063204-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
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
To: "Michael S. Tsirkin" <mst@redhat.com>, arei.gonglei@huawei.com
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, luonengjun@huawei.com, cornelia.huck@de.ibm.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com



On 2018/6/20 11:34, Michael S. Tsirkin wrote:

> On Wed, Jan 10, 2018 at 01:53:09PM +0800, Longpeng (Mike) wrote:
>> Hi Halil,
>>
>> We are fixing the Intel BUG these days, so I will go through your comments after
>> we're done. Thanks.
> 
> All right - are you guys done with meltdown/spectre? I'd like us
> to start finally getting parts of this in the spec.
> This is already used in the field - let's get into spec
> whatever is already out there.
> 

Some unexpected things (not only meltdown/spectre) have happened for these
months, I'm so sorry for the long delay.

We've noticed the recent virtio-crypto patchset in the maillist and we also
discussed the plan with DPDK-crypto guys, so I'll continue this work as soon as
possible.

> Argue about future enhancements later.
> 
> 


-- 
Regards,
Longpeng(Mike)
