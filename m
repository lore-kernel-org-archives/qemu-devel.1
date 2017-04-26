Received: from eggs.gnu.org ([2001:4830:134:3::10]:35011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3J48-0006YJ-VX
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:16:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3J45-0006bU-PU
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:16:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d3J45-0006aY-IX
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:16:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA80280049
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 09:16:47 +0000 (UTC)
Date: Wed, 26 Apr 2017 17:16:41 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170426091641.GA16228@pxdev.xzpeter.org>
References: <20170426073247.7441-1-quintela@redhat.com>
	<20170426073247.7441-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170426073247.7441-2-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ram: Split dirty bitmap by RAMBlock
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

On Wed, Apr 26, 2017 at 09:32:47AM +0200, Juan Quintela wrote:
> Both the ram bitmap and the unsent bitmap are split by RAMBlock.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
