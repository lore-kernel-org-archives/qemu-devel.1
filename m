Received: from eggs.gnu.org ([2001:4830:134:3::10]:33884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eWPNd-0000Nq-Bw
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:25:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eWPNZ-0003Zz-FO
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:25:33 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  2 Jan 2018 17:25:26 +0100
Message-Id: <1514910326-31234-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Add qemu-binfmt-conf.sh script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org

qemu-binfmt-conf.sh is used for the Linux usermode emulation, so
let's add this file to that section in the MAINTAINERS file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 73a5555..e92618f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1713,6 +1713,7 @@ R: Laurent Vivier <laurent@vivier.eu>
 S: Maintained
 F: linux-user/
 F: default-configs/*-linux-user.mak
+F: scripts/qemu-binfmt-conf.sh
 
 Tiny Code Generator (TCG)
 -------------------------
-- 
1.8.3.1
