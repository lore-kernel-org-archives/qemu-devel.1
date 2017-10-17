Received: from eggs.gnu.org ([2001:4830:134:3::10]:50001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1e4Tfc-0006ig-7Y
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1e4TfY-0004xd-5k
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:20:40 -0400
Received: from mailapp02.imgtec.com ([217.156.133.132]:19480
	helo=mailapp01.imgtec.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1e4TfX-0004uz-WF
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:20:36 -0400
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
	by Forcepoint Email with ESMTPS id ABA2437DFE734
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 16:20:26 +0100 (IST)
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Tue, 17 Oct 2017 16:20:25 +0100
Message-ID: <1508253625-5269-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] MAINTAINERS: update email address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Update my email address to mips.com

Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 MAINTAINERS |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9522d1b..726b151 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -162,7 +162,7 @@ F: disas/microblaze.c
 
 MIPS
 M: Aurelien Jarno <aurelien@aurel32.net>
-M: Yongbok Kim <yongbok.kim@imgtec.com>
+M: Yongbok Kim <yongbok.kim@mips.com>
 S: Maintained
 F: target/mips/
 F: hw/mips/
@@ -623,7 +623,7 @@ S: Maintained
 F: hw/mips/mips_malta.c
 
 Mipssim
-M: Yongbok Kim <yongbok.kim@imgtec.com>
+M: Yongbok Kim <yongbok.kim@mips.com>
 S: Odd Fixes
 F: hw/mips/mips_mipssim.c
 F: hw/net/mipsnet.c
@@ -634,7 +634,7 @@ S: Maintained
 F: hw/mips/mips_r4k.c
 
 Fulong 2E
-M: Yongbok Kim <yongbok.kim@imgtec.com>
+M: Yongbok Kim <yongbok.kim@mips.com>
 S: Odd Fixes
 F: hw/mips/mips_fulong2e.c
 
-- 
1.7.1
