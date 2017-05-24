Received: from eggs.gnu.org ([2001:4830:134:3::10]:38846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDPhy-00015b-AL
	for qemu-devel@nongnu.org; Wed, 24 May 2017 02:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDPhx-0001hR-IW
	for qemu-devel@nongnu.org; Wed, 24 May 2017 02:23:46 -0400
Date: Wed, 24 May 2017 14:23:36 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170524062336.GN12279@lemon.lan>
References: <1495548064-10926-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495548064-10926-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] Block migration (migrate -b) fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

On Tue, 05/23 16:01, Kevin Wolf wrote:
> Kevin Wolf (4):
>   block: Fix anonymous BBs in blk_root_inactivate()
>   migration: Inactivate images after .save_live_complete_precopy()
>   migration/block: Clean up BBs in block_save_complete()
>   qemu-iotests: Block migration test

Reviewed-by: Fam Zheng <famz@redhat.com>
