Received: from eggs.gnu.org ([2001:4830:134:3::10]:54931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dAD6X-0001wH-KL
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dAD6W-0006sE-RD
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:19:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dAD6W-0006rx-LO
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:19:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4992BDD0
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 10:19:51 +0000 (UTC)
Date: Mon, 15 May 2017 18:19:47 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170515101947.GC31572@pxdev.xzpeter.org>
References: <20170512155449.9003-1-quintela@redhat.com>
	<20170512155449.9003-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170512155449.9003-3-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] migration: Remove old MigrationParams
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

On Fri, May 12, 2017 at 05:54:49PM +0200, Juan Quintela wrote:
> Not used anymore after moving block migration to use capabilities.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>

Reviewed-by: Peter Xu <peterx@redhat.com>
