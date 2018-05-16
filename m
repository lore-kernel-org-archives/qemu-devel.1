Received: from eggs.gnu.org ([2001:4830:134:3::10]:36287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=667e0e3bc=anthony.perard@citrix.com>)
	id 1fIx1a-0002Fg-Er
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=667e0e3bc=anthony.perard@citrix.com>)
	id 1fIx1V-0007z3-H5
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:03:26 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:17444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=667e0e3bc=anthony.perard@citrix.com>)
	id 1fIx1V-0007yV-6o
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:03:21 -0400
Date: Wed, 16 May 2018 15:02:59 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180516140259.GG2057@perard.uk.xensource.com>
References: <1525461967-32174-1-git-send-email-paul.durrant@citrix.com>
	<1525461967-32174-3-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1525461967-32174-3-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/8] xen_disk: remove open-coded use of
 libxengnttab
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-block@nongnu.org, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Fri, May 04, 2018 at 08:26:01PM +0100, Paul Durrant wrote:
> Now that helpers are present in xen_backend, this patch removes open-coded
> calls to libxengnttab from the xen_disk code.
> 
> This patch also fixes one whitspace error in the assignment of the
> XenDevOps initialise method.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
