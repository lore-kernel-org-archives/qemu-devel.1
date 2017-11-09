Received: from eggs.gnu.org ([2001:4830:134:3::10]:49718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1eClY7-0005uz-EQ
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:03:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1eClY1-0005vg-KP
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:03:11 -0500
From: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Date: Thu,  9 Nov 2017 17:32:51 +0530
Message-Id: <1510228971-6005-1-git-send-email-sundeep.lkml@gmail.com>
Subject: [Qemu-devel] [Qemu devel PATCH] MAINTAINERS: Add entries for
 Smartfusion2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, alistair23@gmail.com, f4bug@amsat.org, Subbaraya Sundeep <sundeep.lkml@gmail.com>

add voluntarily myself as maintainer for Smartfusion2

Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
---
 MAINTAINERS | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0cd4d02..dae08bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -564,6 +564,23 @@ M: Alistair Francis <alistair@alistair23.me>
 S: Maintained
 F: hw/arm/netduino2.c
 
+MSF2 SoC
+M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
+S: Maintained
+F: hw/arm/msf2-soc.c
+F: hw/misc/msf2-sysreg.c
+F: hw/timer/mss-timer.c
+F: hw/ssi/mss-spi.c
+F: include/hw/arm/msf2-soc.h
+F: include/hw/misc/msf2-sysreg.h
+F: include/hw/timer/mss-timer.h
+F: include/hw/ssi/mss-spi.h
+
+MSF2 SOM board
+M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
+S: Maintained
+F: hw/arm/msf2-som.c
+
 CRIS Machines
 -------------
 Axis Dev88
-- 
2.5.0
