Received: from eggs.gnu.org ([2001:4830:134:3::10]:34483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gYwFe-0008Ej-4D
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 12:00:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gYwFY-00030e-GY
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 12:00:18 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:35493 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gYwFY-0002xV-6o
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 12:00:12 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 17 Dec 2018 18:00:00 +0100
Message-Id: <20181217170000.4884-4-aleksandar.markovic@rt-rk.com>
In-Reply-To: <20181217170000.4884-1-aleksandar.markovic@rt-rk.com>
References: <20181217170000.4884-1-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 3/3] MAINTAINERS: target/mips: Reorder items
 alphabetically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, smarkovic@wavecomp.com, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Reorder items alphabetically for better visibility.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 MAINTAINERS | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3dda82d31e..0909a24e97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -207,18 +207,18 @@ R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: target/mips/
 F: default-configs/*mips*
+F: disas/mips.c
+F: disas/nanomips.cpp
+F: disas/nanomips.h
+F: hw/intc/mips_gic.c
 F: hw/mips/
 F: hw/misc/mips_*
-F: hw/intc/mips_gic.c
 F: hw/timer/mips_gictimer.c
+F: include/hw/intc/mips_gic.h
 F: include/hw/mips/
 F: include/hw/misc/mips_*
-F: include/hw/intc/mips_gic.h
 F: include/hw/timer/mips_gictimer.h
 F: tests/tcg/mips/
-F: disas/mips.c
-F: disas/nanomips.h
-F: disas/nanomips.cpp
 K: ^Subject:.*(?i)mips?
 
 Moxie
-- 
2.17.1
