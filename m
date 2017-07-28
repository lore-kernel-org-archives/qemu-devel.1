Received: from eggs.gnu.org ([2001:4830:134:3::10]:48910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daxyG-0005AG-Ea
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daxyE-0004bn-Be
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:37:56 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 28 Jul 2017 02:36:02 -0300
Message-Id: <20170728053610.15770-40-f4bug@amsat.org>
In-Reply-To: <20170728053610.15770-1-f4bug@amsat.org>
References: <20170728053610.15770-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 39/47] MAINTAINERS: add missing SSI entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
RFC because I'm not sure m25p80 fits.

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 54e35fdab9..83597fca4e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1010,7 +1010,9 @@ M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
 S: Maintained
 F: hw/ssi/*
 F: hw/block/m25p80.c
+F: include/hw/ssi/ssi.h
 X: hw/ssi/xilinx_*
+F: tests/m25p80-test.c
 
 Xilinx SPI
 M: Alistair Francis <alistair.francis@xilinx.com>
-- 
2.13.3
