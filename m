Received: from eggs.gnu.org ([2001:4830:134:3::10]:38153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ctTYL-0005VS-Ks
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ctTYI-0006Sl-ET
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:27:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ctTYI-0006SE-9D
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:27:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 515923D962
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 06:27:21 +0000 (UTC)
Date: Thu, 30 Mar 2017 14:27:14 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170330062714.GF20667@pxdev.xzpeter.org>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-28-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170323204544.12015-28-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 27/51] ram: Use the RAMState
 bytes_transferred parameter
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

On Thu, Mar 23, 2017 at 09:45:20PM +0100, Juan Quintela wrote:
> Somewhere it was passed by reference, just use it from RAMState.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>

(Is this a self-review above? :-)

Reviewed-by: Peter Xu <peterx@redhat.com>

-- peterx
