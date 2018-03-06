Received: from eggs.gnu.org ([2001:4830:134:3::10]:47147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJTG-0006Yd-N3
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:46:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJTE-0003YX-0V
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:46:02 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:40903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etJTD-0003YC-RG
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:45:59 -0500
Received: by mail-pl0-x242.google.com with SMTP id i6-v6so12545695plt.7
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 12:45:59 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  7 Mar 2018 09:43:49 +1300
Message-Id: <1520369037-37977-15-git-send-email-mjc@sifive.com>
In-Reply-To: <1520369037-37977-1-git-send-email-mjc@sifive.com>
References: <1520369037-37977-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 14/22] RISC-V: Make virt header comment
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
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>

Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 include/hw/riscv/virt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index d22f184..dcb697f 100644
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
