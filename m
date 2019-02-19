Received: from eggs.gnu.org ([209.51.188.92]:51340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw0u9-0000L2-LS
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw0u7-0004Eq-TD
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gw0u7-0004EL-Mk
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:27 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 19 Feb 2019 09:36:58 +0100
Message-Id: <1550565421-10944-12-git-send-email-thuth@redhat.com>
In-Reply-To: <1550565421-10944-1-git-send-email-thuth@redhat.com>
References: <1550565421-10944-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 11/14] MAINTAINERS: Clean up the RISC-V TCG
 backend section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>

The e-mail address mjc@sifive.com of Micheal is not valid anymore.
Commit 7d04ac38959f8115f2a02 removed the entry already from the main
RISC-V section, but apparently forgot to remove it from the TCG
backend section, too.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Fixes: 7d04ac38959f8115f2a029d81db1c8aac179aa95
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b00caaf..1d0dcde 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2232,7 +2232,6 @@ F: tcg/ppc/
 F: disas/ppc.c
 
 RISC-V
-M: Michael Clark <mjc@sifive.com>
 M: Palmer Dabbelt <palmer@sifive.com>
 M: Alistair Francis <Alistair.Francis@wdc.com>
 L: qemu-riscv@nongnu.org
-- 
1.8.3.1
