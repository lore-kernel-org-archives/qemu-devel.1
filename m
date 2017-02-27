Received: from eggs.gnu.org ([2001:4830:134:3::10]:44326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1ciUAE-00063Z-KN
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:53:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1ciUAA-0005z9-Pg
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:53:06 -0500
Received: from mail.kernel.org ([198.145.29.136]:34676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1ciUAA-0005xZ-IN
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:53:02 -0500
Date: Mon, 27 Feb 2017 14:52:57 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <257647af-303a-68b7-8b67-1290c0eee399@redhat.com>
Message-ID: <alpine.DEB.2.10.1702271452390.7315@sstabellini-ThinkPad-X260>
References: <1487990764-27397-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<alpine.DEB.2.10.1702271429350.7315@sstabellini-ThinkPad-X260>
	<257647af-303a-68b7-8b67-1290c0eee399@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
To: Eric Blake <eblake@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>

On Mon, 27 Feb 2017, Eric Blake wrote:
> On 02/27/2017 04:31 PM, Stefano Stabellini wrote:
> > Eric, are you OK with this series going upstream? If so, do you want me
> > to send the pull request for it or are you going to handle it?
> 
> Both patches have my R-b, but MAINTAINERS suggests the pull request
> should go through COLO Framework (zhanghailiang) or maybe Xen (you).

I am fine either way. zhanghailiang? 
