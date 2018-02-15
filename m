Received: from eggs.gnu.org ([2001:4830:134:3::10]:34251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBAk-0007Tu-Bb
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:29:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBAj-0003v0-NV
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:29:26 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBAj-0003ud-JC
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:29:25 -0500
Received: by mail-qt0-x242.google.com with SMTP id g14so10489339qti.2
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 20:29:25 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 01:28:34 -0300
Message-Id: <20180215042900.16078-5-f4bug@amsat.org>
In-Reply-To: <20180215042900.16078-1-f4bug@amsat.org>
References: <20180215042900.16078-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 04/30] hw/lm32/milkymist: remove unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Michael Walle <michael@walle.cc>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
2.16.1
