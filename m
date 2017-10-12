Received: from eggs.gnu.org ([2001:4830:134:3::10]:44043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1e2XFF-0007L9-J9
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 02:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1e2XFC-000219-GC
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 02:45:25 -0400
Received: from m15-112.126.com ([220.181.15.112]:49179)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1e2XFB-0001xS-9C
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 02:45:22 -0400
From: Chen Hanxiao <chen_han_xiao@126.com>
Date: Thu, 12 Oct 2017 14:44:48 +0800
Message-Id: <20171012064448.20276-1-chen_han_xiao@126.com>
Subject: [Qemu-devel] [PATCH] qapi-docs: fix a comment typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: armbru@redhat.com, mdroth@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, Chen Hanxiao <chen_han_xiao@126.com>

From: Chen Hanxiao <chenhanxiao@gmail.com>

  s/Subection/Subsection

Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
---
 docs/devel/qapi-code-gen.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index f04c63fe82..06ab699066 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -63,7 +63,7 @@ Comment text starting with '=' is a section title:
 
 Double the '=' for a subsection title:
 
-    # == Subection title
+    # == Subsection title
 
 '|' denotes examples:
 
-- 
2.13.5
