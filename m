Received: from eggs.gnu.org ([2001:4830:134:3::10]:34574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eKF3n-0006z3-Bz
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 21:58:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eKF3m-0000SC-MU
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 21:58:47 -0500
Date: Thu, 30 Nov 2017 10:58:34 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171130025834.GI16237@lemon>
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-5-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171123020832.8165-5-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/17] block/vmdk: Add blkdebug events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

On Thu, 11/23 03:08, Max Reitz wrote:
> This is certainly not complete, but it includes at least write_aio and
> read_aio.

"and more" :)

Reviewed-by: Fam Zheng <famz@redhat.com>
