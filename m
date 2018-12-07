Received: from eggs.gnu.org ([2001:4830:134:3::10]:54930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87219212e=anthony.perard@citrix.com>)
	id 1gVJNC-0002tX-6b
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:53:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87219212e=anthony.perard@citrix.com>)
	id 1gVJN8-0001JM-P9
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:53:05 -0500
Date: Fri, 7 Dec 2018 16:52:58 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181207165258.GL18875@perard.uk.xensource.com>
References: <1544108924-10841-1-git-send-email-paul.durrant@citrix.com>
	<1544108924-10841-14-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1544108924-10841-14-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v2 13/18] xen: purge 'blk' and 'ioreq' from
 function names in dataplane/xen-block.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Thu, Dec 06, 2018 at 03:08:39PM +0000, Paul Durrant wrote:
> This is a purely cosmetic patch that purges remaining use of 'blk' and
> 'ioreq' in local function names, and then makes sure all functions are
> prefixed with 'xen_block_'.
> 
> No functional change.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
