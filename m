Received: from eggs.gnu.org ([2001:4830:134:3::10]:56217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f1cyJ-0006TF-7h
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 15:12:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f1cyG-0007jV-3R
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 15:12:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34366 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f1cyF-0007il-VV
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 15:12:24 -0400
Date: Thu, 29 Mar 2018 20:12:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180329191207.GH2982@work-vm>
References: <20180228072558.7434-1-haozhong.zhang@intel.com>
	<20180312153954.GA24440@stefanha-x1.localdomain>
	<20180313001150.gtbs4jz4degeblba@hz-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313001150.gtbs4jz4degeblba@hz-desktop>
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
To: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, mst@redhat.com, Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Eduardo Habkost <ehabkost@redhat.com>

* Haozhong Zhang (haozhong.zhang@intel.com) wrote:

<snip>

> Post-copy with NVDIMM currently fails with message "Postcopy on shared
> RAM (...) is not yet supported". Is it enough?

What does it say now that postcopy-shared support is in?

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
