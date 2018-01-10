Received: from eggs.gnu.org ([2001:4830:134:3::10]:44661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZQ77-0006CE-B3
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:48:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZQ73-0000J6-CJ
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:48:57 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:43834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eZQ72-0000Ih-Ty
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:48:53 -0500
Received: by mail-pg0-x241.google.com with SMTP id f14so1091745pga.10
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 15:48:52 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 10 Jan 2018 15:46:20 -0800
Message-Id: <1515628000-93285-2-git-send-email-mjc@sifive.com>
In-Reply-To: <1515628000-93285-1-git-send-email-mjc@sifive.com>
References: <1515628000-93285-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v2 01/21] RISC-V Maintainers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches+subscribe@groups.riscv.org>

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
