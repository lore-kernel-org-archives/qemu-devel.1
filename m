Received: from eggs.gnu.org ([2001:4830:134:3::10]:37399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fgNfZ-0003bJ-Rl
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 01:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fgNfW-0007WB-HL
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 01:09:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60328 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fgNfW-0007W5-DI
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 01:09:30 -0400
Date: Fri, 20 Jul 2018 13:09:23 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180720050923.GO4071@xz-mi>
References: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
	<20180718154200.26777-3-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180718154200.26777-3-dplotnikov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v1 02/17] bitops: add some atomic versions
 of bitmap operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On Wed, Jul 18, 2018 at 06:41:45PM +0300, Denis Plotnikov wrote:
> 1. test bit
> 2. test and set bit
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Regards,

-- 
Peter Xu
