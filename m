Received: from eggs.gnu.org ([2001:4830:134:3::10]:32942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d4odC-0004RR-Ps
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 09:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d4od9-0000Xp-MQ
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 09:11:18 -0400
Date: Sun, 30 Apr 2017 21:11:04 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170430131104.GA24566@lemon.lan>
References: <149346893378.132.3063923710149667629@c05f1edc8ed1>
	<8874ac16-9e54-7c67-8e56-8ed92942ee58@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8874ac16-9e54-7c67-8e56-8ed92942ee58@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v4] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org, peterx@redhat.com, borntraeger@de.ibm.com, alex.williamson@redhat.com, qemu-ppc@nongnu.org, cornelia.huck@de.ibm.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Sat, 04/29 22:36, Alexey Kardashevskiy wrote:
> > === OUTPUT BEGIN ===
> > Checking PATCH 1/1: memory/iommu: QOM'fy IOMMU MemoryRegion...
> > ERROR: spaces required around that '*' (ctx:WxO)
> > #156: FILE: hw/dma/rc4030.c:720:
> > +DeviceState *rc4030_init(rc4030_dma **dmas, IOMMUMemoryRegion **dma_mr)
> 
> 
> What does the script really want here? I am confused.

Must be a false positive here.

Fam
