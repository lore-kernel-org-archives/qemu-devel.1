Received: from eggs.gnu.org ([2001:4830:134:3::10]:55793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eu9Qj-0004Kj-AR
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:14:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eu9Qi-00073X-Ir
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:14:53 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:46605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eu9Qi-00073B-C8
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:14:52 -0500
Received: by mail-pg0-x243.google.com with SMTP id r26so3113283pgv.13
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 20:14:52 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Fri,  9 Mar 2018 17:12:36 +1300
Message-Id: <1520568765-58189-15-git-send-email-mjc@sifive.com>
In-Reply-To: <1520568765-58189-1-git-send-email-mjc@sifive.com>
References: <1520568765-58189-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v2 14/23] RISC-V: Make virt header comment
 title consistent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 include/hw/riscv/virt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 3a4f23e..91163d6 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -1,5 +1,5 @@
 /*
- * SiFive VirtIO Board
+ * QEMU RISC-V VirtIO machine interface
  *
  * Copyright (c) 2017 SiFive, Inc.
  *
-- 
2.7.0
