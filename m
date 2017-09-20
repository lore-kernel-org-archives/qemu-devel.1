Received: from eggs.gnu.org ([2001:4830:134:3::10]:60346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dufzV-0000Bu-Ir
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:28:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dufzU-0002UV-Q2
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:28:41 -0400
Date: Wed, 20 Sep 2017 15:28:25 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170920142825.GF9409@stefanha-x1.localdomain>
References: <20170920102311.25736-1-el13635@mail.ntua.gr>
	<20170920102311.25736-3-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170920102311.25736-3-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH 2/3] block: rename bdrv_co_drain to
 bdrv_co_drain_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>

On Wed, Sep 20, 2017 at 01:23:10PM +0300, Manos Pitsidianakis wrote:
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  include/block/block_int.h | 2 +-
>  block/io.c                | 4 ++--
>  block/qed.c               | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
