Received: from eggs.gnu.org ([2001:4830:134:3::10]:33304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fEMaK-0002B1-18
	for qemu-devel@nongnu.org; Thu, 03 May 2018 18:20:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fEMaG-0007Au-SY
	for qemu-devel@nongnu.org; Thu, 03 May 2018 18:20:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:32159)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ross.zwisler@linux.intel.com>)
	id 1fEMaG-000783-J6
	for qemu-devel@nongnu.org; Thu, 03 May 2018 18:20:16 -0400
Date: Thu, 3 May 2018 16:20:13 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Message-ID: <20180503222013.GA23376@linux.intel.com>
References: <20180427215314.23168-1-ross.zwisler@linux.intel.com>
	<20180430113858.GH4002@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430113858.GH4002@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH 1/3] nvdimm: fix typo in label-size
 definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, linux-nvdimm <linux-nvdimm@lists.01.org>

On Mon, Apr 30, 2018 at 12:38:58PM +0100, Stefan Hajnoczi wrote:
> On Fri, Apr 27, 2018 at 03:53:12PM -0600, Ross Zwisler wrote:
> > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> > Fixes: commit da6789c27c2e ("nvdimm: add a macro for property "label-size"")
> > Cc: Haozhong Zhang <haozhong.zhang@intel.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  hw/mem/nvdimm.c         | 2 +-
> >  include/hw/mem/nvdimm.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thank you for the review.

This is my first QEMU submission - do I need to do anything else to get this
merged (create a pull request somewhere), or do I just wait for a maintainer
to pull it in?

Thanks,
- Ross
