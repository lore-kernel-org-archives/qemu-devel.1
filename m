Received: from eggs.gnu.org ([2001:4830:134:3::10]:36880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1djf47-0005GH-DP
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 01:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1djf44-00061S-7F
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 01:15:55 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:40641
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1djf43-0005qI-S4
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 01:15:52 -0400
References: <1500449399-19107-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<e41d36bc-ed32-8d0d-7fff-bf68fb78707c@cn.fujitsu.com>
	<f00fdc9a-6f9a-bae2-78a0-9d1124ca9640@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <b6b722c0-76c8-f79b-694d-4f1370ef475f@cn.fujitsu.com>
Date: Mon, 21 Aug 2017 13:17:39 +0800
MIME-Version: 1.0
In-Reply-To: <f00fdc9a-6f9a-bae2-78a0-9d1124ca9640@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH V3 0/4] Optimize COLO-compare performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>



On 08/21/2017 11:55 AM, Jason Wang wrote:
>
>
> On 2017年08月21日 09:45, Zhang Chen wrote:
>> Hi~~ All~
>>
>> No one review this series for a long time.
>>
>> Ping...
>>
>>
>
> Looks ok to me. But I don't like patch 1 since it adds more TODO 
> especially for a non-exist function colo_notify_checkpoint().
>
> I tend to have it after colo_notify_checkpoint() is implemented or 
> merged.
>

I got your point, I will send the V4 without patch1.

Thanks
Zhang Chen

> Thanks
>
>
>
>

-- 
Thanks
Zhang Chen
