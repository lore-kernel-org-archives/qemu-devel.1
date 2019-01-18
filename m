Received: from eggs.gnu.org ([209.51.188.92]:32780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkNnc-0005aQ-09
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 01:38:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkNna-0006yn-9U
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 01:38:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:7582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gkNna-0006pC-1X
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 01:38:38 -0500
Date: Fri, 18 Jan 2019 14:34:56 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190118063456.GA13969@yangzhon-Virtual>
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-20-yang.zhong@intel.com>
	<8c5e79dd-b177-44fb-4a3d-7aa55216d13d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c5e79dd-b177-44fb-4a3d-7aa55216d13d@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 19/37] kconfig: introduce kconfig
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com, Yang Zhong <yang.zhong@intel.com>

On Wed, Jan 16, 2019 at 11:44:13AM +0100, Thomas Huth wrote:
> > +source ipmi/Kconfig
> > +source vfio/Kconfig
> > +source adc/Kconfig
> > +source pcmcia/Kconfig
> > +source hyperv/Kconfig
> 
> Could you please sort the last 5 entries alphabetically into the list?
  
  Thanks Thomas, i will change this. Yang 
> > +# arch Kconfig
> > +source i386/Kconfig
> > +source arm/Kconfig
> > +source m68k/Kconfig
> > +source microblaze/Kconfig
> > +source mips/Kconfig
> > +source ppc/Kconfig
> > +source sh4/Kconfig
> > +source sparc/Kconfig
> > +source sparc64/Kconfig
> > +source lm32/Kconfig
> > +source xtensa/Kconfig
> > +source nios2/Kconfig
> > +source riscv/Kconfig
> 
> dito, please sort last 4 entries alphabetically into the list.
> 
  Thanks, i will change this. 
  
  Regards,

  Yang
> Apart from that, patch looks good to me.
> 
>  Thomas
