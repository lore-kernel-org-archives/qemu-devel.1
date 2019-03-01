Received: from eggs.gnu.org ([209.51.188.92]:52690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzfaO-0006gN-K4
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:40:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzfaN-0005vo-W4
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:40:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gzfaN-0005tr-Od
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:40:11 -0500
Date: Fri, 1 Mar 2019 11:40:06 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190301114006.043e20cc@redhat.com>
In-Reply-To: <20190214081619.GB7652@stefanha-x1.localdomain>
References: <20190214031004.32522-1-stefanha@redhat.com>
	<20190214031004.32522-2-stefanha@redhat.com>
	<20190214072629.GA18896@richard>
	<20190214081619.GB7652@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] hostmem: simplify ifdef-s in
 file_backend_memory_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

On Thu, 14 Feb 2019 16:16:19 +0800
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Thu, Feb 14, 2019 at 03:26:29PM +0800, Wei Yang wrote:
> > Maybe change the title 
> > 
> >    s/hotmem/hostmem-file/
> > 
> > would be more proper.
> > 
> > I missed this in previous review.  
> 
> You're right.  This can be fixed when merging the patch.
> 
> Stefan

Did this patch fall through cracks?
