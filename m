Received: from eggs.gnu.org ([2001:4830:134:3::10]:42041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRUry-0004Ba-1h
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 22:16:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRUrx-0007rm-9I
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 22:16:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eRUrx-0007rK-2h
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 22:16:33 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3AAC76147B
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 03:16:32 +0000 (UTC)
Date: Wed, 20 Dec 2017 11:16:25 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171220031625.GE22308@xz-mi>
References: <20171208042654.10910-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171208042654.10910-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] vtd: tiny fixes for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>

On Fri, Dec 08, 2017 at 12:26:52PM +0800, Peter Xu wrote:
> Please review.  Thanks,

Ping for 2.12.

> 
> Peter Xu (2):
>   intel_iommu: remove X86_IOMMU_PCI_DEVFN_MAX
>   intel_iommu: fix error param in string
> 
>  hw/i386/intel_iommu.c       | 12 ++++++------
>  include/hw/i386/x86-iommu.h |  1 -
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> -- 
> 2.14.3
> 

-- 
Peter Xu
