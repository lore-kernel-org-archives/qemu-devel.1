Received: from eggs.gnu.org ([2001:4830:134:3::10]:49179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eqR77-0005zg-Ma
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 17:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eqR76-0004mZ-Lc
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 17:19:17 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:41841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eqR76-0004mN-GI
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 17:19:16 -0500
Received: by mail-pl0-x241.google.com with SMTP id k8so10118849pli.8
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 14:19:16 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Tue, 27 Feb 2018 11:17:38 +1300
Message-Id: <1519683480-33201-2-git-send-email-mjc@sifive.com>
In-Reply-To: <1519683480-33201-1-git-send-email-mjc@sifive.com>
References: <1519683480-33201-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v7 01/23] RISC-V Maintainers
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
index a334a25..858ab51 100644
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
