Received: from eggs.gnu.org ([2001:4830:134:3::10]:51158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1csP1C-00086J-SI
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 03:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1csP19-0003dV-Qz
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 03:24:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1csP19-0003dB-LL
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 03:24:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 99753635D9
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 07:24:42 +0000 (UTC)
Date: Mon, 27 Mar 2017 15:24:36 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170327072436.GA11497@pxdev.xzpeter.org>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-5-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170323204544.12015-5-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/51] ram: Add dirty_rate_high_cnt to
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

On Thu, Mar 23, 2017 at 09:44:57PM +0100, Juan Quintela wrote:
> We need to add a parameter to several functions to make this work.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- peterx
