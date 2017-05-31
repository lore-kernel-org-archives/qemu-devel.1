Received: from eggs.gnu.org ([2001:4830:134:3::10]:54576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dFx8i-0002tf-8j
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:29:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dFx8h-00037I-24
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:29:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:28402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dFx8g-00036p-PZ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:29:50 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 31 May 2017 14:29:01 +0800
Message-Id: <1496212144-14947-4-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1496212144-14947-1-git-send-email-yang.zhong@intel.com>
References: <1496212144-14947-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v2 3/6] tcg: move tcg header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, anthony.xu@intel.com, Yang Zhong <yang.zhong@intel.com>

tcg: move translate-all.h to tcg/ subdirectory

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
