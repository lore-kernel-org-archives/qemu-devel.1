Received: from eggs.gnu.org ([2001:4830:134:3::10]:47855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDtsy-0000ry-4o
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:37:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDtsx-0001Lr-J2
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:37:08 -0400
Date: Thu, 25 May 2017 22:36:58 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170525143658.GA15891@lemon.lan>
References: <20170524202842.26724-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170524202842.26724-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/5] more blkdebug tweaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Wed, 05/24 15:28, Eric Blake wrote:
> I found a crasher and some odd behavior while rebasing my
> bdrv_get_block_status series, so I figured I'd get these things
> fixed first.  This is based on top of Max's block branch.

For patches 1,2,4,5: Acked-by: Fam Zheng <famz@redhat.com>
