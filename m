Received: from eggs.gnu.org ([209.51.188.92]:58832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hL21A-0007XK-2I
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 04:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hL217-0004Rn-QY
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 04:52:06 -0400
Date: Mon, 29 Apr 2019 10:51:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190429085157.GA8492@localhost.localdomain>
References: <20190415155452.5115-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415155452.5115-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] qcow2: Preallocation fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Am 15.04.2019 um 17:54 hat Kevin Wolf geschrieben:
> Kevin Wolf (4):
>   qcow2: Avoid COW during metadata preallocation
>   qcow2: Fix preallocation bdrv_pwrite to wrong file
>   qcow2: Add errp to preallocate_co()
>   qcow2: Fix full preallocation with external data file

Applied the remaining patches to the block branch.

Kevin
