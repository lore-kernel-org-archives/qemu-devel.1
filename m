Received: from eggs.gnu.org ([209.51.188.92]:53523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gp8CZ-0006aY-VM
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 04:00:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gp8CO-0004sb-J4
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 03:59:57 -0500
Date: Thu, 31 Jan 2019 09:59:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190131085930.GC3950@localhost.localdomain>
References: <20190130235251.17911-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130235251.17911-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Filter second BLOCK_JOB_ERROR
 from 229
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

Am 31.01.2019 um 00:52 hat Max Reitz geschrieben:
> Without this filter, this test sometimes fails.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Thanks, applied to the block branch.

Kevin
