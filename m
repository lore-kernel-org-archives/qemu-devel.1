Received: from eggs.gnu.org ([2001:4830:134:3::10]:36991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fwpxX-0004yP-1p
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 10:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fwpxW-0000xr-DV
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 10:36:06 -0400
Date: Mon, 3 Sep 2018 16:35:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180903143557.GB14463@dhcp-200-186.str.redhat.com>
References: <20180810162658.6562-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810162658.6562-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] commit: Add top-node/base-node options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Am 10.08.2018 um 18:26 hat Kevin Wolf geschrieben:
> Kevin Wolf (2):
>   commit: Add top-node/base-node options
>   qemu-iotests: Test commit with top-node/base-node

Fixed the version numbers in the QMP documentation and applied to the
block branch.

I'll still have to look into Peter's problem, but as the same happens
with filenames, there's no reason why it should hold up this series.

Kevin
