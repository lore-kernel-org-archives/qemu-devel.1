Received: from eggs.gnu.org ([2001:4830:134:3::10]:45275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVxoU-0001g3-FE
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVxoQ-0005iq-Et
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:54:54 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 12:39:07 +0300
Message-Id: <7f473c284e9811e3ac5dfcae1f858bac5ade1066.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 03/31] README: Add linux to macOS build info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Peter Maydell <peter.maydell@linaro.org>

The README lists the URLs for the wiki pages describing
how to build on Linux and Windows; add the equivalent
link for building on macOS.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 README | 1 +
 1 file changed, 1 insertion(+)

diff --git a/README b/README
index bd8060a..cb60d05 100644
--- a/README
+++ b/README
@@ -45,6 +45,7 @@ of other UNIX targets. The simple steps to build QEMU are:
 Additional information can also be found online via the QEMU website:
 
   http://qemu-project.org/Hosts/Linux
+  http://qemu-project.org/Hosts/Mac
   http://qemu-project.org/Hosts/W32
 
 
-- 
2.1.4
