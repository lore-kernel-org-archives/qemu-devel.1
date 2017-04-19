Received: from eggs.gnu.org ([2001:4830:134:3::10]:37762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d0rwI-00080Q-F0
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 11:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d0rwH-0006Z6-Ms
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 11:54:42 -0400
Date: Wed, 19 Apr 2017 17:54:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170419155434.GG5826@noname.redhat.com>
References: <20170413160625.27719-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170413160625.27719-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/2] block: An empty filename
 counts as no filename
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

Am 13.04.2017 um 18:06 hat Max Reitz geschrieben:
> See patch 1 for what is happening when you try "qemu-img info ''" and
> for the fix.
> 
> (Patch 2 just adds a simple test.)

Thanks, applied to my block-next branch.

Kevin
