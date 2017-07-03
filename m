Received: from eggs.gnu.org ([2001:4830:134:3::10]:40880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dRxBf-00010k-Bx
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 04:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dRxBb-0002PL-K8
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 04:58:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dRxBb-0002NW-EN
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 04:58:27 -0400
Date: Mon, 3 Jul 2017 16:58:21 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170703085821.GA32003@pxdev.xzpeter.org>
References: <1499049848-18012-1-git-send-email-peterx@redhat.com>
	<7d11960f-168b-dce1-aa29-34cee7e7b043@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d11960f-168b-dce1-aa29-34cee7e7b043@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] migration: fix iotest 055,
 only-migratable break
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On Mon, Jul 03, 2017 at 03:54:38PM +0800, QingFeng Hao wrote:
> I tested the 2 patches and they can make iotest 055 passed on both x86 and
> s390x.

Thanks for testing!

-- 
Peter Xu
