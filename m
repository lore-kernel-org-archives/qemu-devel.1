Received: from eggs.gnu.org ([2001:4830:134:3::10]:53100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eykeR-00023O-G7
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eykeQ-00027h-2a
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:48:02 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:39178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eykeP-00027U-T1
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:48:02 -0400
Received: by mail-pg0-x242.google.com with SMTP id a19so2401246pgw.6
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 13:48:01 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 21 Mar 2018 13:46:49 -0700
Message-Id: <1521665220-3869-14-git-send-email-mjc@sifive.com>
In-Reply-To: <1521665220-3869-1-git-send-email-mjc@sifive.com>
References: <1521665220-3869-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/24] RISC-V: Make virt header comment title
 consistent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
