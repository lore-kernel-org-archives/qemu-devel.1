Received: from eggs.gnu.org ([2001:4830:134:3::10]:41641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8789a7fed=anthony.perard@citrix.com>)
	id 1gXQ2K-0001Va-WA
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:24:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8789a7fed=anthony.perard@citrix.com>)
	id 1gXQ2H-0002rX-P3
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:24:16 -0500
Date: Thu, 13 Dec 2018 12:24:09 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181213122409.GA18875@perard.uk.xensource.com>
References: <1544613386-22045-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1544613386-22045-1-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Performance improvements for
 xen_disk^Wxen-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

On Wed, Dec 12, 2018 at 11:16:23AM +0000, Paul Durrant wrote:
> This series is a re-base of Tim's v2 series [1] on top of my series [2].
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg00243.html
> [2] https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02271.html

For the series:
Acked-by: Anthony PERARD <anthony.perard@citrix.com>

And I've pushed that here:
https://xenbits.xen.org/gitweb/?p=people/aperard/qemu-dm.git;a=shortlog;h=refs/heads/xen-next

-- 
Anthony PERARD
