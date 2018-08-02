Received: from eggs.gnu.org ([2001:4830:134:3::10]:48448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1fl2rY-0000hF-Q4
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 21:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1fl2rV-00052h-PN
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 21:57:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2639 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <longpeng2@huawei.com>)
	id 1fl2rV-0004x0-Am
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 21:57:09 -0400
Message-ID: <5B6264E2.2060407@huawei.com>
Date: Thu, 2 Aug 2018 09:56:50 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1514626559-162312-1-git-send-email-longpeng2@huawei.com>
	<1514626559-162312-2-git-send-email-longpeng2@huawei.com>
	<fcb63fc3-22eb-7f6c-2014-744ee75784eb@linux.vnet.ibm.com>
	<5B51CF0B.8020706@huawei.com>
	<a332a516-16dc-1e50-3ea6-b68571880cb7@linux.ibm.com>
	<20180727144726-mutt-send-email-mst@kernel.org>
	<47e5bc06-6b4d-aab6-db77-c91313d36d87@linux.ibm.com>
In-Reply-To: <47e5bc06-6b4d-aab6-db77-c91313d36d87@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Halil Pasic <pasic@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, arei.gonglei@huawei.com, stefanha@redhat.com
Cc: denglingli@chinamobile.com, virtio-dev@lists.oasis-open.org, Halil
	Pasic <pasic@linux.vnet.ibm.com>, Ola.Liljedahl@arm.com, brian.a.keating@intel.com, Jani.Kokkonen@huawei.com, xin.zeng@intel.com, wangxinxin.wang@huawei.com, liang.j.ma@intel.com, qemu-devel@nongnu.org, john.griffin@intel.com, agraf@suse.de, jianjay.zhou@huawei.com, cornelia.huck@de.ibm.com, Varun.Sethi@freescale.com, vincent.jardin@6wind.com, jasowang@redhat.com, weidong.huang@huawei.com

Hi Halil,

On 2018/8/2 4:21, Halil Pasic wrote:

> 
> 
> On 07/27/2018 01:51 PM, Michael S. Tsirkin wrote:
>> On Thu, Jul 26, 2018 at 06:55:44PM +0200, Halil Pasic wrote:
>>> Sorry I did not have any time for this last days. And this
>>> to make it worse this is a follow up to something that was
>>> half a year ago. That means I have to re-familiarize myself
>>> with the topic.
>>>
>>> If I don't get around to answer in couple of weeks, feel
>>> free to ping me.
>>>
>>> Since from what I've seen most of the questions were of type
>>> 'Can we do it like this?', maybe sending out a new version
>>> is the best. So people (like me) can read through the whole
>>> thing and point out problems if any.
>>>
>>> Regards,
>>> Halil
>>
>>
>> While two weeks for review is borderline reasonable as an exception, it
>> does trouble me that  we are at v23, for something that is used
>> in the field so it's not like we can just change things at will.
>> So I hope everyone concerned makes an effort to try to converge on a spec
>> ASAP.
>>
> 
> What I tried to say: I'm busy with other stuff, and I'm not too
> happy to resume a complex topic after 6 months hiatus.
> 
> The series is now at v24 and has apparently no acks or r-bs. I don't think
> I'm the only one to blame for that.
> 

> It seems, I won't have the time to do a conscientious review in a
> timely fashion. If the rest of the bunch thinks what we have is good
> enough, I am happy to abstain when voting on this -- and avoiding
> holding it up any further.
> 

Thanks for your conscientious reviews on previous versions and your suggestions
are really useful to make the spec better. I'm sorry that I should be to blame
for the half a year hiatus, not you.

I've do some offline discussions with Gonglei and Intel guys, it seems that
there is no big arguments on v23 and the following small problems can be fixed
by follow-up patches.

I hope guys who care about this spec could post your opinion, I'll suggest
Gonglei to start a vote for the spec if no.

> Regards,
> Halil
> 
> 
> .
> 


-- 
Regards,
Longpeng(Mike)
