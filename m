Received: from eggs.gnu.org ([2001:4830:134:3::10]:58605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eWXCK-0005V4-T2
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eWXCJ-0007n0-KJ
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:46:24 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:45322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eWXCJ-0007mP-E5
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:46:23 -0500
Received: by mail-pl0-x241.google.com with SMTP id o2so128550plk.12
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 16:46:23 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  3 Jan 2018 13:44:05 +1300
Message-Id: <1514940265-18093-2-git-send-email-mjc@sifive.com>
In-Reply-To: <1514940265-18093-1-git-send-email-mjc@sifive.com>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 01/21] RISC-V Maintainers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Add Michael Clark, Sagar Karandikar and Bastian Koppelmann as
RISC-V Maintainers.

Signed-off-by: Michael Clark <mjc@sifive.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 73a5555..09a1314 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -209,6 +209,16 @@ F: hw/ppc/
 F: include/hw/ppc/
 F: disas/ppc.c
 
+RISC-V
+M: Michael Clark <mjc@sifive.com>
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
