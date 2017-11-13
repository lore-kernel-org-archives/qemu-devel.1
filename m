Received: from eggs.gnu.org ([2001:4830:134:3::10]:47405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eEFSK-00048x-Jd
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:11:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eEFSG-0007jG-N2
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:11:20 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eEFSG-0007Yd-Ac
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:11:16 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eEFS4-00022x-Qi
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 14:11:04 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 14:11:38 +0000
Message-Id: <1510582304-27058-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1510582304-27058-1-git-send-email-peter.maydell@linaro.org>
References: <1510582304-27058-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/9] MAINTAINERS: Add entries for Smartfusion2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Subbaraya Sundeep <sundeep.lkml@gmail.com>

Voluntarily add myself as maintainer for Smartfusion2

Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1510552520-3566-1-git-send-email-sundeep.lkml@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0cd4d02..ffd77b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -564,6 +564,23 @@ M: Alistair Francis <alistair@alistair23.me>
 S: Maintained
 F: hw/arm/netduino2.c
 
+SmartFusion2
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
+Emcraft M2S-FG484
+M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
+S: Maintained
+F: hw/arm/msf2-som.c
+
 CRIS Machines
 -------------
 Axis Dev88
-- 
2.7.4
