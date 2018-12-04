Received: from eggs.gnu.org ([2001:4830:134:3::10]:41665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=869086d29=anthony.perard@citrix.com>)
	id 1gU8WK-00062h-8m
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 06:05:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=869086d29=anthony.perard@citrix.com>)
	id 1gU8WJ-0006Q8-LJ
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 06:05:40 -0500
Date: Tue, 4 Dec 2018 11:05:21 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181204110521.GR14786@perard.uk.xensource.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-12-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181121151211.15997-12-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 11/18] xen: remove 'XenBlkDev' and 'blkdev'
 names from dataplane/xen-qdisk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed, Nov 21, 2018 at 03:12:04PM +0000, Paul Durrant wrote:
> This is a purely cosmetic patch that substitutes the old 'struct XenBlkDev'
> name with 'XenQdiskDataPlane' and 'blkdev' field/variable names with
> 'dataplane', and then does necessary fix-up to adhere to coding style.
> 
> No functional change.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
