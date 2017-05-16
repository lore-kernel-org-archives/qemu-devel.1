Received: from eggs.gnu.org ([2001:4830:134:3::10]:57549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAXl1-0007fl-ND
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAXkw-0000LL-Ow
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:23:03 -0400
Received: from [59.151.112.132] (port=13954 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAXkw-0000Fa-CP
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:22:58 -0400
References: <1494829102-1812-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<48435f6e-a33e-f245-165e-611db0b9105b@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <5cf0fe20-11b6-d16b-dc60-98523075960d@cn.fujitsu.com>
Date: Tue, 16 May 2017 16:22:58 +0800
MIME-Version: 1.0
In-Reply-To: <48435f6e-a33e-f245-165e-611db0b9105b@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
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
To: Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>



On 05/16/2017 02:48 PM, Jason Wang wrote:
>
>
> On 2017年05月15日 14:18, Zhang Chen wrote:
>> Fix some duplicate codes and remove unused codes.
>>
>> v2: Address Eric's comment on patch 3.
>>
>> Zhang Chen (3):
>>    net/filter-mirror.c: Remove duplicate check code.
>>    net/filter-mirror.c: Rename filter_mirror_send() and fix codestyle
>>    net/filter-rewriter: Remove unused option in filter-rewriter
>>
>>   net/filter-mirror.c | 35 ++++++++++++++++-------------------
>>   qemu-options.hx     |  2 +-
>>   2 files changed, 17 insertions(+), 20 deletions(-)
>>
>
> Hi:
>
> What's the difference compared with V2? I think I should apply this 
> series?

In V2 I forgot remove "," in patch 3/3, Yes, please apply this series.

>
> Thanks
>
>
>

-- 
Thanks
Zhang Chen
