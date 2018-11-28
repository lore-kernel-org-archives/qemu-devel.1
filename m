Received: from eggs.gnu.org ([2001:4830:134:3::10]:43292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gS1rC-0000aw-Da
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:34:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gS1r9-0007AE-9h
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:34:30 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 28 Nov 2018 10:34:23 -0500
Message-Id: <20181128153423.11916-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH trivial] docs/devel/build-system: fix 'softmu'
 typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 docs/devel/build-system.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/build-system.txt b/docs/devel/build-system.txt
index 52501f2ad9..f9fd27fab0 100644
--- a/docs/devel/build-system.txt
+++ b/docs/devel/build-system.txt
@@ -393,7 +393,7 @@ all use $(obj) as a prefix to the target, e.g.
 This file provides the entry point used to build each individual system
 or userspace emulator target. Each enabled target has its own
 subdirectory. For example if configure is run with the argument
-'--target-list=x86_64-softmmu', then a sub-directory 'x86_64-softmu'
+'--target-list=x86_64-softmmu', then a sub-directory 'x86_64-softmmu'
 will be created, containing a 'Makefile' which symlinks back to
 Makefile.target
 
-- 
2.17.1
