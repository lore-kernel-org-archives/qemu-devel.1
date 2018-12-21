Received: from eggs.gnu.org ([2001:4830:134:3::10]:53051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gaNHP-0001fm-5m
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:04:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gaNHN-0004FM-Rk
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:04:03 -0500
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831]:40303)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gaNHN-0004CU-GZ
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:04:01 -0500
Received: by mail-qt1-x831.google.com with SMTP id k12so6183681qtf.7
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 08:03:59 -0800 (PST)
Date: Fri, 21 Dec 2018 08:03:07 -0800
Message-Id: <20181221160307.14819-15-palmer@sifive.com>
In-Reply-To: <20181221160307.14819-1-palmer@sifive.com>
References: <20181221160307.14819-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 14/14] MAINTAINERS: Mark RISC-V as Supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@sifive.com>

There's at least two of us that are paid to work on this.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d676c73f8840..317eff6cec4d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -262,7 +262,7 @@ M: Alistair Francis <Alistair.Francis@wdc.com>
 M: Sagar Karandikar <sagark@eecs.berkeley.edu>
 M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
 L: qemu-riscv@nongnu.org
-S: Maintained
+S: Supported
 F: target/riscv/
 F: hw/riscv/
 F: include/hw/riscv/
-- 
2.18.1
