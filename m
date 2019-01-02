Received: from eggs.gnu.org ([208.118.235.92]:34777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gedfu-0003m1-R4
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 05:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gedfr-0007X3-Nk
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 05:22:58 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed,  2 Jan 2019 10:22:43 +0000
Message-Id: <20190102102243.28822-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] MAINTAINERS: add qemu_vga.ndrv file entry for
 Mac machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

The VGA driver built from Ben's QemuMacDrivers repository is used exclusively
by the Mac machines.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 344cb2d7fd..3da3d103b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -965,6 +965,7 @@ F: include/hw/misc/macio/
 F: include/hw/misc/mos6522.h
 F: include/hw/ppc/mac_dbdma.h
 F: include/hw/pci-host/uninorth.h
+F: pc-bios/qemu_vga.ndrv
 
 Old World
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
@@ -976,6 +977,7 @@ F: hw/pci-host/grackle.c
 F: hw/misc/macio/
 F: hw/intc/heathrow_pic.c
 F: include/hw/intc/heathrow_pic.h
+F: pc-bios/qemu_vga.ndrv
 
 PReP
 M: Hervé Poussineau <hpoussin@reactos.org>
-- 
2.11.0
