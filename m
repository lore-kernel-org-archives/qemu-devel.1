Received: from eggs.gnu.org ([2001:4830:134:3::10]:37218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwBzV-0000VO-V4
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 14:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwBzS-0002IU-Rb
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 14:18:41 -0400
Date: Thu, 6 Apr 2017 20:18:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170406181833.GN4341@noname.redhat.com>
References: <433d922c5ad43020493323c5e065b4c4ef4157ab.1491500481.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433d922c5ad43020493323c5e065b4c4ef4157ab.1491500481.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] qemu-img: img_create does not support
 image-opts, fix docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, berrange@redhat.com, mreitz@redhat.com

Am 06.04.2017 um 19:45 hat Jeff Cody geschrieben:
> The documentation and help for qemu-img claims that 'qemu-img create'
> will take the '--image-opts' argument.  This is not true, so this
> patch removes those claims.
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>

Thanks, applied to the block branch.

Kevin
