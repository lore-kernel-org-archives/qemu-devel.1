Received: from eggs.gnu.org ([2001:4830:134:3::10]:43355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dwQHl-0007Rj-L7
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dwQHh-0004SV-BT
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:06:45 -0400
Date: Mon, 25 Sep 2017 11:06:38 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170925100638.GJ14140@stefanha-x1.localdomain>
References: <20170923111411.18626-1-el13635@mail.ntua.gr>
	<20170923111411.18626-3-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170923111411.18626-3-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 2/3] block: rename
 bdrv_co_drain to bdrv_co_drain_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Sat, Sep 23, 2017 at 02:14:10PM +0300, Manos Pitsidianakis wrote:
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  include/block/block_int.h | 4 ++--
>  block/io.c                | 4 ++--
>  block/qed.c               | 6 +++---
>  3 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
