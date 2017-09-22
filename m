Received: from eggs.gnu.org ([2001:4830:134:3::10]:51194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dvL2V-0005r3-HP
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dvL2U-0005UH-JE
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:18:31 -0400
Date: Fri, 22 Sep 2017 11:18:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170922101822.GG9243@stefanha-x1.localdomain>
References: <20170921131707.17364-1-el13635@mail.ntua.gr>
	<20170921131707.17364-4-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170921131707.17364-4-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] block/throttle.c: add
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
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

On Thu, Sep 21, 2017 at 04:17:07PM +0300, Manos Pitsidianakis wrote:
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block/throttle.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
