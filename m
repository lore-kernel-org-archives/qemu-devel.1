Received: from eggs.gnu.org ([2001:4830:134:3::10]:47908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZSWX-00034A-GY
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 21:23:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZSWU-00087J-Mx
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 21:23:21 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:37466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eZSWU-00086Y-HC
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 21:23:18 -0500
Received: by mail-pf0-x242.google.com with SMTP id p1so16178pfh.4
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 18:23:18 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 10 Jan 2018 18:21:44 -0800
Message-Id: <1515637324-96034-2-git-send-email-mjc@sifive.com>
In-Reply-To: <1515637324-96034-1-git-send-email-mjc@sifive.com>
References: <1515637324-96034-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v3 01/21] RISC-V Maintainers
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
index bc2d3a4..17af5b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -209,6 +209,17 @@ F: hw/ppc/
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
