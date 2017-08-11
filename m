Received: from eggs.gnu.org ([2001:4830:134:3::10]:54710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dg0xD-0002Hp-0i
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 23:49:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dg0xA-0008LM-HN
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 23:49:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dg0xA-0008L0-BV
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 23:49:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E236C07C586
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 03:49:39 +0000 (UTC)
Date: Fri, 11 Aug 2017 11:49:35 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170811034935.GE26015@pxdev.xzpeter.org>
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170808162629.32493-3-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 02/19] migration: Teach it about
 G_SOURCE_REMOVE
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

On Tue, Aug 08, 2017 at 06:26:12PM +0200, Juan Quintela wrote:
> As this is defined on glib 2.32, add compatibility macros for older glibs.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
