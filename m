Received: from eggs.gnu.org ([2001:4830:134:3::10]:49668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gAdfe-000639-Rn
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 12:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gAdfa-0004xl-TP
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 12:18:42 -0400
Received: from m12-16.163.com ([220.181.12.16]:33142)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gAdfX-0004uI-75
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 12:18:38 -0400
From: Li Qiang <liq3ea@163.com>
Date: Thu, 11 Oct 2018 09:18:20 -0700
Message-Id: <20181011161820.38794-1-liq3ea@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] piix_pci: change the i440fx data sheet link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org, philmd@redhat.com, Li Qiang <liq3ea@163.com>

Seems the intel link is unavailable, change it to qemu site.

Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/pci-host/piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 0e608347c1..56a42055f1 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -40,7 +40,7 @@
 
 /*
  * I440FX chipset data sheet.
- * http://download.intel.com/design/chipsets/datashts/29054901.pdf
+ * https://wiki.qemu.org/File:29054901.pdf
  */
 
 #define I440FX_PCI_HOST_BRIDGE(obj) \
-- 
2.17.1
