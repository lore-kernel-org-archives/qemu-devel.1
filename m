Received: from eggs.gnu.org ([2001:4830:134:3::10]:39772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fuH6V-0003EV-D9
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 08:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fuGva-00012r-F8
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 08:47:36 -0400
References: <20180824133757.1cbdba75.cohuck@redhat.com>
	<de80a3a0-7fd7-783c-3d3b-b8c4a481a893@de.ibm.com>
	<20180827143731.26a5c0f6.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <212cc356-d1ce-3576-4616-01ec1eec1da2@redhat.com>
Date: Mon, 27 Aug 2018 14:47:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180827143731.26a5c0f6.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFD] [s390x] Tweaking the s390x maintainership
 setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

>>
>>> * More trees to pull from. Of course, not every area needs a dedicated
>>>   tree (that would become silly pretty quickly), but for example a tcg
>>>   tree would be nice. I can still pick individual patches if a pull
>>>   request would be overkill.
>>> * I'd also like to have a designated backup for the overall
>>>   maintainership, especially for when I'm on vacation (like the first
>>>   two weeks of September, just to let you know :) or otherwise
>>>   unavailable, but also for sanity. Likely needs to be a non-IBMer due
>>>   to the tcg problem.  
>>
>> Is the current setup with Richard (TCG) and myself (KVM) not good enough?
> 
> It's mostly "I'm uncomfortable that it's only me". Having the tcg
> maintainers resp. you handle things is absolutely fine for the usual
> run of things. The only time where there might be problems is if e.g.
> tcg and kvm changes interact in a non-trivial way, but I expect these
> to be very rare.

I wonder what kind of persons do things like that ;)

But yes, it should be rare and usually can wait in case you are on vacation.

-- 

Thanks,

David / dhildenb
