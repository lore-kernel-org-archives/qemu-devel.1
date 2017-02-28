Received: from eggs.gnu.org ([2001:4830:134:3::10]:47315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ciWPM-0006qj-Dr
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 20:16:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ciWPJ-0002wg-6p
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 20:16:52 -0500
Received: from [45.249.212.188] (port=2942 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ciWPI-0002wD-Jr
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 20:16:49 -0500
References: <1487990764-27397-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<alpine.DEB.2.10.1702271429350.7315@sstabellini-ThinkPad-X260>
	<257647af-303a-68b7-8b67-1290c0eee399@redhat.com>
	<alpine.DEB.2.10.1702271452390.7315@sstabellini-ThinkPad-X260>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58B4CFB5.2020609@huawei.com>
Date: Tue, 28 Feb 2017 09:17:41 +0800
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1702271452390.7315@sstabellini-ThinkPad-X260>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V10 0/2] Add new qmp commands to suppurt
 Xen COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>, Eric Blake <eblake@redhat.com>
Cc: xuquan8@huawei.com, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu
	devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>

On 2017/2/28 6:52, Stefano Stabellini wrote:
> On Mon, 27 Feb 2017, Eric Blake wrote:
>> On 02/27/2017 04:31 PM, Stefano Stabellini wrote:
>>> Eric, are you OK with this series going upstream? If so, do you want me
>>> to send the pull request for it or are you going to handle it?
>>
>> Both patches have my R-b, but MAINTAINERS suggests the pull request
>> should go through COLO Framework (zhanghailiang) or maybe Xen (you).
>
> I am fine either way. zhanghailiang?
>

Yes, I'm fine if you could give a pull request for this series.

Thanks.

> .
>
