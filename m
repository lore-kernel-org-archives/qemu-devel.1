Received: from eggs.gnu.org ([2001:4830:134:3::10]:54289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cwUa1-0006q2-9h
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cwUZy-000282-1X
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:09:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cwUZx-00027h-RO
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:09:33 -0400
Date: Fri, 7 Apr 2017 17:09:22 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170407170841-mutt-send-email-mst@kernel.org>
References: <1491548305-75464-1-git-send-email-weiqi4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491548305-75464-1-git-send-email-weiqi4@huawei.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] some simple cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: weiqi <weiqi4@huawei.com>
Cc: pbonzini@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org, arei.gonglei@huawei.com

On Fri, Apr 07, 2017 at 02:58:25PM +0800, weiqi wrote:
> From: Wei Qi <weiqi4@huawei.com>
> 
> This patchset cleanups some unused/unnecessary variables assignment.


Pls remember to repost after 2.9 is out.

> Wei Qi (3):
>   vhost: simple clean up
>   vnc: simple clean up
>   esp-pci: simple clean up
> 
>  hw/scsi/esp-pci.c | 1 -
>  hw/virtio/vhost.c | 1 -
>  ui/vnc-enc-zrle.c | 1 -
>  3 files changed, 3 deletions(-)
> 
> -- 
> 1.8.3.1
> 
