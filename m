Received: from eggs.gnu.org ([2001:4830:134:3::10]:56976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmZCd-0005Lz-61
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 01:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmZCZ-0001hd-6B
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 01:36:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dmZCZ-0001hH-0N
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 01:36:39 -0400
Date: Tue, 29 Aug 2017 13:36:25 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170829053625.GT14174@pxdev.xzpeter.org>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-5-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170824192730.8440-5-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 04/32] qemu_ram_block_host_offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com, quintela@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

On Thu, Aug 24, 2017 at 08:27:02PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Utility to give the offset of a host pointer within a RAMBlock
> (assuming we already know it's in that RAMBlock)
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
