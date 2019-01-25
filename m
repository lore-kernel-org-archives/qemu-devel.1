Received: from eggs.gnu.org ([209.51.188.92]:38962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gn9rO-0006zD-FO
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:22:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gn9rA-0001Ii-8j
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:21:53 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gn9r6-0001AU-F5
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:21:46 -0500
Received: by mail-pl1-x641.google.com with SMTP id p8so5174895plo.2
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 14:21:33 -0800 (PST)
Date: Fri, 25 Jan 2019 14:21:13 -0800
Message-Id: <20190125222113.31183-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Remove Michael Clark as a RISC-V
 Maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@sifive.com>

Michael is no longer employed by SiFive and does not want to continue
maintianing the RISC-V port.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index af339b86db76..47cb3c14298e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -259,7 +259,6 @@ F: include/hw/ppc/
 F: disas/ppc.c
 
 RISC-V
-M: Michael Clark <mjc@sifive.com>
 M: Palmer Dabbelt <palmer@sifive.com>
 M: Alistair Francis <Alistair.Francis@wdc.com>
 M: Sagar Karandikar <sagark@eecs.berkeley.edu>
-- 
2.18.1
