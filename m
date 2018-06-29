Received: from eggs.gnu.org ([2001:4830:134:3::10]:51080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYoBK-00056G-4l
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 03:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYoBJ-0005xU-Ee
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 03:51:02 -0400
Date: Fri, 29 Jun 2018 09:50:51 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180629075051.GA15588@localhost.localdomain>
References: <20180629060328.4423-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629060328.4423-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] block: A few more copy offloading fixes
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

Am 29.06.2018 um 08:03 hat Fam Zheng geschrieben:
> These are unfortunately more serious than the previous two fixes but the
> patches are not complicated.

Thanks, applied to the block branch.

Kevin
