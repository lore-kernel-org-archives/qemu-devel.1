Received: from eggs.gnu.org ([2001:4830:134:3::10]:46402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBKGj-0003LK-GX
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:11:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBKGg-0004aS-CN
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:11:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dBKGg-0004aD-62
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:10:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2507F20B18
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 12:10:57 +0000 (UTC)
Date: Thu, 18 May 2017 20:10:52 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170518121052.GB15294@pxdev.xzpeter.org>
References: <20170517154756.22079-1-quintela@redhat.com>
	<20170517154756.22079-10-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170517154756.22079-10-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 9/9] migration: migration.h was not needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Wed, May 17, 2017 at 05:47:56PM +0200, Juan Quintela wrote:
> This files don't use any function from migration.h, so drop it.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
