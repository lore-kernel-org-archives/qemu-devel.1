Received: from eggs.gnu.org ([2001:4830:134:3::10]:36547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g83IM-0003Oh-D1
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g83IL-0007f2-Ln
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:03:58 -0400
Date: Thu, 4 Oct 2018 15:03:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181004130346.GF6009@localhost.localdomain>
References: <20181003102313.3953-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003102313.3953-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH] block: replace "discard" literal with
 BDRV_OPT_DISCARD macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 03.10.2018 um 12:23 hat Alberto Garcia geschrieben:
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Thanks, applied to the block branch.

Kevin
