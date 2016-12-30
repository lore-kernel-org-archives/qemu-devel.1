Received: from eggs.gnu.org ([2001:4830:134:3::10]:34202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cMlLZ-00047i-HB
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 19:47:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cMlLY-00089k-Pc
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 19:47:01 -0500
Date: Fri, 30 Dec 2016 08:46:51 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161230004651.GA24498@lemon>
References: <20161220163139.12016-1-famz@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190BEED9B@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190BEED9B@SHSMSX101.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] RFC: A VFIO based block driver for
 NVMe device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Karl Rister <krister@redhat.com>

On Thu, 12/29 04:09, Tian, Kevin wrote:
> is it a tradeoff between performance (better than linux-aio) and composability
> (snapshot and live migration which not supported by direct passthrough)?

Yes.

Fam
