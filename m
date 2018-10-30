Received: from eggs.gnu.org ([2001:4830:134:3::10]:54967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1gHQW2-0005wC-I9
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1gHQVz-0001k6-AN
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:40:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:57374 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1gHQVz-0001jh-3I
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:40:47 -0400
From: Alexander Graf <agraf@suse.de>
Date: Tue, 30 Oct 2018 10:40:45 +0100
Message-Id: <20181030094045.19147-1-agraf@suse.de>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: DT: Remove myself and degrade
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

I haven't really maintained the device tree infrastructure in QEMU for a long
time by now. I also haven't seen Peter work on the code for the last 2 years,
so let's put it into Odd Fixes to make room for others to step up :).

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8bc9a594da..08ea12172e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1548,8 +1548,7 @@ F: include/qom/cpu.h
 
 Device Tree
 M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
-M: Alexander Graf <agraf@suse.de>
-S: Maintained
+S: Odd Fixes
 F: device_tree.c
 F: include/sysemu/device_tree.h
 
-- 
2.12.3
