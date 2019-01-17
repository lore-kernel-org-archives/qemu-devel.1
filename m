Received: from eggs.gnu.org ([209.51.188.92]:34924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gk6NA-0001zy-GR
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:02:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gk6N4-0005nX-7m
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:02:12 -0500
Received: from mga05.intel.com ([192.55.52.43]:28198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gk6N3-0005av-UT
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:02:06 -0500
Date: Thu, 17 Jan 2019 19:58:15 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190117115815.GG11760@yangzhon-Virtual>
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-8-yang.zhong@intel.com>
	<6dc33418-7e61-efe3-be27-f627c9165519@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dc33418-7e61-efe3-be27-f627c9165519@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 07/37] hw/ppc/Makefile.objs: Build
 all boards conditinally with CONFIG_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, sameo@linux.intel.com, =?iso-8859-1?Q?=E1kos_Kov=E1cs?= <akoskovacs@gmx.com>, pbonzini@redhat.com, ehabkost@redhat.com, yang.zhong@intel.com

On Wed, Jan 16, 2019 at 09:41:19AM +0100, Thomas Huth wrote:
> 
> Could you please sort the new config switches into the right sections
> here? e.g. CONFIG_MAC_NEW/OLDWORLD in the "# For Macs" section, and the
> others into the "# For embedded PPC" section?
> 
  Yes, thanks Thomas, i will change this.  Yang
>  Thanks,
>   Thomas
> 
