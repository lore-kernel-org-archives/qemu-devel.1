Received: from eggs.gnu.org ([2001:4830:134:3::10]:34919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dZSTb-000598-VD
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 21:48:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dZSTY-0003KY-PS
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 21:48:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:56963)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dZSTY-0003HS-FN
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 21:48:00 -0400
Date: Mon, 24 Jul 2017 09:47:41 +0800
From: Zhong Yang <yang.zhong@intel.com>
Message-ID: <20170724014741.GA16720@yangzhon-Virtual>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] About virtio device hotplug in Q35!
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcel@redhat.com, yang.zhong@intel.com

Hello all,

When we did virtio device hotplug in Q35 platform, which always failed in hotplug.

Would you please tell me how to configure VM to make virtio device hotplug work in Q35 platform?  Many thanks!


Regards,

Yang zhong
