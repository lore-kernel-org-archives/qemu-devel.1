Received: from eggs.gnu.org ([2001:4830:134:3::10]:57797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=66614e27e=anthony.perard@citrix.com>)
	id 1fIbbW-0002vq-R5
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=66614e27e=anthony.perard@citrix.com>)
	id 1fIbbS-0000MI-LE
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:11:06 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:15047)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=66614e27e=anthony.perard@citrix.com>)
	id 1fIbbS-0000LF-Bo
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:11:02 -0400
Date: Tue, 15 May 2018 15:40:24 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180515144024.GC2057@perard.uk.xensource.com>
References: <20180510091518.28199-1-paul.durrant@citrix.com>
	<20180510091518.28199-2-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180510091518.28199-2-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] xen-hvm: create separate function
 for ioreq server initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>

On Thu, May 10, 2018 at 10:15:16AM +0100, Paul Durrant wrote:
> The code is sufficiently substantial that it improves code readability
> to put it in a new function called by xen_hvm_init() rather than having
> it inline.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
