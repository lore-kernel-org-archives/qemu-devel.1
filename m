Received: from eggs.gnu.org ([2001:4830:134:3::10]:37536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ctTX7-0004U9-DP
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ctTX4-0005ed-92
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:26:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ctTX4-0005eI-42
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:26:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 402A864F9
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 06:26:05 +0000 (UTC)
Date: Thu, 30 Mar 2017 14:25:59 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170330062559.GD20667@pxdev.xzpeter.org>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-26-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170323204544.12015-26-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 25/51] ram: Move migration_bitmap_rcu into
 RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

On Thu, Mar 23, 2017 at 09:45:18PM +0100, Juan Quintela wrote:
> Once there, rename the type to be shorter.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- peterx
