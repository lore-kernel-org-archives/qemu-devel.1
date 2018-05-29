Received: from eggs.gnu.org ([2001:4830:134:3::10]:35634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNkN8-0007Lz-2s
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNkN4-0004fD-62
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:33:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42306 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fNkN4-0004ey-1K
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:33:26 -0400
References: <D9DE8DBB19F2A24080482022C1DE758302C89900@dggemm509-mbx.china.huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e4a72796-562e-adf8-21ba-7bed953126e8@redhat.com>
Date: Tue, 29 May 2018 14:33:22 -0500
MIME-Version: 1.0
In-Reply-To: <D9DE8DBB19F2A24080482022C1DE758302C89900@dggemm509-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] socket: dont't free msgfds if error equals
 EAGAIN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "peterx@redhat.com" <peterx@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>

On 05/29/2018 04:33 AM, linzhecheng wrote:
> I think this patch doesn't fix my issue. For more details, please see Gonglei's reply.
> https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg06296.html

Your mailer is not honoring threading (it failed to include 
'In-Reply-To:' and 'References:' headers that refer to the message you 
are replying to), and you are top-posting, both of which make it 
difficult to follow your comments on a technical list.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
