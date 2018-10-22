Received: from eggs.gnu.org ([2001:4830:134:3::10]:46322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZn6-0000h2-Ee
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZn4-0008O1-HC
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:40 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33785 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEZn2-00089s-Fw
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:38 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 22 Oct 2018 14:57:56 +0200
Message-Id: <1540213077-15211-34-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 33/34] target/mips: Fix the title of translate.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Replace MIPS32 with MIPS, since the file covers all generations
of MIPS architectures.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 6c50485..4db21b3 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1,5 +1,5 @@
 /*
- *  MIPS32 emulation for qemu: main translation routines.
+ *  MIPS emulation for QEMU: main translation routines.
  *
  *  Copyright (c) 2004-2005 Jocelyn Mayer
  *  Copyright (c) 2006 Marius Groeger (FPU operations)
-- 
2.7.4
