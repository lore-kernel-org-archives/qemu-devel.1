Received: from eggs.gnu.org ([209.51.188.92]:59482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gmgro-0005En-Ch
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:24:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gmgrm-0002kh-H3
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:24:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gmgrm-0002er-9f
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:24:30 -0500
Date: Thu, 24 Jan 2019 10:16:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190124101626-mutt-send-email-mst@kernel.org>
References: <20190103141013.18019-1-quintela@redhat.com>
	<20190103141013.18019-2-quintela@redhat.com>
	<660c6dba-de55-f6b0-7783-a3ba60879ca9@redhat.com>
	<20190124100547-mutt-send-email-mst@kernel.org>
	<c7fa2603-d07a-f7d3-3fa1-91e43d0abfb5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7fa2603-d07a-f7d3-3fa1-91e43d0abfb5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 01/16] virtio: split vhost vsock bits
 from virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Jan 24, 2019 at 04:08:50PM +0100, Thomas Huth wrote:
> On 2019-01-24 16:06, Michael S. Tsirkin wrote:
> > On Thu, Jan 24, 2019 at 04:04:01PM +0100, Thomas Huth wrote:
> >> ..
> >> Reviewed-by: Thomas Huth <thuth@redhat.com>
> > 
> > A bit late for that, I can't apply your tag retroactively, sorry.
> 
> Oops, this has already been merged :-) ... so never mind.
> 
>  Thomas

yea. generally 3 weeks is too long for review.

-- 
MST
