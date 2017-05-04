Received: from eggs.gnu.org ([2001:4830:134:3::10]:55925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d6Ib8-0001Jz-7J
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d6Ib7-0007jS-Fd
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:23:18 -0400
Date: Thu, 4 May 2017 17:23:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170504152309.GD5238@noname.redhat.com>
References: <20170503231120.23507-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170503231120.23507-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] qcow2: Some fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Am 04.05.2017 um 01:11 hat Max Reitz geschrieben:
> This series contains some fixes for issues reported by Eric.

Thanks, applied to the block branch (though I think it's a new feature
rather than a fix for the most part).

Kevin
