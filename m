Received: from eggs.gnu.org ([2001:4830:134:3::10]:54838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7hmR-0004a4-LS
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7hmM-00034m-1s
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:01:03 -0400
Date: Thu, 26 Oct 2017 15:00:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171026130039.GA9435@localhost.localdomain>
References: <20171026075947.9597-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171026075947.9597-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img.1: Image invalidation on qemu-img
 commit
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

Am 26.10.2017 um 09:59 hat Max Reitz geschrieben:
> qemu-img commit invalidates all images between base and top.  This
> should be mentioned in the man page.
> 
> Suggested-by: Ping Li <pingl@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Thanks, applied to the block branch.

Kevin
