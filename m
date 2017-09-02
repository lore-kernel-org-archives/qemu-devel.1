Received: from eggs.gnu.org ([2001:4830:134:3::10]:55055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dnxcT-0000B5-4e
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 21:53:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dnxcQ-0003m3-3N
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 21:53:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dnxcP-0003fE-EG
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 21:53:06 -0400
Message-ID: <59AA0ECE.5040408@huawei.com>
Date: Sat, 2 Sep 2017 09:52:14 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1503734014-239116-1-git-send-email-longpeng2@huawei.com>
	<59A8AE20.1080409@huawei.com>
	<7f0b8eb2-9e5c-7507-191d-1aab17c6ff0f@linux.vnet.ibm.com>
In-Reply-To: <7f0b8eb2-9e5c-7507-191d-1aab17c6ff0f@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v19 0/2] virtio-crypto: virtio crypto
 device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, luonengjun@huawei.com, mst@redhat.com, cohuck@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, mike.caraman@nxp.com, agraf@suse.de, jasowang@redhat.com, nmorey@kalray.eu, vincent.jardin@6wind.com, arei.gonglei@hotmail.com, wangxinxin.wang@huawei.com

Hi Halil,

On 2017/9/1 19:45, Halil Pasic wrote:

> 
> 
> On 09/01/2017 02:47 AM, Longpeng (Mike) wrote:
>> Ping...
>>
>> Stefan, Halil, do you have any suggestion ?
>>
> 
> Hi Longpeng,
> 
> I've ran trough your patch, and it reads much better that
> what I recall v18 used to read like. Because it's been a while
> since v18 doing a conscious review on this will take a considerable
> amount of time (my memories of the issues identified back then
> are very sketchy/vague now). It's on my todo list, but it ain't the
> only item there.
> 


That's great, thanks :)

> Btw. I like to have a reference implementation at hand when reviewing
> a spec. What is the status of the (reference) implementation (I mean
> the new stuff like stateless/mux)? I think it would be nice to provide
> this info in the cover letter (e.g. next time, should we need another
> iteration).
> 


OK, I'll send a reference implementation based on the v19 spec next week.

> Regards,
> Halil
> 
> 
> .
> 


-- 
Regards,
Longpeng(Mike)
