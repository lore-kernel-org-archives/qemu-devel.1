Received: from eggs.gnu.org ([2001:4830:134:3::10]:45092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBKDV-0000nb-Rv
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBKDS-0003Qg-MR
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:07:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dBKDS-0003QZ-G2
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:07:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A93E80C30
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 12:07:37 +0000 (UTC)
Date: Thu, 18 May 2017 20:07:32 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170518120732.GF24085@pxdev.xzpeter.org>
References: <20170517154756.22079-1-quintela@redhat.com>
	<20170517154756.22079-5-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170517154756.22079-5-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/9] migration: Remove migration.h from
 colo.h
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

On Wed, May 17, 2017 at 05:47:51PM +0200, Juan Quintela wrote:
> migration.h is not included in any includes now.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
