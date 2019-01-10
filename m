Received: from eggs.gnu.org ([209.51.188.92]:55290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ghW3b-00009G-EA
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:51:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ghVuO-0002ac-6Y
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:41:48 -0500
Received: from mga07.intel.com ([134.134.136.100]:19451)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1ghVuM-0002WP-7R
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:41:48 -0500
Date: Thu, 10 Jan 2019 16:37:53 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190110083753.GA31730@yangzhon-Virtual>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] If Qemu support NVMe over Fabrics ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: pbonzini@redhat.com, fam@euphon.net, keith.busch@intel.com

Hello all,

Do you know if Qemu support NVMe over Fabrics(NVMe-oF)?
https://nvmexpress.org/wp-content/uploads/NVMe_Over_Fabrics.pdf

The Qemu has enabled RDMA in last year, and i am not sure if Qemu 
should support NVME-oF. If Qemu support it, would you please share
me the qemu related command or guides? thanks a lot!

Regards,

Yang
