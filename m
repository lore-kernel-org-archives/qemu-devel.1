Received: from eggs.gnu.org ([2001:4830:134:3::10]:58201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fXXl4-0002g8-Ka
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 16:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fXXkz-0002MK-JA
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 16:06:42 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:40225 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fXXkz-00023H-Az
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 16:06:37 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 25 Jun 2018 22:05:56 +0200
Message-Id: <1529957164-4744-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1529957164-4744-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1529957164-4744-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 1/9] MAINTAINERS: update target-mips maintainers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Aleksandar Markovic <aleksandar.markovic@mips.com>

Yongbok Kim transfers duties of QEMU for target MIPS maintainer to
myself as he leaves MIPS. Many thanks to Yongbok for his substantial
contributing to QEMU for MIPS over many years and taking care of its
maintainance for almost two years.

Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
Acked-by: Yongbok Kim <yongbok.kim@mips.com>
Reviewed-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2874ddc..0f62dca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -187,7 +187,7 @@ F: disas/microblaze.c
 
 MIPS
 M: Aurelien Jarno <aurelien@aurel32.net>
-M: Yongbok Kim <yongbok.kim@mips.com>
+M: Aleksandar Markovic <aleksandar.markovic@mips.com>
 S: Maintained
 F: target/mips/
 F: hw/mips/
@@ -706,7 +706,7 @@ S: Maintained
 F: hw/mips/mips_malta.c
 
 Mipssim
-M: Yongbok Kim <yongbok.kim@mips.com>
+M: Aleksandar Markovic <aleksandar.markovic@mips.com>
 S: Odd Fixes
 F: hw/mips/mips_mipssim.c
 F: hw/net/mipsnet.c
@@ -717,7 +717,7 @@ S: Maintained
 F: hw/mips/mips_r4k.c
 
 Fulong 2E
-M: Yongbok Kim <yongbok.kim@mips.com>
+M: Aleksandar Markovic <aleksandar.markovic@mips.com>
 S: Odd Fixes
 F: hw/mips/mips_fulong2e.c
 F: hw/isa/vt82c686.c
-- 
2.7.4
