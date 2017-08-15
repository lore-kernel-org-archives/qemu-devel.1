Received: from eggs.gnu.org ([2001:4830:134:3::10]:53661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dhVa1-0000Wc-TG
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dhVZy-0006Cq-0V
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:43:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dhVZx-0006Ch-Pu
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:43:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA2342C9748
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 06:43:52 +0000 (UTC)
Date: Tue, 15 Aug 2017 14:43:48 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170815064348.GU26015@pxdev.xzpeter.org>
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-11-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170808162629.32493-11-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 10/19] migration: Split
 migration_fd_process_incoming
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

On Tue, Aug 08, 2017 at 06:26:20PM +0200, Juan Quintela wrote:
> We need that on later patches.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
