Received: from eggs.gnu.org ([209.51.188.92]:56688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@fromorbit.com>) id 1gtK4i-0004B3-Ia
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 17:29:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@fromorbit.com>) id 1gtK4h-0003mA-UA
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 17:29:16 -0500
Received: from ipmail01.adl2.internode.on.net ([150.101.137.133]:54618)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@fromorbit.com>) id 1gtK4h-0003d1-GK
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 17:29:15 -0500
Date: Tue, 12 Feb 2019 09:29:07 +1100
From: Dave Chinner <david@fromorbit.com>
Message-ID: <20190211222907.GR14116@dastard>
References: <20190109144736.17452-1-pagupta@redhat.com>
	<20190204170515-mutt-send-email-mst@kernel.org>
	<888328358.132676.1549870186945.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <888328358.132676.1549870186945.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] security implications of caching with virtio pmem
 (was Re: [PATCH v3 0/5] kvm "virtio pmem" device)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, dchinner@redhat.com, jack@suse.cz, kvm@vger.kernel.org, david@redhat.com, linux-nvdimm@ml01.01.org, jasowang@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org, Andrea Arcangeli <aarcange@redhat.com>, dave jiang <dave.jiang@intel.com>, darrick wong <darrick.wong@oracle.com>, vishal l verma <vishal.l.verma@intel.com>, willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com, stefanha@redhat.com, imammedo@redhat.com, dan j williams <dan.j.williams@intel.com>, lcapitulino@redhat.com, kwolf@redhat.com, linux-ext4@vger.kernel.org, tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, pbonzini@redhat.com

On Mon, Feb 11, 2019 at 02:29:46AM -0500, Pankaj Gupta wrote:
> Hello Dave,
> Are we okay with this?

Sure.

I'm not sure I agree with all the analysis presented, but, well, I
haven't looked any deeper because I'm tired of being shouted at and
being called argumentative for daring to ask hard questions about
this topic....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
