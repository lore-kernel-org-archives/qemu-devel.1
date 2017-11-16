Received: from eggs.gnu.org ([2001:4830:134:3::10]:56836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1eFQA0-0004fn-JG
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 14:49:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1eFQ9v-0004yg-Oz
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 14:49:16 -0500
From: Stefan Weil <sw@weilnetz.de>
Date: Thu, 16 Nov 2017 20:49:02 +0100
Message-Id: <20171116194902.5887-1-sw@weilnetz.de>
Subject: [Qemu-devel] [PATCH for-2.11] MAINTAINERS: Add missing entry for
 eepro100 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ffd77b461c..83434e09af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1183,6 +1183,11 @@ M: Dmitry Fleytman <dmitry@daynix.com>
 S: Maintained
 F: hw/net/e1000e*
 
+eepro100
+M: Stefan Weil <sw@weilnetz.de>
+S: Maintained
+F: hw/net/eepro100.c
+
 Generic Loader
 M: Alistair Francis <alistair.francis@xilinx.com>
 S: Maintained
-- 
2.11.0
