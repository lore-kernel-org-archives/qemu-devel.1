Received: from eggs.gnu.org ([2001:4830:134:3::10]:48068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4366824e0=wei.liu2@citrix.com>)
	id 1dxExi-0003TG-3R
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4366824e0=wei.liu2@citrix.com>)
	id 1dxExd-0004xj-6t
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:13:26 -0400
Received: from smtp.citrix.com ([66.165.176.89]:54633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4366824e0=wei.liu2@citrix.com>)
	id 1dxExc-0004xL-W3
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:13:21 -0400
Date: Wed, 27 Sep 2017 17:13:04 +0100
From: Wei Liu <wei.liu2@citrix.com>
Message-ID: <20170927161304.ejmw6icy73pvjm7j@citrix.com>
References: <20170927161009.28091-1-wei.liu2@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20170927161009.28091-1-wei.liu2@citrix.com>
Subject: Re: [Qemu-devel] [PATCH] xen-hvm: use errno in error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Xen-devel <xen-devel@lists.xenproject.org>, Wei Liu <wei.liu2@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD <anthony.perard@citrix.com>

On Wed, Sep 27, 2017 at 05:10:09PM +0100, Wei Liu wrote:
> The error code is encoding in errno, not rc.
> 

"is encoded", sorry for the typo...
