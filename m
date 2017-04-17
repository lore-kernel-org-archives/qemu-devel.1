Received: from eggs.gnu.org ([2001:4830:134:3::10]:58308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d00gq-0001lG-7x
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 03:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d00gp-0008UO-F7
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 03:03:12 -0400
Date: Mon, 17 Apr 2017 15:03:03 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170417070303.GA13582@lemon.lan>
References: <20170413160625.27719-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170413160625.27719-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/2] block: An empty filename
 counts as no filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Thu, 04/13 18:06, Max Reitz wrote:
> See patch 1 for what is happening when you try "qemu-img info ''" and
> for the fix.
> 
> (Patch 2 just adds a simple test.)

Reviewed-by: Fam Zheng <famz@redhat.com>
