Received: from eggs.gnu.org ([2001:4830:134:3::10]:41162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esoHU-0003DY-Te
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:27:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esoHU-0006pr-6y
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:27:48 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  5 Mar 2018 08:27:06 -0300
Message-Id: <20180305112732.26471-5-f4bug@amsat.org>
In-Reply-To: <20180305112732.26471-1-f4bug@amsat.org>
References: <20180305112732.26471-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 04/30] hw/lm32/milkymist: remove unused
 include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Michael Walle <michael@walle.cc>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Thomas Huth <thuth@redhat.com>
---
 hw/lm32/milkymist.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 471a74eaa1..c28379399f 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -30,7 +30,6 @@
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "sysemu/block-backend.h"
 #include "milkymist-hw.h"
 #include "lm32.h"
 #include "exec/address-spaces.h"
-- 
2.16.2
