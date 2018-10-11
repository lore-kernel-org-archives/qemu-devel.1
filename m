Received: from eggs.gnu.org ([2001:4830:134:3::10]:50201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gAcD5-0003hB-Gr
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gAcD0-00087P-2c
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:45:07 -0400
Received: from m12-16.163.com ([220.181.12.16]:34225)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gAcCx-00084c-LV
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:45:01 -0400
From: Li Qiang <liq3ea@163.com>
Date: Thu, 11 Oct 2018 07:44:51 -0700
Message-Id: <20181011144451.38042-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH] piix_pci: change the i440fx data sheet link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

Seems the intel link is unavailable, change it to qemu site.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/pci-host/piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 0e608347c1..e709abeb08 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -40,7 +40,7 @@
 
 /*
  * I440FX chipset data sheet.
- * http://download.intel.com/design/chipsets/datashts/29054901.pdf
+ * https://wiki.qemu.org/images/b/bb/29054901.pdf
  */
 
 #define I440FX_PCI_HOST_BRIDGE(obj) \
-- 
2.17.1
