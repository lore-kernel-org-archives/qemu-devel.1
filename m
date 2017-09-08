Received: from eggs.gnu.org ([2001:4830:134:3::10]:39057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dqNE9-0007FL-55
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:38:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dqNE8-0007UT-C5
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:38:01 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  8 Sep 2017 14:36:26 -0300
Message-Id: <20170908173632.6711-8-f4bug@amsat.org>
In-Reply-To: <20170908173632.6711-1-f4bug@amsat.org>
References: <20170908173632.6711-1-f4bug@amsat.org>
In-Reply-To: <20170908173146.6446-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 09/15] MAINTAINERS: add missing SSI entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>

Alistair Francis volunteered :)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 69ad3aac29..517c8f95d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -986,10 +986,13 @@ F: hw/scsi/lsi53c895a.c
 
 SSI
 M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
+M: Alistair Francis <alistair.francis@xilinx.com>
 S: Maintained
 F: hw/ssi/*
 F: hw/block/m25p80.c
+F: include/hw/ssi/ssi.h
 X: hw/ssi/xilinx_*
+F: tests/m25p80-test.c
 
 Xilinx SPI
 M: Alistair Francis <alistair.francis@xilinx.com>
-- 
2.14.1
