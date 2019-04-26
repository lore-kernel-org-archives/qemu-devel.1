Received: from eggs.gnu.org ([209.51.188.92]:60498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hJxXl-00043x-Ia
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hJxOC-0001GC-UM
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:43:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:25745)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hJxOC-00016Z-Mr
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:43:28 -0400
From: Zhang Chen <chen.zhang@intel.com >
Date: Fri, 26 Apr 2019 17:39:20 +0800
Message-Id: <20190426093920.5616-1-chen.zhang@intel.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Add qemu-options* to related field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
Cc: Zhang Chen <zhangckid@gmail.com>, Zhang Chen <chen.zhang@intel.com>

From: Zhang Chen <chen.zhang@intel.com>

No one to maintain qemu-options related file, add it to Markus's
Command line option argument parsing field.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 23db6f8408..acc3b32f88 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1800,6 +1800,7 @@ F: tests/test-keyval.c
 F: tests/test-qemu-opts.c
 F: util/keyval.c
 F: util/qemu-option.c
+F: qemu-options*
 
 Coverity model
 M: Markus Armbruster <armbru@redhat.com>
-- 
2.17.GIT
