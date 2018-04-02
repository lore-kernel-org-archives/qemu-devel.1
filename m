Received: from eggs.gnu.org ([2001:4830:134:3::10]:55152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1f2oIu-00012V-Cn
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 21:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1f2oIp-0004An-Jh
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 21:30:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:24381)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1f2oIp-00041w-9V
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 21:30:31 -0400
Date: Mon, 2 Apr 2018 09:29:46 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20180402012946.xuduglbk3swfm43f@hz-desktop>
References: <20180228072558.7434-1-haozhong.zhang@intel.com>
	<20180312153954.GA24440@stefanha-x1.localdomain>
	<20180313001150.gtbs4jz4degeblba@hz-desktop>
	<20180329191207.GH2982@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329191207.GH2982@work-vm>
Subject: Re: [Qemu-devel] [PATCH v4 0/8] nvdimm: guarantee persistence of
 QEMU writes to persistent memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, mst@redhat.com, Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Eduardo Habkost <ehabkost@redhat.com>

On 03/29/18 20:12 +0100, Dr. David Alan Gilbert wrote:
> * Haozhong Zhang (haozhong.zhang@intel.com) wrote:
> 
> <snip>
> 
> > Post-copy with NVDIMM currently fails with message "Postcopy on shared
> > RAM (...) is not yet supported". Is it enough?
> 
> What does it say now that postcopy-shared support is in?
> 

I'll check it later.

Haozhong
