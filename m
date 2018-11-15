Received: from eggs.gnu.org ([2001:4830:134:3::10]:46153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gN8jy-00089E-7x
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 22:54:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gN8jv-00037G-KG
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 22:54:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gN8jv-00036q-FB
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 22:54:47 -0500
Date: Thu, 15 Nov 2018 11:54:41 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181115035441.GC27915@xz-x1>
References: <20181114190912.7242-1-chen.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114190912.7242-1-chen.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH] migration/migration.c: Add COLO dependency
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <chen.zhang@intel.com>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-dev <qemu-devel@nongnu.org>

On Thu, Nov 15, 2018 at 03:09:12AM +0800, Zhang Chen wrote:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> Current COLO mode(independent disk mode) need replication module work
> together. Suggested by Dr. David Alan Gilbert <dgilbert@redhat.com>.
> 
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Regards,

-- 
Peter Xu
