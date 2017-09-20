Received: from eggs.gnu.org ([2001:4830:134:3::10]:59931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dufy0-0007Ag-PJ
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dufxz-0001aE-UE
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:27:08 -0400
Date: Wed, 20 Sep 2017 15:26:57 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170920142657.GD9409@stefanha-x1.localdomain>
References: <20170920102311.25736-1-el13635@mail.ntua.gr>
	<20170920102311.25736-4-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170920102311.25736-4-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH 3/3] block/throttle.c: add
 bdrv_co_drain_begin/end callbacks
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

On Wed, Sep 20, 2017 at 01:23:11PM +0300, Manos Pitsidianakis wrote:
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block/throttle.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
