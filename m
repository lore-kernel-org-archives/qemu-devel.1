Received: from eggs.gnu.org ([2001:4830:134:3::10]:56688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dg4Bh-0007w5-8i
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dg4Be-0003SL-45
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:16:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dg4Bd-0003Rh-Ur
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:16:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F24167E454
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 07:16:48 +0000 (UTC)
Date: Fri, 11 Aug 2017 15:16:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170811071644.GL26015@pxdev.xzpeter.org>
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-9-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170808162629.32493-9-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 08/19] migration: Create x-multifd-group
 parameter
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

On Tue, Aug 08, 2017 at 06:26:18PM +0200, Juan Quintela wrote:
> Indicates how many pages we are going to send in each batch to a multifd
> thread.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
