Received: from eggs.gnu.org ([2001:4830:134:3::10]:55450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1deiZI-0001I4-8L
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 09:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1deiZD-00027r-L2
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 09:59:40 -0400
Date: Mon, 7 Aug 2017 15:59:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170807135921.GE6578@localhost.localdomain>
References: <cover.1502109078.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1502109078.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 0/4] VHDX bugfixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com

Am 07.08.2017 um 14:38 hat Jeff Cody geschrieben:
> 
> Some VHDX bug fixes, including:
> 
> 1. Checking bdrv_getlength(), bdrv_flush(), and bdrv_truncate() return values

Thanks, applied to the block branch.

Kevin
