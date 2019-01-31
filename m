Received: from eggs.gnu.org ([209.51.188.92]:50028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp7xr-0001Ce-W9
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 03:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp7xq-0005U0-Sn
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 03:44:51 -0500
Received: from mga18.intel.com ([134.134.136.126]:7124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gp7xo-0005PW-MZ
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 03:44:50 -0500
Date: Thu, 31 Jan 2019 16:40:55 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190131084055.GA5579@yangzhon-Virtual>
References: <20190131073234.18037-1-yang.zhong@intel.com>
	<20190131073234.18037-8-yang.zhong@intel.com>
	<5eb05d1b-871c-7e2d-f463-b7eb121e9be9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eb05d1b-871c-7e2d-f463-b7eb121e9be9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 07/27] hw/arm/Makefile.objs: CONFIG_VIRT
 created for virt board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, yang.zhong@intel.com

On Thu, Jan 31, 2019 at 09:36:01AM +0100, Thomas Huth wrote:
> On 2019-01-31 08:32, Yang Zhong wrote:
> > make virt code configurable and the new CONFIG_VIRT definitions
> > added to the default-configs/arm-softmmu.mak to replace CONFIG_ACPI
> > in arm board.
> 
> I think the patch description needs a refresh. It's CONFIG_ARM_VIRT now,
> and CONFIG_ACPI is not replaced anymore.
>
  Yes, it's my mistake and i will change this in next version, thanks!

  Yang 
