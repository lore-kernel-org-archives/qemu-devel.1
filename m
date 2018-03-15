Received: from eggs.gnu.org ([2001:4830:134:3::10]:44684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewVxC-0005CZ-It
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 12:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewVxB-0001ff-W1
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 12:42:10 -0400
Date: Thu, 15 Mar 2018 17:41:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180315164158.GC3876@localhost.localdomain>
References: <20180315035157.6929-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315035157.6929-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Fix leak of ignore_children in
 error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 15.03.2018 um 04:51 hat Fam Zheng geschrieben:
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Thanks, applied to the block branch.

Kevin
