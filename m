Received: from eggs.gnu.org ([2001:4830:134:3::10]:44284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cxmoe-0003RJ-Uu
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 23:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cxmob-0005cm-T9
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 23:50:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cxmob-0005c9-NC
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 23:50:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83911C0624A1
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 03:50:00 +0000 (UTC)
Date: Tue, 11 Apr 2017 11:49:53 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170411034953.GC2313@pxdev.xzpeter.org>
References: <20170406130913.2232-1-quintela@redhat.com>
	<20170406130913.2232-10-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170406130913.2232-10-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/54] ram: Change byte_xfer_now type to
 uint64_t
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

On Thu, Apr 06, 2017 at 03:08:28PM +0200, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- peterx
