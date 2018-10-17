Received: from eggs.gnu.org ([2001:4830:134:3::10]:44457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gCiBT-0004i1-PL
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gCiBO-0004Uw-V2
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:32:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:10864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1gCiBO-0004R8-2F
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:32:02 -0400
From: Tao Xu <tao3.xu@intel.com>
Date: Wed, 17 Oct 2018 17:30:52 +0800
Message-Id: <20181017093053.8811-1-tao3.xu@intel.com>
Subject: [Qemu-devel] [PATCH 0/1] Add PKU/OSPKE on Skylake-Server CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com
Cc: pbonzini@redhat.com, rth@twiddle.net, jingqi.liu@intel.com, robert.hu@intel.com, qemu-devel@nongnu.org, Tao Xu <tao3.xu@intel.com>

This patch adds PKU/OSPKE on Skylake-Server CPU model

Tao Xu (1):
  i386: Add PKU/OSPKE on Skylake-Server CPU model

 target/i386/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.17.1
