Received: from eggs.gnu.org ([2001:4830:134:3::10]:47165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fB19s-00081e-UU
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 12:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fB19s-0005rG-CP
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 12:51:12 -0400
Date: Tue, 24 Apr 2018 18:51:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180424165104.GF4080@localhost.localdomain>
References: <20180421132929.21610-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180421132929.21610-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/9] block: Add COR filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>

Am 21.04.2018 um 15:29 hat Max Reitz geschrieben:
> This series adds a copy-on-read block filter driver which works by
> simply setting the BDRV_REQ_COPY_ON_READ flag on write requests (and
> otherwise just passing everything through).

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
