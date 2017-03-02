Received: from eggs.gnu.org ([2001:4830:134:3::10]:48288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=227bda417=anthony.perard@citrix.com>)
	id 1cjPZ2-0008Ew-JR
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 07:10:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=227bda417=anthony.perard@citrix.com>)
	id 1cjPYz-0001m9-ED
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 07:10:32 -0500
Received: from smtp02.citrix.com ([66.165.176.63]:44743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=227bda417=anthony.perard@citrix.com>)
	id 1cjPYz-0001ky-8U
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 07:10:29 -0500
Date: Thu, 2 Mar 2017 12:10:27 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170302121027.GH1760@perard.uk.xensource.com>
References: <1488452986-24501-1-git-send-email-paul.durrant@citrix.com>
	<1488452986-24501-6-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1488452986-24501-6-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] xen: use libxendevicemodel when
 available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>

On Thu, Mar 02, 2017 at 11:09:46AM +0000, Paul Durrant wrote:
> This patch modifies the wrapper functions in xen_common.h to use the
> new xendevicemodel interface if it is available along with compatibility
> code to use the old libxenctrl interface if it is not.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD
