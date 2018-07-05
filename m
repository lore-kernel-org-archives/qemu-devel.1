Received: from eggs.gnu.org ([2001:4830:134:3::10]:44702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fb0Qf-0008DQ-Mq
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fb0Qc-0003d0-Ip
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:19:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58298 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fb0Qc-0003bY-D5
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:19:54 -0400
Date: Thu, 5 Jul 2018 17:19:48 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180705091948.GD1389@xz-mi>
References: <20180705080017.31123-1-bala24@linux.vnet.ibm.com>
	<20180705080017.31123-2-bala24@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180705080017.31123-2-bala24@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] tests: add precopy multifd migration
 test with unix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Balamuruhan S <bala24@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com

On Thu, Jul 05, 2018 at 01:30:16PM +0530, Balamuruhan S wrote:
> multifd migration feature is in with commit: 35374cbdff, this patch
> adds test for it using unix socket.
> 
> Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
