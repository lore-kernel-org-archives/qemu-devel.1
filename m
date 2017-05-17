Received: from eggs.gnu.org ([2001:4830:134:3::10]:51300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAoIl-0007th-Mv
	for qemu-devel@nongnu.org; Tue, 16 May 2017 22:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAoIh-00020c-Nj
	for qemu-devel@nongnu.org; Tue, 16 May 2017 22:02:59 -0400
Received: from [59.151.112.132] (port=57789 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAoIh-0001tJ-BJ
	for qemu-devel@nongnu.org; Tue, 16 May 2017 22:02:55 -0400
References: <1494829102-1812-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<48435f6e-a33e-f245-165e-611db0b9105b@redhat.com>
	<5cf0fe20-11b6-d16b-dc60-98523075960d@cn.fujitsu.com>
	<acb35bdd-a232-cad2-ea00-1b43296a3517@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <d42e5e90-e99a-7a5e-3bae-b7015ddef85a@cn.fujitsu.com>
Date: Wed, 17 May 2017 10:02:59 +0800
MIME-Version: 1.0
In-Reply-To: <acb35bdd-a232-cad2-ea00-1b43296a3517@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RESEND V2 0/3] Optimize filter-mirror and
 filter-rewriter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>



On 05/16/2017 10:42 PM, Eric Blake wrote:
> On 05/16/2017 03:22 AM, Zhang Chen wrote:
>
>>> What's the difference compared with V2? I think I should apply this
>>> series?
>> In V2 I forgot remove "," in patch 3/3, Yes, please apply this series.
> If you changed the patches, even just to add a ',', then it's best to
> post the resend as "v3", not "RESEND V2".  Also, documenting what
> changed between versions, rather than just blindly titling a message
> RESEND (or even explaining WHY you are resending without change, such as
> to correct an incorrect cc to save people the problem of bounce replies
> when replying to the thread), is good netiquette.

OK, I got your point, will send the V3 later.

Thanks
Zhang Chen

>

-- 
Thanks
Zhang Chen
