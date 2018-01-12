Received: from eggs.gnu.org ([2001:4830:134:3::10]:60763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZzGf-00068c-Ea
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:21:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZzGd-00044j-GE
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:21:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eZzGd-00043h-9e
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:21:07 -0500
Date: Fri, 12 Jan 2018 14:21:05 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180112132105.t3xidtqry34gymf2@sirius.home.kraxel.org>
References: <20171225023730.5512-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171225023730.5512-1-linzhecheng@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] input: fix memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com

On Mon, Dec 25, 2017 at 10:37:30AM +0800, linzhecheng wrote:
> If kbd_queue is not empty and queue_count >= queue_limit,
> we should free evt.
> 
> Change-Id: Ieeacf90d5e7e370a40452ec79031912d8b864d83
> Signed-off-by: linzhecheng <linzhecheng@huawei.com>

Patch added to queue.

thanks,
  Gerd
