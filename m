Received: from eggs.gnu.org ([2001:4830:134:3::10]:35652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtaV-0002os-Mt
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtaU-0001SN-Av
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:51 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cLtaU-0001S3-4d
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:50 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtaT-0003yB-9o
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:22:49 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 15:21:15 +0000
Message-Id: <1482852077-19397-24-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
References: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 23/25] hw/arm: remove trailing whitespace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alastair D'Silva <alastair@d-silva.org>

Remove trailing whitespace in hw/arm/pxa2xx.c

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
Message-id: 20161202054617.6749-3-alastair@au1.ibm.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/pxa2xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 21ea1d6..8aa0f8a 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -2070,7 +2070,7 @@ PXA2xxState *pxa270_init(MemoryRegion *address_space,
     }
     if (!revision)
         revision = "pxa270";
-    
+
     s->cpu = cpu_arm_init(revision);
     if (s->cpu == NULL) {
         fprintf(stderr, "Unable to find CPU definition\n");
-- 
2.7.4
