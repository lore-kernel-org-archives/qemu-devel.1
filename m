Received: from eggs.gnu.org ([2001:4830:134:3::10]:55509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ctU4U-0000sG-Md
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 03:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ctU4P-0001LT-Bd
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 03:00:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ctU4P-0001Kn-5s
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 03:00:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C259E7E9DE
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 07:00:31 +0000 (UTC)
Date: Thu, 30 Mar 2017 15:00:25 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170330070024.GI20667@pxdev.xzpeter.org>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-33-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170323204544.12015-33-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 32/51] ram: Remove dirty_bytes_rate
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

On Thu, Mar 23, 2017 at 09:45:25PM +0100, Juan Quintela wrote:
> It can be recalculated from dirty_pages_rate.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>

Another self-review? :)

Reviewed-by: Peter Xu <peterx@redhat.com>

-- peterx
