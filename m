Received: from eggs.gnu.org ([2001:4830:134:3::10]:47620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e2WMU-0007dt-7n
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 01:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e2WMR-0005v1-6a
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 01:48:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e2WMQ-0005uR-Vt
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 01:48:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1B637F3F8
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 05:48:45 +0000 (UTC)
Date: Thu, 12 Oct 2017 13:48:42 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171012054842.GD30901@pxdev.xzpeter.org>
References: <20171010181542.24168-1-quintela@redhat.com>
	<20171010181542.24168-5-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171010181542.24168-5-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/10] migration: Move xbzrle cache resize
 error handling to xbzrle_cache_resize
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

On Tue, Oct 10, 2017 at 08:15:36PM +0200, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
