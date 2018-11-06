Received: from eggs.gnu.org ([208.118.235.92]:54377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gK5y0-0002NZ-7u
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 13:20:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gK5vL-0005TZ-Vp
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 13:18:04 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  6 Nov 2018 19:17:10 +0100
Message-Id: <1541528230-31817-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Add an entry for the 'collie'
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

There is no active maintainer, but since Peter is picking up
patches via qemu-arm@nongnu.org, I think we could at least use
"Odd Fixes" as status here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0499e11..471cf72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -592,6 +592,12 @@ F: hw/*/pxa2xx*
 F: hw/misc/mst_fpga.c
 F: include/hw/arm/pxa.h
 
+Sharp SL-5500 (Collie) PDA
+L: qemu-arm@nongnu.org
+S: Odd Fixes
+F: hw/arm/collie.c
+F: hw/arm/strongarm*
+
 Stellaris
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-- 
1.8.3.1
