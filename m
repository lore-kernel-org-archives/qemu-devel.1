Received: from eggs.gnu.org ([2001:4830:134:3::10]:35917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwj44-00058V-2x
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 02:09:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwj3z-0000iG-6y
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 02:09:52 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 26 Sep 2017 09:09:44 +0300
Message-Id: <20170926060944.5962-1-mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PATCH] qemu-doc.texi: remove trailing whitespace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

Reported-By: Vagrant Cascadian <vagrant@debian.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-doc.texi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 4076226f39..de23fca9dc 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -105,7 +105,7 @@ QEMU full system emulation has the following features:
 QEMU uses a full software MMU for maximum portability.
 
 @item
-QEMU can optionally use an in-kernel accelerator, like kvm. The accelerators 
+QEMU can optionally use an in-kernel accelerator, like kvm. The accelerators
 execute most of the guest code natively, while
 continuing to emulate the rest of the machine.
 
-- 
2.11.0
