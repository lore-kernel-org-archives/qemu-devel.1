Received: from eggs.gnu.org ([2001:4830:134:3::10]:37766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cqAE7-0000XT-GV
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cqAE4-0006ZN-Cj
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:12:51 -0400
Received: from [59.151.112.132] (port=50802 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cqAE4-0006Yk-1i
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:12:48 -0400
References: <1490011066479-474158.post@n7.nabble.com>
	<1490055970461-474432.post@n7.nabble.com>
	<7272f3e8-0bf3-8c16-f51a-2ed293bddb50@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <fe0d9f54-f2fe-4a17-5bc7-8c469f978997@cn.fujitsu.com>
Date: Tue, 21 Mar 2017 11:12:01 +0800
MIME-Version: 1.0
In-Reply-To: <7272f3e8-0bf3-8c16-f51a-2ed293bddb50@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4]COLO:Fix Colo doc,
 secondeary should be secondary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, wangguang <wang.guang55@zte.com.cn>, qemu-devel@nongnu.org
Cc: zhangchen.fnst@cn.fujitsu.com



On 03/21/2017 11:05 AM, Eric Blake wrote:
> On 03/20/2017 07:26 PM, wangguang wrote:
>> Subject: [PATCH] Fix Colo doc secondeary should be secondary This is an error
>> in COLO-FT.txt. secondeary-disk0 should be secondary-disk0. Signed-off-by:
>> --
>> View this message in context: http://qemu.11.n7.nabble.com/
> Nabble may be a fine platform for viewing mailing list archives, and
> even for commenting on existing posts without having a subscription, but
> it is absolutely LOUSY at sending patches.  Please don't try to abuse
> nabble for sending patches, but rather figure out how to get 'git
> send-email' working properly.

I agree.

>

-- 
Thanks
Zhang Chen
