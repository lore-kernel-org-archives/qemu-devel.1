Received: from eggs.gnu.org ([2001:4830:134:3::10]:54697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4CNc-0006HI-UR
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4CNZ-0004cy-S9
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:52:56 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 16 Oct 2017 23:33:28 +0300
Message-Id: <326c4c3c48fdd4a5bf4f14abc95787440ac1acec.1508185933.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
References: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
References: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 01/14] qemu-doc.texi: remove trailing whitespace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org

Remove trailing whitespace in qemu-doc.texi, as it causes
reproducibility issues depending on the echo implementation
used by the Makefile.

Reported-By: Vagrant Cascadian <vagrant@debian.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qemu-doc.texi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index d8bb2c664f..8c10956a66 100644
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
