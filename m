Received: from eggs.gnu.org ([2001:4830:134:3::10]:49148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daxyU-0005O0-90
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daxyT-0004wh-Fz
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:38:10 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 28 Jul 2017 02:36:08 -0300
Message-Id: <20170728053610.15770-46-f4bug@amsat.org>
In-Reply-To: <20170728053610.15770-1-f4bug@amsat.org>
References: <20170728053610.15770-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 45/47] MAINTAINERS: add missing entries for
 loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---

RFC because I'm not sure 'loader' is the same goal than 'generic-loader'

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dc1a69051c..224890643d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1196,6 +1196,8 @@ M: Alistair Francis <alistair.francis@xilinx.com>
 S: Maintained
 F: hw/core/generic-loader.c
 F: include/hw/core/generic-loader.h
+F: docs/generic-loader.txt
+F: hw/core/loader.c
 
 CHRP NVRAM
 M: Thomas Huth <thuth@redhat.com>
-- 
2.13.3
