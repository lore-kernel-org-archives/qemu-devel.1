Received: from eggs.gnu.org ([2001:4830:134:3::10]:48992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1csSP3-0006Am-JN
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1csSOz-00041n-9F
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:01:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46095)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1csSOz-00041O-4n
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:01:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 23BAF4E048
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 11:01:32 +0000 (UTC)
Date: Mon, 27 Mar 2017 19:01:27 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170327110127.GC18129@pxdev.xzpeter.org>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-21-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170323204544.12015-21-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 20/51] ram: Move xbzrle_cache_miss_rate
 into RAMState
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

On Thu, Mar 23, 2017 at 09:45:13PM +0100, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- peterx
