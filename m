Received: from eggs.gnu.org ([2001:4830:134:3::10]:52752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ceChb-0002s7-7c
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 22:25:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ceChY-0002nu-4d
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 22:25:51 -0500
Received: from [59.151.112.132] (port=48564 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ceChX-0002nM-OG
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 22:25:48 -0500
References: <1486531462-13882-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1486531462-13882-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<9358a09d-d65f-2b44-9bce-7027b133f1f8@redhat.com>
	<alpine.DEB.2.10.1702131228110.6418@sstabellini-ThinkPad-X260>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <b1cc9438-3f49-dbf9-8334-1dbdb4aa9704@cn.fujitsu.com>
Date: Thu, 16 Feb 2017 11:25:49 +0800
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1702131228110.6418@sstabellini-ThinkPad-X260>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V7 2/2] Add a new qmp command to do
 checkpoint, query xen replication status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu devel <qemu-devel@nongnu.org>, Wen Congyang <wencongyang@gmail.com>, Jason Wang <jasowang@redhat.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

Ping...

No new for a long time.

Who can pick up this patch?


Thanks

Zhang Chen


On 02/14/2017 04:28 AM, Stefano Stabellini wrote:
> On Wed, 8 Feb 2017, Eric Blake wrote:
>> On 02/07/2017 11:24 PM, Zhang Chen wrote:
>>> We can call this qmp command to do checkpoint outside of qemu.
>>> Xen colo will need this function.
>>>
>>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>>> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
>>> ---
>>>   migration/colo.c | 17 ++++++++++++++++
>>>   qapi-schema.json | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 77 insertions(+)
>>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
> Given that the series is all acked, are you going to take care of the
> pull request?
>
>
> .
>

-- 
Thanks
Zhang Chen
