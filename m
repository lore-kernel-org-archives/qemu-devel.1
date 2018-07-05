Received: from eggs.gnu.org ([2001:4830:134:3::10]:43142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb0Jo-00034z-UO
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb0Jo-0006JV-7L
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:12:52 -0400
Date: Thu, 5 Jul 2018 11:12:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180705091245.GD3309@localhost.localdomain>
References: <20180704144751.28527-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704144751.28527-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] file-posix: Fix creation locking
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

Am 04.07.2018 um 16:47 hat Max Reitz geschrieben:
> This series fixes two bugs Kevin spotted in file-posix's creation
> locking.

Thanks, applied to the block branch.

Kevin
