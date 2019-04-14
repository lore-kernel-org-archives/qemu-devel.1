Received: from eggs.gnu.org ([209.51.188.92]:34775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hFXdR-0002mv-2t
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 01:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hFXbP-00076y-W4
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 01:22:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hFXbP-00075D-JZ
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 01:22:51 -0400
Date: Sun, 14 Apr 2019 08:20:25 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20190414052024.GA2842@lap1>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411110157.14252-4-yuval.shaia@oracle.com>
	<199a70a8-5926-66af-d2d7-b19a0a0f46a2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <199a70a8-5926-66af-d2d7-b19a0a0f46a2@oracle.com>
Subject: Re: [Qemu-devel] [RFC 3/3] RDMA/virtio-rdma: VirtIO rdma driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yanjun Zhu <yanjun.zhu@oracle.com>
Cc: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, mst@redhat.com, cohuck@redhat.com, marcel.apfelbaum@gmail.com, linux-rdma@vger.kernel.org, jgg@mellanox.com

> > +
> > +	wake_up(&dev->acked);
> > +
> > +	printk("%s\n", __func__);
> 
> Cool:-)
> 
> this line should be for debug?

Yes

> 
> Zhu Yanjun
> 
