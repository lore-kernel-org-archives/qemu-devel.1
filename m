Received: from eggs.gnu.org ([2001:4830:134:3::10]:37908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1fir6k-00089R-Qm
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 20:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1fir6h-0006Vc-Oy
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 20:59:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2559 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <longpeng2@huawei.com>)
	id 1fir6h-0006Q4-9o
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 20:59:47 -0400
Message-ID: <5B5A6E73.2050202@huawei.com>
Date: Fri, 27 Jul 2018 08:59:31 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1514626559-162312-1-git-send-email-longpeng2@huawei.com>
	<1514626559-162312-2-git-send-email-longpeng2@huawei.com>
	<fcb63fc3-22eb-7f6c-2014-744ee75784eb@linux.vnet.ibm.com>
	<5B51CF0B.8020706@huawei.com>
	<a332a516-16dc-1e50-3ea6-b68571880cb7@linux.ibm.com>
In-Reply-To: <a332a516-16dc-1e50-3ea6-b68571880cb7@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [v23 1/2] virtio-crypto: Add virtio crypto device
 specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, virtio-dev@lists.oasis-open.org, Ola.Liljedahl@arm.com, brian.a.keating@intel.com, wangxinxin.wang@huawei.com, mst@redhat.com, liang.j.ma@intel.com, jasowang@redhat.com, xin.zeng@intel.com, qemu-devel@nongnu.org, john.griffin@intel.com, agraf@suse.de, arei.gonglei@huawei.com, stefanha@redhat.com, jianjay.zhou@huawei.com, cornelia.huck@de.ibm.com, Varun.Sethi@freescale.com, Jani.Kokkonen@huawei.com, vincent.jardin@6wind.com, denglingli@chinamobile.com, weidong.huang@huawei.com



On 2018/7/27 0:55, Halil Pasic wrote:

> Sorry I did not have any time for this last days. And this
> to make it worse this is a follow up to something that was
> half a year ago. That means I have to re-familiarize myself
> with the topic.
> 
> If I don't get around to answer in couple of weeks, feel
> free to ping me.
> 
> Since from what I've seen most of the questions were of type
> 'Can we do it like this?', maybe sending out a new version
> is the best. So people (like me) can read through the whole
> thing and point out problems if any.
> 

Hi Halil,

I'll send v24, thanks :)

> Regards,
> Halil
> 
> On 07/20/2018 02:01 PM, Longpeng (Mike) wrote:
>>
>>
>> On 2018/1/10 1:05, Halil Pasic wrote:
>>
>>>
>>>
>>> On 12/30/2017 10:35 AM, Longpeng(Mike) wrote:
>>>> From: Gonglei <arei.gonglei@huawei.com>
> 
> 
> .
> 


-- 
Regards,
Longpeng(Mike)
