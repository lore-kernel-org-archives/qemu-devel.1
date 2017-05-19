Received: from eggs.gnu.org ([2001:4830:134:3::10]:47408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dBcNQ-0007JV-On
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dBcNP-00038P-Vi
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:31:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:61751)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dBcNP-00037L-Ms
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:31:07 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 19 May 2017 15:30:23 +0800
Message-Id: <1495179026-27872-4-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1495179026-27872-1-git-send-email-yang.zhong@intel.com>
References: <1495179026-27872-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v0 3/6] move tcg header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, anthony.xu@intel.com, Yang Zhong <yang.zhong@intel.com>

move translate-all.h to ./tcg

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 translate-all.h => tcg/translate-all.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename translate-all.h => tcg/translate-all.h (100%)

diff --git a/translate-all.h b/tcg/translate-all.h
similarity index 100%
rename from translate-all.h
rename to tcg/translate-all.h
-- 
1.9.1
