Received: from eggs.gnu.org ([209.51.188.92]:32959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1goEME-0008Fi-Vs
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 16:22:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1goEMC-0001RR-Rc
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 16:22:18 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon, 28 Jan 2019 21:21:56 +0000
Message-Id: <20190128212157.424-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190128212157.424-1-mark.cave-ayland@ilande.co.uk>
References: <20190128212157.424-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 1/2] MAINTAINERS: add myself as maintainer for
 Mac Old World and New World machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

I've unofficially been doing most of the work on the Mac machines for a while
now, so update MAINTAINERS to reflect this. David is still happy to be listed
as a reviewer as per our discussion at KVM forum.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 59e1f24d68..14b0ed95c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -970,7 +970,8 @@ F: hw/ppc/mpc8544ds.c
 F: hw/ppc/mpc8544_guts.c
 
 New World (mac99)
-M: David Gibson <david@gibson.dropbear.id.au>
+M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
+R: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/ppc/mac_newworld.c
@@ -988,7 +989,8 @@ F: include/hw/input/adb*
 F: pc-bios/qemu_vga.ndrv
 
 Old World (g3beige)
-M: David Gibson <david@gibson.dropbear.id.au>
+M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
+R: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/ppc/mac_oldworld.c
-- 
2.11.0
