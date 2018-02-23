Received: from eggs.gnu.org ([2001:4830:134:3::10]:58330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ep108-0000sI-6p
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 19:14:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ep0zY-0004oY-4i
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 19:14:12 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:42917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ep0zX-0004mZ-PT
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 19:13:35 -0500
Received: by mail-pf0-x241.google.com with SMTP id t15so2771104pfh.9
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 16:13:35 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Fri, 23 Feb 2018 13:11:47 +1300
Message-Id: <1519344729-73482-2-git-send-email-mjc@sifive.com>
In-Reply-To: <1519344729-73482-1-git-send-email-mjc@sifive.com>
References: <1519344729-73482-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v6 01/23] RISC-V Maintainers
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

Add Michael Clark, Palmer Dabbelt, Sagar Karandikar and Bastian
Koppelmann as RISC-V Maintainers.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e7adad..147b05f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -233,6 +233,17 @@ F: hw/ppc/
 F: include/hw/ppc/
 F: disas/ppc.c
 
+RISC-V
+M: Michael Clark <mjc@sifive.com>
+M: Palmer Dabbelt <palmer@sifive.com>
+M: Sagar Karandikar <sagark@eecs.berkeley.edu>
+M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
+S: Maintained
+F: target/riscv/
+F: hw/riscv/
+F: include/hw/riscv/
+F: disas/riscv.c
+
 S390
 M: Richard Henderson <rth@twiddle.net>
 M: Alexander Graf <agraf@suse.de>
-- 
2.7.0
