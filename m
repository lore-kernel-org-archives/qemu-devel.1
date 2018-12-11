Received: from eggs.gnu.org ([2001:4830:134:3::10]:59292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8761f1f8f=anthony.perard@citrix.com>)
	id 1gWjud-0008TQ-UM
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:25:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8761f1f8f=anthony.perard@citrix.com>)
	id 1gWjud-0004Qr-3b
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:25:31 -0500
Date: Tue, 11 Dec 2018 15:24:55 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181211152455.GT18875@perard.uk.xensource.com>
References: <1544525238-3527-1-git-send-email-paul.durrant@citrix.com>
	<1544525238-3527-8-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1544525238-3527-8-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/18] xen: add event channel interface
 for XenDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org

On Tue, Dec 11, 2018 at 10:47:07AM +0000, Paul Durrant wrote:
> The legacy PV backend infrastructure provides functions to bind, unbind
> and send notifications to event channnels. Similar functionality will be
> required by XenDevice implementations so this patch adds the necessary
> support.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

When and where did this review happend? I can only find my review-by tag
on v2, which is missing here.

-- 
Anthony PERARD
