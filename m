Received: from eggs.gnu.org ([2001:4830:134:3::10]:58158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eiaCC-0004o9-4P
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 01:24:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eiaC9-0005yc-0k
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 01:24:04 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:43844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eiaC8-0005xC-P2
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 01:24:00 -0500
Received: by mail-pg0-x241.google.com with SMTP id f6so1056824pgs.10
	for <qemu-devel@nongnu.org>; Sun, 04 Feb 2018 22:24:00 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Mon,  5 Feb 2018 19:22:26 +1300
Message-Id: <1517811767-75958-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v4 01/22] RISC-V Maintainers
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

Signed-off-by: Michael Clark <mjc@sifive.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f952d4..d607039 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -210,6 +210,17 @@ F: hw/ppc/
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
