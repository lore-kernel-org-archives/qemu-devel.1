Received: from eggs.gnu.org ([2001:4830:134:3::10]:60150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <baiyaowei@cmss.chinamobile.com>) id 1fSwGh-0002en-8Z
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 23:16:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <baiyaowei@cmss.chinamobile.com>) id 1fSwGg-0006V4-HO
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 23:16:19 -0400
From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Date: Tue, 12 Jun 2018 23:15:49 -0400
Message-Id: <1528859749-25286-1-git-send-email-baiyaowei@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH] tracing.txt: add missing '-' for trace option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjt@tls.msk.ru, laurent@vivier.eu
Cc: qemu-trivial@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org, Yaowei Bai <baiyaowei@cmss.chinamobile.com>

Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
---
 docs/devel/tracing.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
index 07abbb3..6ab32cc 100644
--- a/docs/devel/tracing.txt
+++ b/docs/devel/tracing.txt
@@ -18,7 +18,7 @@ for debugging, profiling, and observing execution.
 
 3. Run the virtual machine to produce a trace file:
 
-    qemu -trace events=/tmp/events ... # your normal QEMU invocation
+    qemu --trace events=/tmp/events ... # your normal QEMU invocation
 
 4. Pretty-print the binary trace file:
 
-- 
1.8.3.1
