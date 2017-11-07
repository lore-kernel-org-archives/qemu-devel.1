Received: from eggs.gnu.org ([2001:4830:134:3::10]:53482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1eC2DF-0004SY-FI
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1eC2DB-0000Ik-LZ
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:38:37 -0500
Received: from m15-114.126.com ([220.181.15.114]:55228)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1eC2DA-0000HL-SD
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:38:33 -0500
From: Chen Hanxiao <chen_han_xiao@126.com>
Date: Tue,  7 Nov 2017 19:37:16 +0800
Message-Id: <20171107113716.14244-1-chen_han_xiao@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [Resend][PATCH] qapi-docs: fix a comment typo
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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
