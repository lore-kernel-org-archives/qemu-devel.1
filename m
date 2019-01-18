Received: from eggs.gnu.org ([209.51.188.92]:33762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkNtV-00073T-Ts
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 01:44:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkNtU-0008Lz-TM
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 01:44:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:57799)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gkNtU-0008Jh-Hz
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 01:44:44 -0500
Date: Fri, 18 Jan 2019 14:41:03 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190118064103.GB13969@yangzhon-Virtual>
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-20-yang.zhong@intel.com>
	<8c5e79dd-b177-44fb-4a3d-7aa55216d13d@redhat.com>
	<75ae9c60-de5f-3e69-f8af-94f3bc8d1db7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75ae9c60-de5f-3e69-f8af-94f3bc8d1db7@redhat.com>
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

On Wed, Jan 16, 2019 at 03:06:33PM +0100, Thomas Huth wrote:
> FWIW, looks like we still need alpha/Kconfig, cris/Kconfig,
> hppa/Kconfig, unicore32/Kconfig, tricore/Kconfig and xtensa/Kconfig ?
> 

   Hello Thomas,

   v3 will add below new ARCH/Kconfig
   alpha/Kconfig
   cris/Kconfig
   hppa/Kconfig
   unicore32/Kconfig
   tricore/Kconfig
   moxie/Kconfig
   openrisc/Kconfig

   So, i will also make those ARCH/Makefile.objs confighrable. thanks!

   Please note: 
   I will not add hw/s390x/Kconfig because i do not know how to configure this IBM platform.

   Regards,

   Yang
>  Thomas
