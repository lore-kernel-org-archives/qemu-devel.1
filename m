Received: from eggs.gnu.org ([2001:4830:134:3::10]:50784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBXxO-0001CU-Nx
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBXxL-0000Br-MK
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:47:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dBXxL-0000BC-GW
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:47:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 748E44E4D6
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 02:47:54 +0000 (UTC)
Date: Fri, 19 May 2017 10:47:49 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170519024749.GD15294@pxdev.xzpeter.org>
References: <20170518161655.30311-1-quintela@redhat.com>
	<20170518161655.30311-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170518161655.30311-4-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/9] migration: Export qemu-file-channel.c
 functions in its own file
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

On Thu, May 18, 2017 at 06:16:49PM +0200, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
