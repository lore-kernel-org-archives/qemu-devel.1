Received: from eggs.gnu.org ([2001:4830:134:3::10]:49005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daxyL-0005FD-BR
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:38:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daxyK-0004lH-J9
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:38:01 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 28 Jul 2017 02:36:04 -0300
Message-Id: <20170728053610.15770-42-f4bug@amsat.org>
In-Reply-To: <20170728053610.15770-1-f4bug@amsat.org>
References: <20170728053610.15770-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 41/47] MAINTAINERS: add missing I2C entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <cminyard@mvista.com>, Alastair D'Silva <alastair@d-silva.org>, KONRAD Frederic <fred.konrad@greensocs.com>, Igor Mammedov <imammedo@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb6a82c1ad..46807decf5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1630,6 +1630,12 @@ F: include/sysemu/replay.h
 F: docs/replay.txt
 F: stubs/replay.c
 
+I2C
+S: Orphan
+F: hw/i2c/core.c
+F: include/hw/i2c/i2c.h
+F: tests/libqos/i2c.?
+
 Usermode Emulation
 ------------------
 Overall
-- 
2.13.3
