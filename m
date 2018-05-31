Received: from eggs.gnu.org ([2001:4830:134:3::10]:59253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fOVfh-0006SL-El
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fOVfe-0007xl-Ba
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:03:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:27411)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ross.zwisler@linux.intel.com>)
	id 1fOVfe-0007w5-31
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:03:46 -0400
Date: Thu, 31 May 2018 16:03:42 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Message-ID: <20180531220342.GH28256@linux.intel.com>
References: <20180521163203.26590-1-ross.zwisler@linux.intel.com>
	<20180525205051-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525205051-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [qemu PATCH v4 0/4] support NFIT platform
 capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>

On Fri, May 25, 2018 at 08:51:22PM +0300, Michael S. Tsirkin wrote:
> On Mon, May 21, 2018 at 10:31:59AM -0600, Ross Zwisler wrote:
> > Changes since v3:
> >  * Updated the text in docs/nvdimm.txt to make it clear that the value
> >    being passed in on the command line in an integer made up of various
> >    bit fields. (Rob Elliott)
> >  
> >  * Updated the "Highest Valid Capability" byte to be dynamic based on
> >    the highest valid bit in the user's input. (Rob Elliott)
> 
> Igor could you review pls? I think your comments have been addressed.

Ping?  Igor, can you pick this up?
