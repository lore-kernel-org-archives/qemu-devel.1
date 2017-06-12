Received: from eggs.gnu.org ([2001:4830:134:3::10]:46088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dKM0O-00021U-RW
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dKM0K-0000pz-Vm
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:51:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dKM0K-0000pq-PU
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:51:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 765DAC04B923
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 09:51:23 +0000 (UTC)
Date: Mon, 12 Jun 2017 17:51:18 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170612095118.GI12928@pxdev.xzpeter.org>
References: <20170601212921.30241-1-quintela@redhat.com>
	<20170601212921.30241-10-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170601212921.30241-10-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/11] migration: Move remaining exported
 functions to migration/misc.h
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

On Thu, Jun 01, 2017 at 11:29:19PM +0200, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
